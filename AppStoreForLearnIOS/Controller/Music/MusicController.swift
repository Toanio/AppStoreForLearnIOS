//
//  MusicController.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 15.12.2022.
//

import UIKit

class MusicController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let footerId = "footerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(TrackCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(MusicLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
        
        fetchData(searchTerm: "taylor")
    }
    
    var results = [MusicRes]()
    
    let searchTerm = "taylor"
    
    private func fetchData(searchTerm: String) {
        let url = "https://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=20"
        
        Services.shared.fetchGenericJSONData(urlString: url) { (searchResult: MusicResult?, err) in
            if let err = err {
                print("Failed to paginate data: ", err)
                return
            }
            
            self.results = searchResult?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    var isPagition = false
    var isDonePaginating = false
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TrackCell
        let trackName = results[indexPath.item]
        cell.nameLabel.text = trackName.trackName
        cell.imageView.sd_setImage(with: URL(string: trackName.artworkUrl100))
        cell.subtitleLabel.text = "\(trackName.artistName) • \(trackName.collectionName ?? "")"
        
        if indexPath.item == results.count - 1 && !isPagition{
            self.isPagition = true
            let url = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(results.count)&limit=20"
            
            Services.shared.fetchGenericJSONData(urlString: url) { (searchResult: MusicResult?, err) in
                if let err = err {
                    print("Failed to paginate data: ", err)
                    return
                }
                if searchResult?.results.count == 0 {
                    self.isDonePaginating = true
                }
                self.results += searchResult?.results ?? []
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                self.isPagition = false
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = isDonePaginating ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    
}
