//
//  Services.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 22.11.2022.
//

import Foundation

class Services {
    static let shared = Services()
    
    func fetchApps(complition: @escaping ([Result], Error? ) -> ()) {
        
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
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
}



