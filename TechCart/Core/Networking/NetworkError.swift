//
//  NetworkError.swift
//  TechCart
//
//  Created by Fayith  on 11/09/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(Error)
    case requestFailed(Error)
}
