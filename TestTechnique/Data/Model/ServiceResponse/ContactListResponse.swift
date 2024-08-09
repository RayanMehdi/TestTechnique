//
//  ContactListResponse.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 06/08/2024.
//

import Foundation

// MARK: - ContactListResponse
struct ContactListResponse: Codable, Hashable {
    let results: [ContactResponse]
}
