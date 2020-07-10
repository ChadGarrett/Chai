//
//  MoodViewController.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import UIKit
import SwiftyBeaver

protocol MoodControllerDelegate: class {
    func onMoodChange(to value: Float)
}

final class MoodViewController: BaseViewController {
    
    private lazy var moodView: MoodView = {
        let view = MoodView()
        view.delegate = self
        return view
    }()
    
    override init() {
        super.init()
        self.title = R.string.localizable.title_mood()
        self.setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedMood = MoodContext.shared.getCurrentMood() {
            self.moodView.setCurrentMood(to: self.getCurrentMood(value: savedMood.value))
            self.moodView.setMoodValue(to: savedMood.value)
        } else {
            SwiftyBeaver.warning("No saved mood was found. Possibly setting the mood for the first time.")
        }
    }

    override func setupView() {
        self.view.addSubview(self.moodView)
        self.moodView.autoPinEdgesToSuperviewEdges()
    }
    
    // Helpers
    
    func getCurrentMood(value: Float) -> MoodCategory {
        switch value {
        case 0..<20: return .bad
        case 20..<40: return .rocky
        case 40..<60: return .needsAttention
        case 60...80: return .good
        case 80...100: return .excellent
        default: return .unknown
        }
    }
}

extension MoodViewController: MoodControllerDelegate {
    func onMoodChange(to value: Float) {
        let currentMood = self.getCurrentMood(value: value)
        SwiftyBeaver.info("Mood changed to: \(currentMood.title)")
        self.moodView.setCurrentMood(to: currentMood)
        
        MoodContext.shared.setCurrentMood(to: value)
    }
}
