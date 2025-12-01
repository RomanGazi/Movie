//
//  MovieResponse.swift
//  Movie
//
//  Created by Izaz Uddin on 26.11.25.
//

import SwiftUI
import Foundation
import Combine

struct MovieResponse: Codable {
    let page: Int
    let results: [LatestMovies]
    let total_pages: Int
}
