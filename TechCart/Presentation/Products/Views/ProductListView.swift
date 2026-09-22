//
//  ProductListView.swift
//  TechCart
//
//  Created by Fayith  on 22/09/26.
//

import SwiftUI

struct ProductListView: View {
    
    @State private var viewModel: ProductListViewModel
    
    init(viewModel: ProductListViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        
        NavigationStack {
            
            Group{
                
                if viewModel.isLoading && viewModel.products.isEmpty {
                    ProgressView("Loading Products...")
                    
                }
                else if let error = viewModel.errorMessage {
                    
                    VStack(spacing: 12) {
                        
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                        
                        Text(error)
                            .multilineTextAlignment(.center)
                        
                        Button("Retry") {
                            
                            Task {
                                await viewModel.loadProducts()
                            }
                        }
                        
                    }
                    .padding()
                }
                else {
                    
                    List(viewModel.products) { product in
                        
                        ProductRowView(product: product)
                        
                    }
                    .listStyle(.plain)
                }
                
            }
            .navigationTitle("TechCart")
        }
        .task {
            await viewModel.loadProducts()
        }
        
    }
    
    
    
    
    
}
