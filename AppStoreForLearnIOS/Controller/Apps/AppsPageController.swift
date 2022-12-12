//
//  AppsController.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 23.11.2022.
//

import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {
    let identifier = "id"
    let headerId = "headerId"
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .medium)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        activityIndicatorView.fillSuperview()
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: identifier)
        
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchData()
    }
    
    
    
    var groups = [AppsGroupResult]()
    var socialApp = [SocialApp]()
    
    private func fetchData() {
        var group1: AppsGroupResult?
        var group2: AppsGroupResult?
        var group3: AppsGroupResult?
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        Services.shared.fetchFreeApps { appGroup, error in
            dispatchGroup.leave()
            group1 = appGroup
        }
        dispatchGroup.enter()
        Services.shared.fetchFreeBooks { appGroup, error in
            dispatchGroup.leave()
           group2 = appGroup
        }
        dispatchGroup.enter()
        Services.shared.fetchMostPlayedMusic { appGroup, error in
            dispatchGroup.leave()
            group3 = appGroup
        }
        dispatchGroup.enter()
        Services.shared.fetchSocialApp { apps, error in
            dispatchGroup.leave()
            self.socialApp = apps ?? []
        }
        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            
            if let group = group1 {
                self.groups.append(group)
            }
            
            if let group = group2 {
                self.groups.append(group)
            }
            
            if let group = group3 {
                self.groups.append(group)
            }
            
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
        header.appsHeaderHorizontalController.socialApp = self.socialApp
        header.appsHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! AppsGroupCell
        let appGroup = groups[indexPath.row]
        
        cell.titleLabel.text = appGroup.feed?.title
        cell.horizontalController.appGroup = appGroup
        cell.horizontalController.collectionView.reloadData()
        cell.horizontalController.didSelectHandler = { appResult in
            let controller = AppDetailController(appId: appResult.id)
            controller.navigationItem.title = appResult.name
            self.navigationController?.pushViewController(controller, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
   
}
