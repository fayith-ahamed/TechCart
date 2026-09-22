//
//  ProductDTO.swift
//  TechCart
//
//  Created by Fayith  on 11/09/26.
//

import Foundation

struct ProductDTO: Decodable {
    
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String?
    let thumbnail: String
    let images: [String]
}

struct ProductsResponseDTO: Decodable {
    
    let products: [ProductDTO]
    let total: Int
    let skip: Int
    let limit: Int
}
