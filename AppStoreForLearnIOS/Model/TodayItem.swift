//
//  TodayItem.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 09.12.2022.
//

import UIKit

struct TodayItem {
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    
    let cellType: CellType
    var apps: [AppsResult]
    
    enum CellType: String {
        case single, multiple
    }
}
