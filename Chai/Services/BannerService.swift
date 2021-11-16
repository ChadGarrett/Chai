//
//  BannerService.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Network
import NotificationBannerSwift

/// Displays a banner at the top of the screen informing the user of an action or error
final class BannerService {
    static let shared = BannerService()
    
    enum Duration: TimeInterval {
        /// 1 second
        case short = 1.0
        
        /// 4 seconds
        case medium = 4
        
        /// 8 seconds
        case long = 8
    }
    
    enum ErrorMessage: String {
        case generic = "An unknown error occured."
        case networkConnected = "Network connected."
        case networkDisconnected = "Network not connected."
        case serverUnavailable = "A connection to the server cannot be made."
        
        case actionUnsuccesfully = "Unable to completed action."
    }
    
    internal func showStatusBarBanner(title: String, style: BannerStyle, duration: Duration = .medium, autoDismiss: Bool = true) {
        let banner = StatusBarNotificationBanner(title: title, style: style)
        banner.dismissOnSwipeUp = true
        banner.autoDismiss = autoDismiss
        banner.duration = duration.rawValue
        banner.show()
    }
    
    internal func showBanner(error: ErrorMessage) {
        self.showBanner(title: error.rawValue, style: .danger)
    }
    
    internal func showBanner(title: String, subtitle: String? = nil, style: BannerStyle, duration: Duration = .medium, autoDismiss: Bool = true) {
        let banner = NotificationBanner(title: title, subtitle: subtitle, style: style)
        banner.dismissOnSwipeUp = true
        banner.autoDismiss = autoDismiss
        banner.duration = duration.rawValue
        banner.show()
    }
    
    /// Banner to show when the user tries to make use of a feature that's not implemented
    internal func showNotImplementedBanner() {
        let banner = NotificationBanner(title: "Error :(", subtitle: "Feature not implemented!", style: .danger)
        banner.show()
    }
}

extension BannerService: BaseService {
    func setup() {
        NetworkStatusMonitor.shared.attachObserver(self)
    }
    
    func teardown() {
        NetworkStatusMonitor.shared.removeObserver(self)
    }
}

extension BannerService: NetworkStatusObserver {
    var identifier: String {
        return "BannerService"
    }
    
    func networkStatusDidUpdate(to status: NWPath.Status) {
        DispatchQueue.main.async { [weak self] in
            switch status {
            case .satisfied:
                self?.showStatusBarBanner(title: "Connected!", style: .success, duration: .short)
            case .unsatisfied:
                self?.showStatusBarBanner(title: "No connection available.", style: .danger, duration: .long)
            case .requiresConnection:
                self?.showBanner(title: "Unknown connection", style: .danger)
            }
        }
    }
}
