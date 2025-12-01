//
//  ImageLoader.swift
//  Movie
//
//  Created by Izaz Uddin on 28.11.25.
//

import SwiftUI
import Combine

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private let url: URL?

    init(url: URL?) {
        self.url = url
    }

    func load() async {
        guard let url = url else { return }
        
        // Check cache first for images
        if let cached = ImageCache.shared.get(forKey: url.absoluteString) {
            self.image = cached
            return
        }
        
        // Otherwise download image and cache it.
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let downloaded = UIImage(data: data) {
                // Save to cache
                ImageCache.shared.set(downloaded, forKey: url.absoluteString)
                self.image = downloaded
            }
        } catch {
            if (error as? URLError)?.code == .cancelled {
                return
            }
            print("Image download failed:", error)
        }
    }
}
