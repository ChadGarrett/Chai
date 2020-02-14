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
            case .debitOrders: return "Debit Orders"
            case .prepaidElectricity: return "Electricity"
            case .savings: return "Savings"
            case .gym: return "Gym"
            case .settings: return "Settings"
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
            
        case .gym:
            BannerService.shared.showNotImplementedBanner()
            
        case .settings:
            self.resetApp()
        }
    }
    
    private func resetApp() {
        SwiftyBeaver.info("RESETING APP!")
        
        SwiftyBeaver.info("Emptying Realm")
        DBManager().deleteAllFromDatabase()
        
        BannerService.shared.showBanner(title: "Reset app", style: .danger)
    }
}
