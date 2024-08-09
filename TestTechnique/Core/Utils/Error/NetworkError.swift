//
//  NetworkError.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 09/08/2024.
//

import Foundation

enum NetworkError: LocalizedError {
    case noInternetConnection
    case serverError
    case timeout
    case unknown
    
    // Conform to LocalizedError
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return NSLocalizedString("No internet connection. Please check your network settings.", comment: "")
        case .serverError:
            return NSLocalizedString("Server error. Please try again later.", comment: "")
        case .timeout:
            return NSLocalizedString("The request timed out. Please try again.", comment: "")
        case .unknown:
            return NSLocalizedString("An unknown error occurred.", comment: "")
        }
    }
}

