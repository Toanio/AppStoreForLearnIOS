//
//  AppsPageHeader.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 25.11.2022.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
    
    let appsHeaderHorizontalController = AppsHeaderHorizontalController()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(appsHeaderHorizontalController.view)
        appsHeaderHorizontalController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
