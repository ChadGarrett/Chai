//
//  MoodCategory.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/09.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import UIKit

enum MoodCategory {
    case bad // 0-20
    case rocky // 20-40
    case needsAttention // 40-60
    case good //60-80
    case excellent //80-100
    case unknown
    
    var title: String {
        switch self {
        case .bad: return "Bad"
        case .rocky: return "Rocky"
        case .needsAttention: return "Needs attention"
        case .good: return "Good"
        case .excellent: return "Excellent"
        case .unknown: return "Unknown"
        }
    }
    
    var color: UIColor {
        switch self {
        case .bad: return Style.colors.monza
        case .rocky: return Style.colors.alizarin
        case .needsAttention: return Style.colors.carrot
        case .good: return Style.colors.gossip
        case .excellent: return Style.colors.nephritis
        case .unknown: return Style.colors.clouds
        }
    }
}
