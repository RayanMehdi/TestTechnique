//
//  NetworkManager.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 08/08/2024.
//

import Network
import Combine

class NetworkManager: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    @Published var isConnected: Bool = true
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
