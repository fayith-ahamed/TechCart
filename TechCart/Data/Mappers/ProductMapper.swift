//
//  ProductMapper.swift
//  TechCart
//
//  Created by Fayith  on 11/09/26.
//

import Foundation

struct ProductMapper {
    
    func map(_ dto: ProductDTO) -> Product {
        
        Product(
            id: dto.id,
            title: dto.title,
            description: dto.description,
            price: dto.price,
            discountPercentage: dto.discountPercentage,
            rating: dto.rating,
            stock: dto.stock,
            brand: dto.brand,
            category: dto.category,
            thumbnail: URL(string: dto.thumbnail),
            images: dto.images.compactMap{
                URL(string: $0)
            }
        )
    }
}
