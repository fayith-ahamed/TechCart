//
//  ProductLocalDataSource.swift
//  TechCart
//
//  Created by Fayith  on 11/09/26.
//

import CoreData

protocol ProductLocalDataSourceProtocol {
    
    func saveProducts(_ products: [Product]) async throws
    
    func fetchProducts(limit: Int?, offset: Int) async throws -> [Product]
    
    func deleteAllProducts() async throws
    
}

final class ProductLocalDataSource: ProductLocalDataSourceProtocol {
    
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func saveProducts(_ products: [Product]) async throws {

        let context = coreDataStack.newBackgroundContext()
        
        try await context.perform {
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
            if context.hasChanges {
                try context.save()
            }
        }
        
      
        
    }
    
    
    func fetchProducts(limit: Int?, offset: Int) async throws -> [Product] {
        
        let context = coreDataStack.newBackgroundContext()
        
        return try await context.perform {
            let request = ProductEntity.fetchRequest()
            
            request.sortDescriptors = [
                NSSortDescriptor(key: "id", ascending: true)
            ]
            
            request.fetchOffset = offset
            
            if let limit = limit {
                
                request.fetchLimit = limit
            }
            
            let entities =  try context.fetch(request)
            
            return entities.map {
                self.mapToDomain($0)
            }
        }
    }
    
    
    func deleteAllProducts() async throws {
        
        let context = coreDataStack.newBackgroundContext()
        
        try await context.perform {
            let request = ProductEntity.fetchRequest()
            
            
            let entities =  try context.fetch(request)
            
            for entity in entities {
                context.delete(entity)
            }
            
            if context.hasChanges {
                try context.save()
            }
        }
       
    }
    
    
    
    private func mapToDomain(_ entity: ProductEntity) -> Product {
        
        Product(
            id: Int(entity.id),
            title: entity.title,
            description: entity.productDescription,
            price: entity.price,
            discountPercentage: entity.discountPercentage,
            rating: entity.rating,
            stock: Int(entity.stock),
            brand: entity.brand,
            category: entity.category,
            thumbnail: URL(string: entity.thumbnail),
            images: entity.images.compactMap{
                URL(string: $0)
            }
        )


    }
    
}

