//
//  LatestMoviesViewModel.swift
//  Movie
//
//  Created by Izaz Uddin on 27.11.25.
//


import SwiftUI
import Foundation
import Combine

@MainActor
final class LatestMoviesViewModel: ObservableObject {
    
    @Published var movies: [LatestMovies] = []
    @Published var isLoading = false
    @Published var error: String?
    @Published var page = 1
    
    @Published var searchText = ""
    @Published var searchSuggestions: [LatestMovies] = []
    @Published var isSearching = false
    
    private var currentTask: Task<Void, Never>?
    private var searchTask: Task<Void, Never>?
    
    func callingAPIforMovies() async throws -> MovieResponse {
        try await NetworkService.shared.request(.movies(page: page))
    }
    
    func searchMovies(_ query: String) async throws -> MovieResponse {
        try await NetworkService.shared.request(.search(query: query))
    }
    
    // This function checks how many movies left to show. When it reaches to the last 5 this function get called.
    func fetchMoreMoviesIfNeeded(currentItem: LatestMovies?) async {
        guard let currentItem else {
            await fetchMovies(page: page)
            return
        }
        
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -5)
        if movies.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            await fetchMovies(page: page)
        }
    }
    
    //This function fetches movies when scrolling is about to end.
    func fetchMovies(page: Int) async {
        guard !isLoading else { return }
        
        currentTask?.cancel()
        
        isLoading = true
        error = nil
        currentTask = Task {
            do {
                let data = try await callingAPIforMovies()
                //Removing duplicate movies whose id matches.
                let movieListWithoutDuplication = data.results.filter { newMovie in
                    !movies.contains(where: { $0.id == newMovie.id })
                }
                movies.append(contentsOf: movieListWithoutDuplication)
                self.page = data.page + 1
            } catch {
                self.error = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    //This function get called when search is called.
    func performSearch() {
        searchTask?.cancel()
        searchSuggestions = []
        
        Task {
            movies = []
            let data = try await searchMovies(searchText)
            movies.append(contentsOf: data.results)
        }
    }
    
    /*This function is for auto complete feature. When user types it shows 5 movies matches with the keyword.
    It waits 3 seconds for user input and then get called to reduce API calling.*/
    func updateSearchSuggestions(query: String) {
        searchTask?.cancel()
        
        guard !query.isEmpty else {
            searchSuggestions = []
            return
        }
        
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            
            guard !Task.isCancelled else { return }
            
            do {
                let response = try await searchMovies(query)
                
                guard !Task.isCancelled else { return }
                searchSuggestions = Array(
                    Dictionary(grouping: response.results, by: { $0.id })
                        .compactMap { $0.value.first }.prefix(5)
                )
            } catch {
                searchSuggestions = []
            }
        }
    }
    
    func selectSuggestion(_ movie: LatestMovies) {
        searchText = movie.title
        searchSuggestions = []
        performSearch()
    }
    
    func clearSearch() {
        searchText = ""
        searchSuggestions = []
        movies = []
        page = 1
        Task {
            await fetchMovies(page: page)
        }
    }
}
