//
//  CachedAsyncImage.swift
//  Movie
//
//  Created by Izaz Uddin on 28.11.25.
//

import SwiftUI

struct CachedAsyncImage: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: () -> AnyView

    init(url: URL?, @ViewBuilder placeholder: @escaping () -> AnyView = { AnyView(ProgressView()) }) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if let img = loader.image {
                Image(uiImage: img)
                    .resizable()
            } else {
                placeholder()
            }
        }
        .task {
            await loader.load()
        }
    }
}
