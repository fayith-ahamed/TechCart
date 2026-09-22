//
//  ProductRepository.swift
//  TechCart
//
//  Created by Fayith  on 10/09/26.
//

protocol ProductRepository {
    
    func getProducts(limit: Int, skip: Int) async throws -> [Product]
    
    func getProduct(id: Int) async throws -> Product
    
    func searchProducts(query: String) async throws -> [Product]
}
