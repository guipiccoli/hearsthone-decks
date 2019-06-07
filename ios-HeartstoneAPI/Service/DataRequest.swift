//
//  DataRequest.swift
//  ios-HeartstoneAPI
//
//  Created by Guilherme Piccoli on 06/06/19.
//  Copyright © 2019 Guilherme Piccoli. All rights reserved.
//

import Foundation


struct DataRequest {
    
    static func getCards(classCards: String, completionHandler completion: @escaping ([Card]) -> Void) {
        var request = URLRequest(url: URL(string: "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards/classes/\(classCards)")!)
        request.httpMethod = "GET"
        request.addValue("b71a260f20msh8cd4d6e140729d7p137b7fjsn0c0560e5ef09", forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("omgvamp-hearthstone-v1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            guard error == nil else {
                print(error!.localizedDescription)
                completion([])
                return
            }
            do {
                let cards = try JSONDecoder().decode([Card].self, from: data!)
                completion(cards)
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        })
        dataTask.resume()
    }
}
