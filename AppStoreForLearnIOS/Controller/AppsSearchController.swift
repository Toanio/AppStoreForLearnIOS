//
//  AppsSearchController.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 18.11.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var appResult = [Result]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        fetchITunesApps()
    }
    
    func fetchITunesApps(){
        Services.shared.fetchApps { (results, error) in
            if let error = error {
                print("Failed to fetch apps: ", error)
                return
            }
            
            self.appResult = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width, height: 350)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResult.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchResultCell
        cell.appResult = appResult[indexPath.item]
        return cell
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
