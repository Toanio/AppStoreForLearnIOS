//
//  BaseListController.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 23.11.2022.
//

import UIKit

class BaseListController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
