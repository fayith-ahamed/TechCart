//
//  DefaultProductRepository.swift
//  TechCart
//
//  Created by Fayith  on 11/09/26.
//

import Foundation

final class DefaultProductRepository: ProductRepository {
    
    private let remoteDataSource: ProductRemoteDataSourceProtocol
    private let localDataSource: ProductLocalDataSourceProtocol
    private let mapper: ProductMapper
    
    
    init(remoteDataSource: ProductRemoteDataSourceProtocol, localDataSource: ProductLocalDataSourceProtocol, mapper: ProductMapper) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.mapper = mapper
    }
    
    func getProducts(limit: Int, skip: Int) async throws -> [Product] {
        
        do {
            
            let response = try await remoteDataSource.fetchProducts(limit: limit, skip: skip)
            
            let products = response.products.map {
                mapper.map($0)
            }
            
            try localDataSource.saveProducts(products)
            return products
        } catch {
            
            return try localDataSource.fetchProducts()
        }
    }
    
    func getProduct(id: Int) async throws -> Product {
        
        let dto = try await remoteDataSource.fetchProduct(id: id)
        
        let product = mapper.map(dto)
        
        try localDataSource.saveProducts([product])
        return product
    }
    
    
    func searchProducts(query: String) async throws -> [Product] {
       
        do {
            let response =  try await remoteDataSource.searchProducts(query: query)
            
            let products = response.products.map {
                mapper.map($0)
            }
            
            try localDataSource.saveProducts(products)
            
            return products
        } catch {
            
            let cachedProducts = try localDataSource.fetchProducts()
            
            return cachedProducts.filter {
                $0.title.localizedStandardContains(query)
            }
            
        }
        
    }
    
}
