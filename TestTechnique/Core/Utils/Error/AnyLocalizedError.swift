//
//  AnyLocalizedError.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 09/08/2024.
//

import Foundation

struct AnyLocalizedError: LocalizedError {
    private let _error: LocalizedError

    init(_ error: LocalizedError) {
        self._error = error
    }

    var errorDescription: String? {
        _error.errorDescription
    }

    var failureReason: String? {
        _error.failureReason
    }

    var recoverySuggestion: String? {
        _error.recoverySuggestion
    }

    var helpAnchor: String? {
        _error.helpAnchor
    }
}
