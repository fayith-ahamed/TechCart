//
//  APIClient.swift
//  TechCart
//
//  Created by Fayith  on 11/09/26.
//

import Foundation

protocol APIClientProtocol {
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
    
}


final class APIClient: APIClientProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        
        guard let url = endpoint.url else{
            throw NetworkError.invalidURL
        }
        
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                throw NetworkError.httpError(statusCode: httpResponse.statusCode)
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError(error)
            }
            
        } catch let error as NetworkError {
            throw error
        } catch {
            
            throw NetworkError.requestFailed(error)
        }
    }
}

