//
//  ImageLoader.swift
//  TechCart
//
//  Created by Fayith  on 09/10/26.
//

import Foundation
import Observation
import UIKit


@Observable
@MainActor
final class ImageLoader {
    
    private(set) var image: UIImage?
    private(set) var isLoading = false
    private(set) var didFail = false
    
    private let cache: ImageCache
    private let session: URLSession
    
    init(
        cache: ImageCache,
        session: URLSession = .shared
    ) {
        
        self.cache = cache
        self.session = session
    }
    
    func load(from url: URL?) async {
        
        guard let url else {
            
            didFail = true
            return
        }
        
        
        // Check memory cache first
        if let cacheImage = cache.image(for: url) {
            image = cacheImage
            didFail = false
            return
        }
        
        isLoading = true
        didFail = false
       
        
        defer {
            isLoading = false
        }
        
        do {
            let(data, response) = try await session.data(from: url)
            
            guard !Task.isCancelled else {
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                didFail = true
                return
            }
            
            guard let image = UIImage(data: data) else {
                didFail = true
                return
            }
            
            
            cache.insert(image, for: url)
            
            self.image = image
            
        } catch {
            if Task.isCancelled {
                return
            }
            
            didFail = true
            
            print("Image loading failed: \(url)")
        }
    }
}
