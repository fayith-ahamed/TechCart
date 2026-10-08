//
//  ProductListView.swift
//  TechCart
//
//  Created by Fayith  on 22/09/26.
//

import SwiftUI

struct ProductListView: View {
    
    @State private var viewModel: ProductListViewModel
    
    private let imageCache: ImageCache
    
    init(viewModel: ProductListViewModel, imageCache: ImageCache) {
        _viewModel = State(initialValue: viewModel)
        self.imageCache = imageCache
    }
    
    var body: some View {
        
        NavigationStack {
            
            Group{
                
                if viewModel.isLoading && viewModel.products.isEmpty {
                    ProgressView("Loading Products...")
                    
                }
                else if let error = viewModel.errorMessage, viewModel.products.isEmpty {
                    
                    VStack(spacing: 12) {
                        
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                        
                        Text(error)
                            .multilineTextAlignment(.center)
                        
                        Button("Retry") {
                            
                            Task {
                                await viewModel.loadInitialProducts()
                            }
                        }
                        
                    }
                    .padding()
                }
                else {
                    productList
                    
                }
                
            }
            .navigationTitle("TechCart")
        }
        .task {
            await viewModel.loadInitialProducts()
        }
        
    }
    
    private var productList: some View {
        
        List {
            
            ForEach(viewModel.products) { product in
                
                
                ProductRowView(
                    product: product,
                    imageCache: imageCache
                )
                .onAppear {
                    
                    if product.id == viewModel.products.last?.id {
                        
                        Task {
                            await viewModel.loadMoreProducts()
                        }
                    }
                    
                }
                
                
            }
            if viewModel.isLoadingMore {
                
                HStack {
                    Spacer()
                    
                    ProgressView()
                    
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
    
    
    
}
