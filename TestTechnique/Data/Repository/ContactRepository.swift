//
//  ContactRepository.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 07/08/2024.
//

import Foundation

protocol ContactServing {
    func getContacts(results: Int, page: Int) async throws -> [ContactEntity]
}

struct ContactRepository: ContactServing {
    
    let networkDataSource: ContactRemoteDataSourceProtocol
    let dataBaseDataSource: ContactDataBaseDataSourceProtocol
    
    func getContacts(results: Int, page: Int) async throws -> [ContactEntity] {
        do {
            let contacts = try await networkDataSource.getContacts(results: results, page: page)
            let mappedContact = ContactMapper.mapContactsResponseToDomain(input: contacts)
            let uniqueContact = Array(Set(mappedContact))
            try await dataBaseDataSource.saveContacts(uniqueContact)
            return uniqueContact
        } catch {
            let contacts = try await Array(Set(dataBaseDataSource.fetchContacts()))
            throw DataFetchError(cachedContacts: contacts, underlyingError: NetworkError.noInternetConnection)
        }
    }

}
