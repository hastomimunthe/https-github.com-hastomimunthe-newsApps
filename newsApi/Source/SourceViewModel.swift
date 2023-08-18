//
//  SourceViewModel.swift
//  newsApi
//
//  Created by Hastomi Riduan Munthe on 18/08/23.
//

import Foundation

class SourceViewModel {
    
    
    private var apiManager = ApiManager()
    private var sources = [SourceResponse]()
    
    func loadSources(category: String, didLoadSources: @escaping ((Result<[SourceResponse], NSError>) -> Void)) {
        apiManager.getSources(category: category) { result in
            switch result {
            case let .success(data):
                self.sources = data
            default:
                break
            }
            didLoadSources(result)
        }
    }
    
    func searchSource(keyword: String, didSearch: @escaping (([SourceResponse]) -> Void)) {
        let result = sources.filter { source in
            return source.name?.hasPrefix(keyword) == true
        }
        didSearch(result)
    }
}
