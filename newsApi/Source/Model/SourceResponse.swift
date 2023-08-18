//
//  SourceResponse.swift
//  newsApi
//
//  Created by Hastomi Riduan Munthe on 18/08/23.
//

import Foundation

struct SourceResponse: Decodable {
    let name: String?
    let description: String?
    let url: String?
    let id: String?
    let urlToImage: String?
}

struct SourcesResponse: Decodable {
    let status: String?
    let sources: [SourceResponse]?
}
