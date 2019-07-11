//
//  AttentionType.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/10.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import UIKit

/// Different types of attention actions that can be used
enum AttentionType: Int, CaseIterable {
    case snacks = 0
    case cuddles
    case massage
    case dinner
    
    var title: String {
        switch self {
        case .snacks: return R.string.localizable.button_attention_snacks()
        case .cuddles: return R.string.localizable.button_attention_cuddles()
        case .massage: return R.string.localizable.button_attention_massage()
        case .dinner: return R.string.localizable.button_attention_dinner()
        }
    }
    
    var color: UIColor {
        switch self {
        case .snacks: return Style.colors.pumpkin
        case .cuddles: return Style.colors.plum
        case .massage: return Style.colors.hoki
        case .dinner: return Style.colors.mediumTurquoise
        }
    }
}
