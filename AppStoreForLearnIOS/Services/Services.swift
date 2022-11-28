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
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/10/apps.json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
           if let error = error {
               complition(nil, error)
                return
            }
            do {
                let appsResult = try JSONDecoder().decode(AppsGroupResult.self, from: data!)
                appsResult.feed.results.forEach({print($0.name)})
                complition(appsResult, nil)
            } catch {
                print("Failed to fetch ", error)
            }
            
            
            
            
        }.resume()
    }
}



