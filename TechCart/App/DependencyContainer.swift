//
//  DependencyContainer.swift
//  TechCart
//
//  Created by Fayith  on 10/09/26.
//

import Foundation

final class DependencyContainer {
    
    private let apiClient: APIClientProtocol
    private let productRemoteDataSource: ProductRemoteDataSourceProtocol
    private let productRepository: ProductRepository
    
    init() {
        
        let apiClient = APIClient()
        let remoteDataSource = ProductRemoteDataSource(apiClient: apiClient)
        let repository = DefaultProductRepository(remoteDataSource: remoteDataSource, mapper: ProductMapper())
        
        self.apiClient = apiClient
        self.productRemoteDataSource = remoteDataSource
        self.productRepository = repository
    }
    
    @MainActor
    func makeProductListViewModel() -> ProductListViewModel {
        
        let useCase = GetProductUseCase(repository: productRepository)
        
        return ProductListViewModel(getProductsUseCase: useCase)
    }
    
}
