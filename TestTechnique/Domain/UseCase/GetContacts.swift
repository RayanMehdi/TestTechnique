//
//  GetContacts.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 07/08/2024.
//

import Foundation

protocol GetContactsUseCaseProtocol {
    func execute(results: Int, page: Int) async throws -> Result<[ContactEntity], Error>
}

struct GetContactsUseCase: GetContactsUseCaseProtocol{
    let repo : ContactServing
    
    func execute(results: Int, page: Int) async throws -> Result<[ContactEntity], Error> {
        do {
            let contacts = try await repo.getContacts(results: results, page: page)
            return .success(contacts)
        } catch {
            return .failure(error)
        }
    }
}
