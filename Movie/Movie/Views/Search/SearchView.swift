//
//  SearchView.swift
//  Movie
//
//  Created by Izaz Uddin on 26.11.25.
//
import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: LatestMoviesViewModel
    var isSearchFocused: FocusState<Bool>.Binding
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search movies...", text: $viewModel.searchText)
                    .focused(isSearchFocused)
                    .onChange(of: viewModel.searchText) { newValue in
                        viewModel.updateSearchSuggestions(query: newValue)
                    }
                    .onSubmit {
                        viewModel.performSearch()
                        isSearchFocused.wrappedValue = false
                    }
                
                if !viewModel.searchText.isEmpty {
                    Button {
                        viewModel.clearSearch()
                        isSearchFocused.wrappedValue = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(8)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            
            if isSearchFocused.wrappedValue {
                Button("Cancel") {
                    isSearchFocused.wrappedValue = false
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}
