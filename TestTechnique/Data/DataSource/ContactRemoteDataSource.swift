//
//  ContactRemoteDataSource.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 08/08/2024.
//

import Foundation

protocol ContactRemoteDataSourceProtocol {
    func getContacts(results: Int, page: Int) async throws -> ContactListResponse
}

struct ContactRemoteDataSource : ContactRemoteDataSourceProtocol {
    func getContacts(results: Int, page: Int) async throws -> ContactListResponse {
        guard let url = URL(string: Endpoints.Gets.contacts(results: results, page: page).url) else {throw URLError(.badURL)}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            return try JSONDecoder().decode(ContactListResponse.self, from: data)
            
        } catch {
            throw URLError(.cannotParseResponse)
        }
    }
    
    
}
