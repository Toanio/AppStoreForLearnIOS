//
//  ReviewCell.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 06.12.2022.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18), numberOfLines: 0)
    
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    
    let starsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 14))
    
    let starStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach({ _ in
            let imageView = UIImageView(image: UIImage(named: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubviews.append(imageView)
        })
        arrangedSubviews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()
    
    let bodyLabel = UILabel(text: " Review body \n Review body \n Review body \n", font: .systemFont(ofSize: 16), numberOfLines: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                titleLabel,UIView(), authorLabel
            ], customSpacing: 8),
            starStackView,
            bodyLabel
        ], spacing: 12)
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
