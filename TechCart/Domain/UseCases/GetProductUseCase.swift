//
//  GetProductUseCase.swift
//  TechCart
//
//  Created by Fayith  on 10/09/26.
//

import Foundation

struct GetProductUseCase  {
    
    private let repository: ProductRepository
    
    init(repository: ProductRepository) {
        self.repository = repository
    }
    
    func execute(limit: Int, skip: Int) async throws -> [Product] {
        
        try await repository.getProducts(limit: limit, skip: skip)
    }
    
}
