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

protocol HomeControllerDelegate: class {
    func onRemind()
    func onAttention()
    func onMood()
    func onMemories()
    func onMovies()
    func onDebitOrders()
    func onPrepaidElectricity()
}

final class HomeViewController: AppViewController {
    
    private lazy var homeView: HomeView = {
        let view = HomeView()
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
        self.view.addSubview(self.homeView)
    }
    
    private func setupLayout() {
        self.homeView.autoPinEdgesToSuperviewEdges()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController: HomeControllerDelegate {
    func onRemind() {
        SwiftyBeaver.debug("Tapped on remind.")
        
        let controller = ReminderViewController()
        self.route(to: controller)
    }
    
    func onAttention() {
        SwiftyBeaver.debug("Tapped on attention.")
        
        let controller = AttentionViewController()
        self.route(to: controller)
    }
    
    func onMood() {
        SwiftyBeaver.debug("Tapped on mood.")
        
        let controller = MoodViewController()
        self.route(to: controller)
    }
    
    func onMemories() {
        SwiftyBeaver.debug("Tapped on memories.")
        
        BannerService.shared.showNotImplementedBanner()
    }
    
    func onMovies() {
        SwiftyBeaver.debug("Tapped on movies.")
        
        BannerService.shared.showNotImplementedBanner()
    }
    
    func onDebitOrders() {
        SwiftyBeaver.debug("Tapped on debit order.")
        
        self.route(to: DebitOrderViewController())
    }
    
    func onPrepaidElectricity() {
        SwiftyBeaver.debug("Tapped on prepaid electricity.")
        
        self.route(to: PrepaidElectricityController())
    }
}
