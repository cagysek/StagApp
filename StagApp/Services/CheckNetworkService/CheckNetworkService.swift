//
//  CheckNetworkService.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 09.05.2022.
//

import Foundation
import Network

final class CheckNetworkService: ObservableObject {
    let monitor = NWPathMonitor()
    
    let queue = DispatchQueue(label: "Monitor")
    
    @Published var isConnected = true
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }            
        }
        
        monitor.start(queue: queue)
    }
}
