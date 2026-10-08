//
//  ProductListViewModel.swift
//  TechCart
//
//  Created by Fayith  on 22/09/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class ProductListViewModel {
    
    private let getProductsUseCase: GetProductUseCase
    var products: [Product] = []
    var isLoading = false
    var isLoadingMore = false
    var errorMessage: String?
    private let pageSize = 20
    private var currentPage = 0
    private var hasMoreProducts = true
    
    init(getProductsUseCase: GetProductUseCase) {
        self.getProductsUseCase = getProductsUseCase
    }
    
    func loadInitialProducts() async {
        
        guard !isLoading else {
            return
        }
        currentPage = 0
        hasMoreProducts = true
        products = []
        isLoading = true
        errorMessage = nil
        
        do {
            
            let products = try await getProductsUseCase.execute(limit: pageSize, skip: 0)
            
            self.products = products
            
            hasMoreProducts = products.count == pageSize
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
        
    }
    
    func loadMoreProducts() async {
        guard !isLoading, !isLoadingMore, hasMoreProducts else {
            return
        }
        
        isLoadingMore = true
        
        defer {
            isLoadingMore = false
        }
        
        let nextPage = currentPage + 1
        let skip = nextPage * pageSize
        
        do {
            
            let newProducts = try await getProductsUseCase.execute(limit: pageSize, skip: skip)
            
            products.append(contentsOf: newProducts)
            
            currentPage = nextPage
            hasMoreProducts = newProducts.count == pageSize
        } catch {
            
            errorMessage = error.localizedDescription
        }
        
        
        
    }
}
