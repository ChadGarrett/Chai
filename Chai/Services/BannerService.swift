//
//  BannerService.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import NotificationBannerSwift

/// Displays a banner at the top of the screen informing the user of an action or error
final class BannerService {
    static let shared = BannerService()
    
    /// Displays a success banner
    internal func showBanner(title: String, subtitle: String, style: BannerStyle) {
        let banner = NotificationBanner(title: title, subtitle: subtitle, style: style)
        banner.dismissOnSwipeUp = true
        banner.show()
    }
    
    /// Banner to show when the user tries to make use of a feature that's not implemented
    internal func showNotImplementedBanner() {
        let banner = NotificationBanner(title: "Error :(", subtitle: "Feature not implemented!", style: .danger)
        banner.show()
    }
}
