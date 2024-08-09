//
//  ContactListViewModel.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 07/08/2024.
//

import Foundation
import Combine

@MainActor class ContactListViewModel: ObservableObject {
    let getContactUseCase: GetContactsUseCaseProtocol
    
    @Published var contacts: [ContactEntity] = []
    @Published var isLoading: Bool = false
    @Published var error: AnyLocalizedError?
    var networkManager: NetworkManager
    var page: Int = 1
    
    init(getContactUseCase: GetContactsUseCaseProtocol, networkManager: NetworkManager){
        self.getContactUseCase = getContactUseCase
        self.networkManager = networkManager
    }
    
    func getContacts(results: Int, page: Int) async throws {
        isLoading = true
        defer { isLoading = false }
        let result = try await getContactUseCase.execute(results: results, page: page)
        switch result {
        case .success(let contacts):
            self.contacts.append(contentsOf: contacts)
            self.page += 1
            self.isLoading = false
        case .failure(let failure):
            print(failure)
            
            if let dataFetchError = failure as? DataFetchError, let networkError = dataFetchError.underlyingError as? NetworkError, networkError == .noInternetConnection {
                self.contacts = dataFetchError.cachedContacts
                self.error = AnyLocalizedError(networkError)
            } else {
                self.error = error
            }
        }
        
    }
    
    func loadMoreContacts() async {
        guard !isLoading else { return }
        guard networkManager.isConnected else { return }
        page += 1
        do {
            try await getContacts(results: 10, page: page)
        } catch {
            print("Error loading more contacts: \(error)")
        }
    }
}
