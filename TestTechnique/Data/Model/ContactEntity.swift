//
//  ContactEntity.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 07/08/2024.
//

import Foundation

struct ContactEntity: Codable, Hashable, Identifiable {
    
    var id: UUID = .init()
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let phone: String
    let picture: Picture
}

