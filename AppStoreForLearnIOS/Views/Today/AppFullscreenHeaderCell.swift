//
//  AppFullscreenHeaderCell.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 09.12.2022.
//

import UIKit

class AppFullscreenHeaderCell: UITableViewCell {
    let todayCell = TodayCell()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(todayCell)
        todayCell.fillSuperview()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
