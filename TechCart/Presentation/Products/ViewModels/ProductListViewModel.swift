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
    var errorMessage: String?
    private let pageSize = 20
    private var currentPage = 0
    
    init(getProductsUseCase: GetProductUseCase) {
        self.getProductsUseCase = getProductsUseCase
    }
    
    func loadProducts() async {
        
        guard !isLoading else {
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            
            let products = try await getProductsUseCase.execute(limit: pageSize, skip: currentPage * pageSize)
            
            self.products = products
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
        
    }
}
