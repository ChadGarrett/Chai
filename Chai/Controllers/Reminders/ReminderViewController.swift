//
//  ReminderViewController.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation

protocol ReminderControllerDelegate: class {
    
}

final class ReminderViewController: AppViewController {
    
    private lazy var reminderView: ReminderView = {
        let view = ReminderView()
        //view.delegate = self
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.view.addSubview(self.reminderView)
        self.reminderView.autoPinEdgesToSuperviewEdges()
    }
}

extension ReminderViewController: ReminderControllerDelegate {
    
}
