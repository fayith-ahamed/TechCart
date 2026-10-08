//
//  ImageCache.swift
//  TechCart
//
//  Created by Fayith  on 11/09/26.
//

import UIKit

final class ImageCache {
    
    private let cache = NSCache<NSURL, UIImage>()
    
    init(
        countLimit: Int = 150,
        totalCostLimit: Int = 50 * 1024 * 1024
    ) {
        
        cache.countLimit = countLimit
        cache.totalCostLimit = totalCostLimit
    }
    
    func image(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }
    
    func insert(_ image: UIImage, for url: URL) {
        
        let cost = image.cgImage.map {
            $0.bytesPerRow * $0.height
        } ?? 0
        
        cache.setObject(image, forKey: url as NSURL, cost: cost)
    }
    
    func remove(for url: URL) {
        cache.removeObject(forKey: url as NSURL)
    }
    
    func clear() {
        cache.removeAllObjects()
    }
}
