//
//  Endpoint.swift
//  TechCart
//
//  Created by Fayith  on 11/09/26.
//

import Foundation

enum Endpoint {
    
    case products(limit: Int, skip: Int)
    case product(id: Int)
    case searchProducts(query: String)
    
    private var baseURL: String {
        "https://dummyjson.com"
    }
    
    var url: URL? {
        
        switch self {
            
        case let .products(limit, skip):
            return URL(string: "\(baseURL)/products?limit=\(limit)&skip=\(skip)")
            
        case let .product(id):
            return URL(string: "\(baseURL)/products/\(id)")
            
        case let .searchProducts(query):
            var components = URLComponents(string: "\(baseURL)/products/search")
            
            components?.queryItems = [URLQueryItem(name: "q", value: query)]
            
            return components?.url
            
        }
    }
}
