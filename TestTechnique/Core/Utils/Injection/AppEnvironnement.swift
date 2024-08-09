//
//  AppEnvironnement.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 07/08/2024.
//

import Foundation
import Swinject

struct AppEnvironment {
    private(set) var container: Container
    private(set) var assembler: Assembler
    
    static let `default` = AppEnvironment()
    
    private init() {
        container = Container()
        assembler = Assembler(container: container)
    }
    
    func register() {
        container.removeAll()
        registerUtils()
        registerContact()
    }
    
    func registerUtils() {
        assembler.apply(assembly: UtilsAssembly())
    }
    
    func registerContact() {
        assembler.apply(assembly: ContactAssembly())
    }
    
    
    
}
