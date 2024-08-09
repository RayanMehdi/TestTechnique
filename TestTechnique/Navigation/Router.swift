//
//  Router.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 07/08/2024.
//

import Foundation
import SwiftUI

enum Route: Hashable, Equatable{
    
    case list
    case detail(contact: ContactEntity)
}

final class Router: ObservableObject{
    @Published  var path = NavigationPath()
    
    public func toRoot(){
        path = .init()
    }
    
    public func pop(){
        path.removeLast()
    }
    
    public func push(_ route: Route){
        path.append(route)
    }
}
