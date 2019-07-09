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
}

final class HomeViewController: AppViewController {
    
    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.delegate = self
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = R.string.localizable.title_home()
        self.setupSubviews()
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        SwiftyBeaver.info("Tapped on remind.")
        
        let controller = ReminderViewController()
        self.route(to: controller)
    }
    
    func onAttention() {
        SwiftyBeaver.info("Tapped on attention.")
        
        BannerService.shared.showNotImplementedBanner()
    }
    
    func onMood() {
        SwiftyBeaver.info("Tapped on mood.")
        
        let controller = MoodViewController()
        self.route(to: controller)
    }
    
    func onMemories() {
        SwiftyBeaver.info("Tapped on memories")
        
        BannerService.shared.showNotImplementedBanner()
    }
}
