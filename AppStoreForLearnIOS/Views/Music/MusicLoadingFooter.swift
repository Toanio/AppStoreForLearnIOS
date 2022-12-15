//
//  MusicLoadingFooter.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 15.12.2022.
//

import UIKit

class MusicLoadingFooter: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.startAnimating()
        
        let loadingLabel = UILabel(text: "Loading more...", font: .systemFont(ofSize: 16))
        loadingLabel.textAlignment = .center
        
        let stackView = VerticalStackView(arrangedSubviews: [
            aiv,
            loadingLabel
        ], spacing: 4)
        
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 200, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
