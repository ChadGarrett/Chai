//
//  MoodViewController.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation

final class MoodViewController: AppViewController {
    
    private lazy var moodView: MoodView = {
        let view = MoodView()
        //view.delegate = self
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = R.string.localizable.title_mood()
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.view.addSubview(self.moodView)
        self.moodView.autoPinEdgesToSuperviewEdges()
    }
}
