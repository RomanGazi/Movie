//
//  NetworkService.swift
//  Movie
//
//  Created by Izaz Uddin on 26.11.25.
//


import SwiftUI
import Foundation
import Combine

final class NetworkService {
    static let shared = NetworkService()

    func request <T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        guard var request = endpoint.urlRequest else {
            throw APIError.invalidURL
        }
        
        request.addValue(NetworkConfigurations.authorizationToken, forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200..<300).contains(http.statusCode) else {
            throw APIError.statusCode(http.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
}
