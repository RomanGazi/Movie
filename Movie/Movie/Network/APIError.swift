//
//  APIError.swift
//  Movie
//
//  Created by Izaz Uddin on 26.11.25.
//


import SwiftUI
import Foundation
import Combine

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid Response"
        case .statusCode(let code): return "Server returned error \(code)"
        case .decodingError: return "Failed to decode data"
        }
    }
}
