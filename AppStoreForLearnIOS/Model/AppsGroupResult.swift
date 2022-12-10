//
//  AppsGroupResult.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 26.11.2022.
//

import Foundation

struct AppsGroupResult: Decodable {
    let feed: Feed?
}

struct Feed: Decodable {
    let title: String
    let results: [AppsResult]
}

struct AppsResult: Decodable {
    let id, name, artistName, artworkUrl100: String
}
