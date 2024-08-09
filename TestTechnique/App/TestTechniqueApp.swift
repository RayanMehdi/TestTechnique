//
//  TestTechniqueApp.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 06/08/2024.
//

import SwiftUI

@main
struct TestTechniqueApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var router = Router()
    
    // MARK: - Initialization

    init() {
        ValueTransformer.setValueTransformer(LocationTransformer(), forName: LocationTransformer.name)
            
        AppEnvironment.default.register()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path){
                ContentView().navigationDestination(for: Route.self) { route in
                    switch(route){
                        case .list:
                            ContactListView()
                        case .detail(let contact):
                        ContactDetail(contact: contact)
                            
                    }
                }
            }
            .environmentObject(router)
        }
    }
}
