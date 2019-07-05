//
//  HomeViewontroller.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/14.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import SwiftyBeaver

protocol HomeControllerDelegate: class {
    func onTest()
}

final class HomeViewController: AppViewController {
    
    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.delegate = self
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = R.string.localizable.title_confirm()
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
    func onTest() {
        self.navigationController?.pushViewController(ShoppingListController(), animated: true)
    }
}
