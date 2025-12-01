//
//  LatestMovies.swift
//  Movie
//
//  Created by Izaz Uddin on 26.11.25.
//


import SwiftUI
import Foundation
import Combine

struct LatestMovies: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let release_date: String
    let poster_path: String?
    let overview: String
    let vote_average: Double
    let vote_count: Int
    let original_language: String
    let backdrop_path: String?
    let popularity: Double
    
    var formattedRating: String {
        String(format: "%.1f", vote_average)
        }
        
    var releaseYear: String {
        String(release_date.prefix(4))
    }
}
