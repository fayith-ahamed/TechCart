//
//  TechCartApp.swift
//  TechCart
//
//  Created by Fayith  on 10/09/26.
//

import SwiftUI

@main
struct TechCartApp: App {
    
    private let container = DependencyContainer()
    var body: some Scene {
        WindowGroup {
            ProductListView(viewModel: container.makeProductListViewModel())
        }
    }
}
