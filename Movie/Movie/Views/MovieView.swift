//
//  MovieView.swift
//  Movie
//
//  Created by Izaz Uddin on 26.11.25.
//

import SwiftUI

struct MovieView: View {
    
    @StateObject private var viewModel = LatestMoviesViewModel()
    @FocusState private var isSearchFocused: Bool
    @State private var showSearchView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    VStack(spacing: 0) {
                        SearchView(
                            viewModel: viewModel,
                            isSearchFocused: $isSearchFocused
                        )
                        .padding(.top, isSearchFocused ? 30 : 0)
                        .padding(.bottom, isSearchFocused ? 8 : 0)
                        .frame(height: 50)
                        
                        if isSearchFocused && !viewModel.searchSuggestions.isEmpty {
                            SearchAutoCompleteView(
                                viewModel: viewModel,
                                isSearchFocused: $isSearchFocused
                            )
                            .padding(.top, 8)
                        }
                    }
                    if viewModel.isLoading && viewModel.movies.isEmpty {
                        ProgressView("Loading movies...")
                    } else if let error = viewModel.error, viewModel.movies.isEmpty {
                        ErrorView(message: error) {
                            Task {
                                await viewModel.fetchMovies(page: 1)
                            }
                        }
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(viewModel.movies) { movie in
                                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                                        MovieCardView(movie: movie)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .task {
                                        await viewModel.fetchMoreMoviesIfNeeded(currentItem: movie)
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle(isSearchFocused ? "" : "Movies")
                .task {
                    if viewModel.movies.isEmpty {
                        await viewModel.fetchMovies(page: 1)
                    }
                }
            }
        }
    }
}

#Preview {
    MovieView()
}
