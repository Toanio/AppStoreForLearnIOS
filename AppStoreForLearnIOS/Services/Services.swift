//
//  Services.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 22.11.2022.
//

import Foundation

class Services {
    static let shared = Services()
    
    func fetchApps(searchTerm: String, complition: @escaping ([Result], Error? ) -> ()) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed: ", error)
                complition([], nil)
            }
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                complition(searchResult.results, nil)
                
            } catch let jsonErr{
                print("Failed json: ", jsonErr)
                complition([], jsonErr)
            }
            
        }.resume()
    }
    
    func fetchFreeApps(complition: @escaping (AppsGroupResult? , Error?) -> ()) {
      fetchAppGroups(urlString: "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/10/apps.json", complition: complition)
    }
    
    func fetchFreeBooks(complition: @escaping (AppsGroupResult? , Error?) -> ()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/books/top-free/10/books.json"
        fetchAppGroups(urlString: urlString, complition: complition)
    }
    
    func fetchMostPlayedMusic(complition: @escaping (AppsGroupResult? , Error?) -> ()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/10/albums.json"
        fetchAppGroups(urlString: urlString, complition: complition)
    }
    
    func fetchAppGroups(urlString: String, complition: @escaping (AppsGroupResult? , Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
           if let error = error {
               complition(nil, error)
                return
            }
            do {
                let appsResult = try JSONDecoder().decode(AppsGroupResult.self, from: data!)
                complition(appsResult, nil)
            } catch {
                print("Failed to fetch ", error)
            }
        }.resume()
    }
    
    func fetchSocialApp(complition: @escaping ([SocialApp]?, Error?) -> Void ) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
           if let error = error {
               complition(nil, error)
                return
            }
            do {
                let objects = try JSONDecoder().decode([SocialApp].self, from: data!)
                complition(objects, nil)
            } catch {
                print("Failed to fetch ", error)
            }
        }.resume()
        
    }
}



