//
//  DefaultProductRepository.swift
//  TechCart
//
//  Created by Fayith  on 11/09/26.
//

import Foundation

final class DefaultProductRepository: ProductRepository {
    
    private let remoteDataSource: ProductRemoteDataSourceProtocol
    private let mapper: ProductMapper
    
    
    init(remoteDataSource: ProductRemoteDataSourceProtocol, mapper: ProductMapper) {
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }
    
    func getProducts(limit: Int, skip: Int) async throws -> [Product] {
        
        let response = try await remoteDataSource.fetchProducts(limit: limit, skip: skip)
        
        return response.products.map{
            mapper.map($0)
        }
    }
    
    func getProduct(id: Int) async throws -> Product {
        
        let dto = try await remoteDataSource.fetchProduct(id: id)
        
        return mapper.map(dto)
    }
    
    
    func searchProducts(query: String) async throws -> [Product] {
        let response =  try await remoteDataSource.searchProducts(query: query)
        
        return response.products.map{
            mapper.map($0)
        }
    }
    
}
