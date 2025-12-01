//
//  SearchAutoCompleteView.swift
//  Movie
//
//  Created by Izaz Uddin on 29.11.25.
//

import SwiftUI

struct SearchAutoCompleteView: View {
    @ObservedObject var viewModel: LatestMoviesViewModel
    var isSearchFocused: FocusState<Bool>.Binding
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.searchSuggestions) { movie in
                Button {
                    viewModel.selectSuggestion(movie)
                    isSearchFocused.wrappedValue = false
                } label: {
                    HStack(spacing: 12) {
                        AsyncImage(url: APIEndpoint.moviePoster(path: movie.poster_path ?? "").url) { response in
                            switch response {
                            case .success(let image):
                                image.resizable().aspectRatio(contentMode: .fill)
                            default:
                                Rectangle().fill(Color.gray.opacity(0.3))
                            }
                        }
                        .frame(width: 40, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        
                        Text(movie.title)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding(.all)
                }
                Divider()
            }
        }
        .background(Color.white.opacity(0.9))
    }
}
