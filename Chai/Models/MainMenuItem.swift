//
//  MainMenuItem.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/18.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

enum MainMenuItem: Int, CaseIterable {
    case debitOrders = 0
    case prepaidElectricity
    case savings
    case gym
    case settings

    var image: UIImage? {
        switch self {
        case .debitOrders: return R.image.tickets()
        case .prepaidElectricity: return R.image.flashlight()
        case .savings: return R.image.tennis()
        case .gym: return R.image.treadmill()
        case .settings: return R.image.screwdriver()
        }
    }

    var title: String {
        switch self {
        case .debitOrders: return R.string.localizable.button_debit_orders()
        case .prepaidElectricity: return R.string.localizable.button_prepaid_electricity()
        case .savings: return R.string.localizable.button_savings()
        case .gym: return R.string.localizable.button_gym()
        case .settings: return R.string.localizable.button_settings()
        }
    }

    var color: UIColor {
        switch self {
        case .debitOrders: return Style.colors.lightWisteria
        case .prepaidElectricity: return Style.colors.sunflower
        case .savings: return Style.colors.nephritis
        case .gym: return Style.colors.turquoise
        case .settings: return Style.colors.concrete
        }
    }
}
