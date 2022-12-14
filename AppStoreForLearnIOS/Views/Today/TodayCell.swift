//
//  TodayCell.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 07.12.2022.
//

import UIKit

class TodayCell: BaseTodayCell {
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLable.text = todayItem.title
            imageView.image = todayItem.image
            descriptionLabel.text = todayItem.description
            backgroundColor = todayItem.backgroundColor
            backgroundView?.backgroundColor = todayItem.backgroundColor
        }
    }
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    
    let titleLable = UILabel(text: "Utilizing your time", font: .boldSystemFont(ofSize: 28))
    
    let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "garden"))
        return image
    }()
    
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 16), numberOfLines: 3)
    
    var topConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        imageView.contentMode = .scaleAspectFill
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        
        imageView.centerInSuperview(size: .init(width: 240, height: 240))
        imageView.clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel, titleLable, imageContainerView, descriptionLabel
        ], spacing: 8)
        addSubview(stackView)
        //stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        topConstraint.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
