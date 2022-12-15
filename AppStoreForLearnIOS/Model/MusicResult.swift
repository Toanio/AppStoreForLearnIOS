//
//  MusicResult.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 15.12.2022.
//

import Foundation

struct MusicResult: Decodable {
    let results: [MusicRes]
}

struct MusicRes: Decodable {
    let trackId: Int?
    let artistName: String
    let trackName: String?
    let artworkUrl100: String
    let collectionName: String?
}

