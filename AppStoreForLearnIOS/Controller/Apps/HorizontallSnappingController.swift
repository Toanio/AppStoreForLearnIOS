//
//  HorizontallSnappingController.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 02.12.2022.
//

import UIKit

class HorizontallSnappingController: UICollectionViewController {
    init() {
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
