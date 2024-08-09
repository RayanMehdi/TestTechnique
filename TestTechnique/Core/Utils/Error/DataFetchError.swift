//
//  DataFetchError.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 09/08/2024.
//

import Foundation

struct DataFetchError: LocalizedError {
    let cachedContacts: [ContactEntity]
    let underlyingError: Error
    
    var errorDescription: String? {
        return underlyingError.localizedDescription
    }
}
