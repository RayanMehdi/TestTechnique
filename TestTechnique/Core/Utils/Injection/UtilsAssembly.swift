//
//  UtilsAssembly.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 08/08/2024.
//

import Foundation
import Swinject

class UtilsAssembly: Assembly {
    @MainActor
    func assemble(container: Container) {
        
        container.register(PersistenceController.self) { _ in
            return PersistenceController.shared
        }.inObjectScope(.container)
        
        container.register(NetworkManager.self) { _ in
            NetworkManager()
        }.inObjectScope(.container)
        
        
    }
}
