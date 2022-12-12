//
//  TodayController.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 07.12.2022.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout {
//    let cellId = "cellId"
//    let multipleAppId = "multipleAppId"
    
//    let items = [

//
//    ]
    
    var items = [TodayItem]()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        
        fetchData()
        
        navigationController?.isNavigationBarHidden = true
        
        collectionView.backgroundColor = UIColor(red: 210/255, green: 210/255 , blue: 210/255, alpha: 1 )
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
    }
    
    private func fetchData() {
        let dispatchGroup = DispatchGroup()
        var freeApp: AppsGroupResult?
        var freeBook: AppsGroupResult?
        dispatchGroup.enter()
        Services.shared.fetchFreeApps { appResult, error in
            freeApp = appResult
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        Services.shared.fetchFreeBooks { appResult, error in
            freeBook = appResult
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            print("Finishing fetch data")
            self.activityIndicatorView.stopAnimating()
            self.items = [
                TodayItem.init(category: "THE DAILY LIST", title: freeApp?.feed?.title ?? "", image: UIImage(named: "garden")!, description: "", backgroundColor: .white, cellType: .multiple, apps: freeApp?.feed?.results ?? []),
                
                TodayItem.init(category: "THE DAILY LIST", title: freeBook?.feed?.title ?? "", image: UIImage(named: "garden")!, description: "", backgroundColor: .white, cellType: .multiple, apps: freeBook?.feed?.results ?? []),
                
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your time", image: UIImage(named: "garden")!, description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: []),
                                 
                TodayItem.init(category: "HOLIDAYS", title: "Travel on Budget", image: UIImage(named: "holiday")!, description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: UIColor(red: 249/255, green: 245/255, blue: 186/255, alpha: 1), cellType: .single, apps: []),
            ]
            self.collectionView.reloadData()
        }
        
    }
    var appFullscreenController: AppFullscreenController!
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstrint: NSLayoutConstraint?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if items[indexPath.item].cellType == .multiple {
            let fullController = TodayMultipleAppController(mode: .fullscreen)
            fullController.result = self.items[indexPath.item].apps
            let navController = BackEnabledNavigationController(rootViewController: fullController)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true)
            return
        }
        
        
        
        let appFullscreenController = AppFullscreenController()
        appFullscreenController.todayItem = items[indexPath.item]
        appFullscreenController.dismissHandler = {
            self.handleRemoveRedView()
        }
        let fullscreenView = appFullscreenController.view!

        fullscreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
        view.addSubview(fullscreenView)
        addChild(appFullscreenController)
        
        
        self.appFullscreenController = appFullscreenController
        
        self.collectionView.isUserInteractionEnabled = false
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
        
        //redView.frame = startingFrame
        fullscreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = fullscreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y )
        leadingConstraint = fullscreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x )
        widthConstraint = fullscreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstrint = fullscreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        [topConstraint, leadingConstraint, widthConstraint, heightConstrint].forEach({$0?.isActive = true})
        
        self.view.layoutIfNeeded()
        
        fullscreenView.layer.cornerRadius = 16
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            fullscreenView.frame = self.view.frame
            
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstrint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.isHidden = true
            
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    var startingFrame: CGRect?
    
    @objc func handleRemoveRedView() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, animations: {
            
            self.appFullscreenController.tableView.contentOffset = .zero

            
            guard let startingFrame = self.startingFrame else { return }
            
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstrint?.constant = startingFrame.height
            
            self.view.layoutIfNeeded()
            
            
            self.tabBarController?.tabBar.isHidden = false
            
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 24
            cell.layoutIfNeeded()
            
        }, completion: { _ in
            //gesture.view?.removeFromSuperview()
            self.appFullscreenController.view.removeFromSuperview()
            self.appFullscreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = items[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        
        (cell as? TodayMultipleAppCell)?.multipleAppController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppTap)))
        return cell
    }
    //разобраться с этим кодом
    @objc private func handleMultipleAppTap(gesture: UIGestureRecognizer) {
        let collectionView = gesture.view
        
        
        
        var superview = collectionView?.superview

        while superview != nil {
            if let cell = superview as? TodayMultipleAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }

                let apps = self.items[indexPath.item].apps

                let fullController = TodayMultipleAppController(mode: .fullscreen)
                fullController.result = apps
                let navController = BackEnabledNavigationController(rootViewController: fullController)
                navController.modalPresentationStyle = .fullScreen
                present(navController, animated: true)
            }
            superview = superview?.superview
        }
    }
    static let cellSize: CGFloat = 500
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayController.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
