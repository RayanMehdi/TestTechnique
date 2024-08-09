//
//  ContactResponse.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 06/08/2024.
//

import Foundation

struct ContactResponse: Codable, Hashable {
    
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: Dob
    let registered: Registered
    let phone: String
    let cell: String
    let id: ID?
    let picture: Picture
    let nat: String
}

// MARK: - Name
struct Name: Codable, Hashable {
    let title: String
    let first: String
    let last: String
    
    var displayName: String {
        get {
            return "\(title) \(first) \(last)"
        }
    }
}

// MARK: - Location
struct Location: Codable, Hashable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Postcode
    let coordinates: Coordinates
    let timezone: Timezone
    
    var displayableAddress: String {
        get{
            return "\(street.number) \(street.name), \(city) \(country)"
        }
    }
    
    // MARK: - Street
    struct Street: Codable, Hashable {
        let number: Int
        let name: String
    }
    
    // MARK: - Coordinates
    struct Coordinates: Codable, Hashable {
        let latitude: String
        let longitude: String
    }
    
    enum Postcode: Codable, Hashable {
        case intPostcode(Int)
        case stringPostcode(String)
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let intValue = try? container.decode(Int.self) {
                self = .intPostcode(intValue)
                return
            }
            if let stringValue = try? container.decode(String.self) {
                self = .stringPostcode(stringValue)
                return
            }
            throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Postcode value cannot be decoded"))
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .intPostcode(let intValue):
                try container.encode(intValue)
            case .stringPostcode(let stringValue):
                try container.encode(stringValue)
            }
        }
        
        var stringValue: String {
            switch self {
            case .intPostcode(let intPostcode):
                return String(intPostcode)
            case .stringPostcode(let stringPostcode):
                return stringPostcode
            }
        }
    }
    
    // MARK: - Timezone
    struct Timezone: Codable, Hashable {
        let offset: String
        let description: String
    }
    
}

// MARK: - Picture
struct Picture: Codable, Hashable {
    let large: String
    let medium: String
    let thumbnail: String
}

// MARK: - Login
struct Login: Codable, Hashable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

// MARK: - Dob
struct Dob: Codable, Hashable {
    let date: String
    let age: Int
}

// MARK: - Registered
struct Registered: Codable, Hashable {
    let date: String
    let age: Int
}

// MARK: - ID
struct ID: Codable, Hashable {
    let name: String?
    let value: String?
}

