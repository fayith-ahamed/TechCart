//
//  ProductEntity+CoreDataProperties.swift
//  TechCart
//
//  Created by Fayith  on 22/09/26.
//

import CoreData

extension ProductEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        
        
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var title: String
    @NSManaged public var productDescription: String
    @NSManaged public var price: Double
    @NSManaged public var discountPercentage: Double
    @NSManaged public var rating: Double
    @NSManaged public var stock: Int64
    @NSManaged public var brand: String?
    @NSManaged public var category: String
    @NSManaged public var thumbnail: String
    @NSManaged public var images: [String]
}
