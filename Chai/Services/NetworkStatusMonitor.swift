//
//  NetworkStatusMonitor.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/20.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Network
import SwiftyBeaver

protocol NetworkStatusObserver {
    /// Identifier of the observer
    var identifier: String { get }
    
    func networkStatusDidUpdate(to status: NWPath.Status)
}

final class NetworkStatusMonitor {
    static let shared = NetworkStatusMonitor()
    
    // MARK: Properties
    
    private var observerArray: [NetworkStatusObserver] = []
    
    let monitor: NWPathMonitor
    
    // MARK: Setup
    
    init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = self.handlePathUpdates
    }
    
    // MARK: Inteface
    
    /// Starts the network monitor
    internal func start() {
        monitor.start(queue: .global(qos: .background))
    }
    
    /// Stops the network monitor
    internal func stop() {
        monitor.cancel()
    }
    
    /// Attaches the observer to receive updates on network changes
    internal func attachObserver(_ observer: NetworkStatusObserver) {
        SwiftyBeaver.info("Attached new network status observer: \(observer.identifier)")
        self.observerArray.append(observer)
    }
    
    /// Removes the observer from receiving updates
    internal func removeObserver(_ observer: NetworkStatusObserver) {
        SwiftyBeaver.info("Removing network status observer: \(observer.identifier)")
        self.observerArray = self.observerArray.filter { $0.identifier != observer.identifier }
    }
    
    // MARK: Helpers
    
    private func handlePathUpdates(for path: NWPath) {
        SwiftyBeaver.info("Network status did change.")
        self.notifyObservers()
        
        switch path.status {
        case .satisfied: self.handlePathUpdatesForSatisfied(path)
        case .unsatisfied: self.handlePathUpdatesForUnsatisfied(path)
        case .requiresConnection: self.handlePathUpdatesForRequiresConnection(path)
        }
    }
    
    private func notifyObservers() {
        self.observerArray.forEach { (observer) in
            observer.networkStatusDidUpdate(to: self.monitor.currentPath.status)
        }
    }
    
    private func handlePathUpdatesForSatisfied(_ path: NWPath) {
        SwiftyBeaver.info("Device is connected to the internet.")
        
        if path.usesInterfaceType(.wifi) {
            SwiftyBeaver.info("Device is connected via WiFi.")
            
            if path.isExpensive {
                SwiftyBeaver.info("Device is using an expensive connection - Personal hotspot.")
            }
            
        } else if path.usesInterfaceType(.cellular) {
            SwiftyBeaver.info("Device is connected via cellular.")
            
            if path.isExpensive {
                SwiftyBeaver.info("Device is using an expensive connection - Celluar data.")
            }
        } else {
            SwiftyBeaver.info("Device connection is unknown: \(path.debugDescription)")
        }
        
        if #available(iOS 13.0, *) {
            if path.isConstrained {
                SwiftyBeaver.info("Device data is constrained. Possibly in low data mode.")
            }
        }
    }
    
    private func handlePathUpdatesForUnsatisfied(_ path: NWPath) {
        SwiftyBeaver.warning("Device is not connected to the internet.")
    }
    
    private func handlePathUpdatesForRequiresConnection(_ path: NWPath) {
        SwiftyBeaver.info("Unknown connectivity state.")
    }
}
