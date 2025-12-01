//
//  APIEndpoint.swift
//  Movie
//
//  Created by Izaz Uddin on 26.11.25.
//


import SwiftUI
import Foundation
import Combine

enum APIEndpoint {
    case movies(page: Int)
    case search(query: String)
    case moviePoster(path: String)
}

extension APIEndpoint {
    var url: URL? {
        switch self {
        case .movies(let page):
            return URL(string: NetworkConfigurations.baseURL + NetworkConfigurations.discoverMovie + "&page=\(page)")
        case .search(let query):
            return URL(string: NetworkConfigurations.baseURL + NetworkConfigurations.searchMovie + "?query=\(query)")
        case .moviePoster(let path):
            return URL(string: NetworkConfigurations.imageDownloaderBaseURL + path)
        }
    }

    var urlRequest: URLRequest? {
        guard let url = url else { return nil }
        return URLRequest(url: url)
    }
}
