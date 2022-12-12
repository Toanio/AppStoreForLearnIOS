//
//  TodayMultipleAppCell.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 11.12.2022.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLable.text = todayItem.title
            multipleAppController.result = todayItem.apps
            multipleAppController.collectionView.reloadData()
        }
    }
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    
    let titleLable = UILabel(text: "Utilizing your time", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)
    
    let multipleAppController = TodayMultipleAppController(mode: .small)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel,
            titleLable,
            multipleAppController.view
        ], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
