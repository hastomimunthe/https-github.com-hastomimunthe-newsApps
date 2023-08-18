//
//  ApiManager.swift
//  newsApi
//
//  Created by Hastomi Riduan Munthe on 18/08/23.
//

import Foundation

import Foundation
import Alamofire

class ApiManager {
    
    private let apiKey = "3d45463c8b7d40a8a402598535ac2b11"
    
    func getNews(source: String, keyword: String?, didGetArticle: @escaping (([Article]) -> Void)) {
        var parameters = ["apiKey": apiKey, "sources": source]
        if let checkedKeyword = keyword {
            parameters["q"] = checkedKeyword
        }
        
        AF.request("https://newsapi.org/v2/top-headlines",
                   method: .get,
                   parameters: parameters
        ).responseData { response in
            switch response.result {
            case let .success(data):
                print(data)
                if let decodable = try? JSONDecoder().decode(NewsResponse.self, from: data) {
                    dump(decodable.articles ?? [])
                    didGetArticle(decodable.articles ?? [])
                } else {
                    print("failed to decode")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getSources(category: String, didGetSources: @escaping ((Result<[SourceResponse], NSError>) -> Void)) {
        let parameters = ["apiKey": apiKey, "category": category]
        AF.request("https://newsapi.org/v2/top-headlines/sources",
                   method: .get,
                   parameters: parameters
        ).responseData { response in
            switch response.result {
            case let .success(data):
                print(data)
                if response.response?.statusCode == 200, let decodable = try? JSONDecoder().decode(SourcesResponse.self, from: data) {
                    let result = decodable.sources ?? []
                    didGetSources(.success(result))
                } else {
                    let nsError = NSError(domain: "Failed to Decode", code: 500)
                    didGetSources(.failure(nsError))
                }
            case let .failure(error):
                didGetSources(.failure(error as NSError))
            }
        }
    }
}
