//
//  ProductLocalDataSource.swift
//  TechCart
//
//  Created by Fayith  on 11/09/26.
//

import CoreData

protocol ProductLocalDataSourceProtocol {
    
    func saveProducts(_ products: [Product]) throws
    
    func fetchProducts() throws -> [Product]
    
    func deleteAllProducts()  throws
    
}

final class ProductLocalDataSource: ProductLocalDataSourceProtocol {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveProducts(_ products: [Product]) throws {
        for product in products {
            
            
            let request = ProductEntity.fetchRequest()
            
            request.predicate = NSPredicate(format: "id == %d", product.id)
            
            let existingProduct = try context.fetch(request).first
            
            let entity = existingProduct ?? ProductEntity(context: context)
            
            entity.id = Int64(product.id)
            entity.title = product.title
            entity.productDescription = product.description
            entity.price = product.price
            entity.discountPercentage = product.discountPercentage
            entity.rating = product.rating
            entity.stock = Int64(product.stock)
            entity.brand = product.brand
            entity.category = product.category
            entity.thumbnail = product.thumbnail?.absoluteString ?? ""
            entity.images = product.images.map {
                $0.absoluteString
            }
            
        }
        
        try context.save()
    }
    
    
    func fetchProducts() throws -> [Product] {
        let request = ProductEntity.fetchRequest()
        
        request.sortDescriptors = [
            NSSortDescriptor(key: "id", ascending: true)
        ]
        
        let entities =  try context.fetch(request)
        
        return entities.map {
            mapToDomain($0)
        }
    }
    
    
    func deleteAllProducts() throws {
        let request = ProductEntity.fetchRequest()
        
        
        let entities =  try context.fetch(request)
        
        for entity in entities {
            context.delete(entity)
        }
        
        try context.save()
    }
    
    
    
    private func mapToDomain(_ entity: ProductEntity) -> Product {
        
        Product(id: Int(entity.id), title: entity.title, description: entity.productDescription, price: entity.price, discountPercentage: entity.discountPercentage, rating: entity.rating, stock: Int(entity.stock), brand: entity.brand, category: entity.category, thumbnail: URL(string: entity.thumbnail), images: entity.images.compactMap{
            URL(string: $0)
        })


    }
    
}

