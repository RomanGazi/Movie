//
//  LatestMoviesState.swift
//  Movie
//
//  Created by Izaz Uddin on 28.11.25.
//


import SwiftUI
import Foundation
import Combine

struct LatestMoviesState {
    var latestMovies: [LatestMovies] = []
    var isLoading: Bool = false
    var error: String? = nil
    var page = 1
    var hasMorePages = true
}
