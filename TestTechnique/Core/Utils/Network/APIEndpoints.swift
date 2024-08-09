//
//  APIEndpoints.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 07/08/2024.
//

import Foundation

struct API {
    static let baseUrl = "https://randomuser.me/api"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    enum Gets: Endpoint {
      case contacts(results: Int, page : Int)
        
        
        public var url: String {
            switch self {
                case .contacts(let results, let page): return "\(API.baseUrl)?seed=lumapps&results=\(results)&page=\(page)"
            }
        }
    }
    
}
