//
//  NetworkError.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/2/23.
//

import Foundation

enum NetworkError : Error {
    case badUrlResponse(url: URL),
         invalidURL(url: String),
         unknown
}

extension NetworkError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badUrlResponse(url: let url):
            return "Bad response from URL. \(url)"
        case .invalidURL(url: let urlStr):
            return "Invalid url: \(urlStr)"
        case .unknown:
            return "Unknown error"
        }
    }
}
