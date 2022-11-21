//
//  SearchResultCell.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 21.11.2022.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    let appIconeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = " APP Name"
        return label
        
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Video"
        return label
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.26M"
        return label
        
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = .darkGray
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        let labelStackView = UIStackView(arrangedSubviews: [
            nameLabel, categoryLabel, ratingsLabel
        ])
        labelStackView.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [
            appIconeImageView, labelStackView, getButton
        ])
        stackView.spacing = 12
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
