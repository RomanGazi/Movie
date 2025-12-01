//
//  MovieDetailView.swift
//  Movie
//
//  Created by Izaz Uddin on 28.11.25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: LatestMovies
    
    var body: some View {
        ZStack {
            BackgroundView()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if movie.backdrop_path != nil {
                        //Here Caching isn't applied cause there is no scrolling in details page.
                        AsyncImage(url: APIEndpoint.moviePoster(path: movie.backdrop_path ?? "").url) { phase in
                            switch phase {
                            case .empty:
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .overlay(ProgressView())
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure:
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(height: 250)
                        .clipped()
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(movie.title)
                            .font(.title)
                            .fontWeight(.bold)
                        HStack(spacing: 20) {
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text(movie.formattedRating)
                                    .fontWeight(.semibold)
                            }
                            
                            Text(movie.release_date)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                        }
                        
                        Divider()
                        
                        Text("Overview")
                            .font(.headline)
                        Text(movie.overview)
                            .font(.body)
                            .foregroundColor(.secondary)
                        Divider()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Popularity")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(String(format: "%.1f", movie.popularity))
                                    .font(.headline)
                            }
                            Spacer()
                        }
                    }
                    .padding(.all, 32)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MovieDetailView(movie: LatestMovies(id: 1, title: "Test", release_date: "2023-01-01", poster_path: "", overview: "Hello Test", vote_average: 6.7, vote_count: 56, original_language: "en", backdrop_path: "", popularity: 1.2))
}
