//
//  ContactAssembly.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 07/08/2024.
//

import Foundation
import Swinject

class ContactAssembly: Assembly {
    @MainActor
    func assemble(container: Container) {
       
        container.register(ContactRemoteDataSource.self) { _ in
            ContactRemoteDataSource()
        }.inObjectScope(.container)
        
        container.register(ContactDatabaseDataSource.self) { _ in
            ContactDatabaseDataSource(context: PersistenceController.shared.container.viewContext)
        }.inObjectScope(.container)
        
        container.register(ContactRepository.self) { r in
            ContactRepository(networkDataSource: r.resolve(ContactRemoteDataSource.self)!, dataBaseDataSource: r.resolve(ContactDatabaseDataSource.self)!)
        }.inObjectScope(.container)
        
        container.register(GetContactsUseCase.self) { r in
            GetContactsUseCase(repo: r.resolve(ContactRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(ContactListViewModel.self) { r in
            ContactListViewModel(getContactUseCase: r.resolve(GetContactsUseCase.self)!, networkManager: r.resolve(NetworkManager.self)!)
        }.inObjectScope(.container)
        
    }
}

