//
//  ProductRemoteDataSource.swift
//  TechCart
//
//  Created by Fayith  on 11/09/26.
//

import Foundation

protocol ProductRemoteDataSourceProtocol {
    
    func fetchProducts(limit: Int, skip: Int) async throws -> ProductsResponseDTO
    
    func fetchProduct(id: Int) async throws -> ProductDTO
    
    func searchProducts(query: String) async throws -> ProductsResponseDTO
}

final class ProductRemoteDataSource: ProductRemoteDataSourceProtocol {
    
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchProducts(limit: Int, skip: Int) async throws -> ProductsResponseDTO {
        try await apiClient.request(.products(limit: limit, skip: skip))
    }
    
    
    func fetchProduct(id: Int) async throws -> ProductDTO {
    
        try await apiClient.request(.product(id: id))
    }
    
    
    func searchProducts(query: String) async throws -> ProductsResponseDTO {
        try await apiClient.request(.searchProducts(query: query))
    }
    
    
}
