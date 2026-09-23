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
    private let productLocalDataSource: ProductLocalDataSourceProtocol
    private let productRepository: ProductRepository
    
    init() {
        
        let apiClient = APIClient()
        
        let coreDataStack = CoreDataStack()
        
        let remoteDataSource = ProductRemoteDataSource(apiClient: apiClient)
        
        let localDataSource = ProductLocalDataSource(context: coreDataStack.viewContext)
        
        
        let repository = DefaultProductRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource, mapper: ProductMapper())
        
        self.apiClient = apiClient
        self.productRemoteDataSource = remoteDataSource
        self.productLocalDataSource = localDataSource
        self.productRepository = repository
    }
    
    @MainActor
    func makeProductListViewModel() -> ProductListViewModel {
        
        let useCase = GetProductUseCase(repository: productRepository)
        
        return ProductListViewModel(getProductsUseCase: useCase)
    }
    
}
