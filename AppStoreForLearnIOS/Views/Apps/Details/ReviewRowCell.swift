//
//  ReviewRowCell.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 06.12.2022.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    let reviewHorizontalController = ReviewHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        
        addSubview(reviewHorizontalController.view)
        reviewHorizontalController.view.fillSuperview()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
