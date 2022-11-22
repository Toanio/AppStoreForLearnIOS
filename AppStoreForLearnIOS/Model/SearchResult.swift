//
//  SearchResult.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 22.11.2022.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
}
