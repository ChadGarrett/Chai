//
//  MainController.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/14.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import SwiftyBeaver
import Rswift

final class MainController: BaseViewController {
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
    func didSelect(_ menuItem: MainMenuItem) {
        switch menuItem {
        case .debitOrders:
            self.route(to: DebitOrderController())
            
        case .prepaidElectricity:
            self.route(to: PrepaidElectricityController())
            
        case .savings:
            self.route(to: SavingsController())
            
        case .gym:
            BannerService.shared.showNotImplementedBanner()
            
        case .settings:
            self.route(to: SettingsController())
        }
    }
}
