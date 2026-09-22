//
//  ProductRowView.swift
//  TechCart
//
//  Created by Fayith  on 22/09/26.
//

import SwiftUI

struct ProductRowView: View {
    
    let product: Product
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            AsyncImage(url: product.thumbnail) { image in
                image
                    .resizable()
                    .scaledToFill()
                
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            
            VStack(alignment: .leading, spacing: 8) {
                
                
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)
                
                if let brand = product.brand {
                    
                    Text(brand)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Text(product.price, format: .currency(code: "USD"))
                    .font(.headline)
                
                HStack(alignment: .center) {
                    
                    Image(systemName: "star.fill")
                    
                    Text("\(product.rating.formatted(.number.precision(.fractionLength(1))))")
                }
                .font(.caption)
                .foregroundStyle(.orange)
                
            }
            
            
            Spacer()
            
            
            
        }
        .padding(.vertical, 8)
    }
}
