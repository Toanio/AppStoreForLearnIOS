//
//  Services.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 22.11.2022.
//

import Foundation

class Services {
    static let shared = Services()
    
    func fetchApps(searchTerm: String, complition: @escaping (SearchResult?, Error? ) -> ()) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        fetchGenericJSONData(urlString: urlString, complition: complition)
    }
    
    func fetchFreeApps(complition: @escaping (AppsGroupResult? , Error?) -> ()) {
      let urlString = "https://rss.applemarketingtools.com/api/v2/ru/apps/top-free/10/apps.json"
        fetchGenericJSONData(urlString: urlString, complition: complition)
    }
    
    func fetchFreeBooks(complition: @escaping (AppsGroupResult? , Error?) -> ()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/books/top-free/10/books.json"
        fetchGenericJSONData(urlString: urlString, complition: complition)
    }
    
    func fetchMostPlayedMusic(complition: @escaping (AppsGroupResult? , Error?) -> ()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/10/albums.json"
        fetchGenericJSONData(urlString: urlString, complition: complition)
    }
        
    func fetchSocialApp(complition: @escaping ([SocialApp]?, Error?) -> Void ) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
       fetchGenericJSONData(urlString: urlString, complition: complition)
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, complition: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
           if let error = error {
               complition(nil, error)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                complition(objects, nil)
            } catch {
                print("Failed to fetch ", error)
            }
        }.resume()
    }
}



