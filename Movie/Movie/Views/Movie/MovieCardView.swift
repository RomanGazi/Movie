//
//  MovieCardView.swift
//  Movie
//
//  Created by Izaz Uddin on 27.11.25.
//

import SwiftUI

struct MovieCardView: View {
    let movie: LatestMovies
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            //Here for smoother user experience landing pages movie's poster are cached. So that every time don't need to download images.
            CachedAsyncImage(
                url: APIEndpoint.moviePoster(path: movie.poster_path ?? "").url
            ) {
                AnyView(
                    ZStack {
                        Color.gray.opacity(0.15)
                        Image(systemName: "film")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                        .cornerRadius(8)
                )
            }
            .frame(width: 100, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                        Text(movie.formattedRating)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Text("Released in \(movie.releaseYear)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
    }
}
