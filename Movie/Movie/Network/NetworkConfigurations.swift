//
//  NetworkConfigurations.swift
//  Movie
//
//  Created by Izaz Uddin on 26.11.25.
//


import SwiftUI
import Foundation
import Combine

struct NetworkConfigurations {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let imageDownloaderBaseURL = "https://image.tmdb.org/t/p/w500"
    static let discoverMovie = "discover/movie?sort_by=popularity.desc"
    static let searchMovie = "search/movie"
    static let authorizationToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZWZlNzZlMDAyYzAwNjI3M2YyMzk0M2UzMzVlYTVkZiIsIm5iZiI6MTc1Mzc5NjMxMS4zNzc5OTk4LCJzdWIiOiI2ODg4Y2VkN2UwODhkNTc4Yzc4YTdiODEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.zLX6TY0n566zPaW1nJScNkOB0duvXYWt-BOyRBzMpB0"
}
