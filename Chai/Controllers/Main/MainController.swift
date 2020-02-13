//
//  HomeViewontroller.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/14.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import SwiftyBeaver
import Rswift

final class MainController: BaseViewController {
    
    enum MenuItem: Int, CaseIterable {
        case debitOrders = 0
        case prepaidElectricity
        case savings
        
        var image: UIImage? {
            switch self {
            case .debitOrders: return R.image.flashlight()
            case .prepaidElectricity: return R.image.flashlight()
            case .savings: return R.image.flashlight()
            }
        }
        
        var title: String {
            switch self {
            case .debitOrders: return "Debit Orders"
            case .prepaidElectricity: return "Electricity"
            case .savings: return "Savings"
            }
        }
        
        var color: UIColor {
            switch self {
            case .debitOrders: return Style.colors.pomegranate
            case .prepaidElectricity: return Style.colors.sunflower
            case .savings: return Style.colors.nephritis
            }
        }
    }
    
    private var menuItems: [MenuItem] = [
        .debitOrders,
        .prepaidElectricity,
        .savings
    ]
    
    private lazy var mainView: MainView = {
        let view = MainView()
        view.delegate = self
        return view
    }()
    
    override init() {
        super.init()
        self.title = R.string.localizable.title_home()
        self.setupSubviews()
        self.setupLayout()
    }
    
    private func setupSubviews() {
        self.view.addSubview(self.mainView)
    }
    
    private func setupLayout() {
        self.mainView.autoPinEdgesToSuperviewEdges()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainController: MainViewDelegate {
    func didSelect(_ menuItem: MainController.MenuItem) {
        switch menuItem {
        case .debitOrders:
            self.route(to: DebitOrderViewController())
            
        case .prepaidElectricity:
            self.route(to: PrepaidElectricityController())
            
        case .savings:
            self.route(to: SavingsController())
        }
    }
}
