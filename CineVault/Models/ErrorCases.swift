//
//  ErrorCases.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 11/05/2025.
//

import Foundation

enum ErrorCases: LocalizedError {
    case invalidURL
    case requestFailed
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .requestFailed:
            return "The network request failed."
        case .decodingError:
            return "Failed to decode the response."
        }
    }
}
