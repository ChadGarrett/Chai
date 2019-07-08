//
//  BannerService.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import NotificationBannerSwift

final class BannerService {
    static let shared = BannerService()
    
    /// Displays a success banner
    internal func showBanner(title: String, subtitle: String, style: BannerStyle) {
        let banner = NotificationBanner(title: title, subtitle: subtitle, style: style)
        banner.show()
    }
}
