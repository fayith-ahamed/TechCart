//
//  CachedAsyncImage.swift
//  TechCart
//
//  Created by Fayith  on 09/10/26.
//

import SwiftUI

struct CachedAsyncImage: View {
  
    let url: URL?
    
    @State private var loader: ImageLoader
    
    init(
        url: URL?,
        cache: ImageCache
    ) {
        self.url = url
        
        _loader = State(initialValue: ImageLoader(cache: cache))
        
    }
    
    var body: some View {
        
        Group {
            
            if let image = loader.image {
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if loader.isLoading {
                ProgressView()
                    
            } else if loader.didFail {
                
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
                    
            } else {
                Color.gray.opacity(0.08)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
        .task(id: url) {
            await loader.load(from: url)
        }
    }
}
