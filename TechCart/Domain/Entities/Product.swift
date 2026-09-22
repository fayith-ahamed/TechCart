//
//  Product.swift
//  TechCart
//
//  Created by Fayith  on 10/09/26.
//

import Foundation

struct Product: Identifiable, Equatable {
    
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String?
    let category: String
    let thumbnail: URL?
    let images: [URL]
}
