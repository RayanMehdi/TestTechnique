//
//  ContactMapper.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 07/08/2024.
//

import Foundation

enum ContactMapper {
    static func mapContactsResponseToDomain(input response: ContactListResponse) -> [ContactEntity] {
        return response.results.map { result in
            return ContactEntity(gender: result.gender,
                                 name: result.name,
                                 location: result.location,
                                 email: result.email,
                                 phone: result.phone,
                                 picture: result.picture)
        }
    }
}
