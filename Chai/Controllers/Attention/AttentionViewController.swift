//
//  AttentionViewController.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/10.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import SwiftyBeaver

protocol AttentionViewDelegate: class {
    func onAskForAttention(of type: AttentionType)
}

final class AttentionViewController: BaseViewController {

    private lazy var attentionView: AttentionView = {
        let view = AttentionView()
        view.delegate = self
        return view
    }()
    
    override init() {
        super.init()
        self.title = R.string.localizable.title_attention()
        self.setupView()
    }
    
    private func setupView() {
        self.view.addSubview(self.attentionView)
        self.attentionView.autoPinEdgesToSuperviewEdges()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let actions: [AttentionType] = AttentionType.allCases
        self.attentionView.setActions(to: actions)
    }
}

extension AttentionViewController: AttentionViewDelegate {
    func onAskForAttention(of type: AttentionType) {
        SwiftyBeaver.info("Tapped on attention item: \(type.title)")
        BannerService.shared.showNotImplementedBanner()
        
        // TODO: Record attention to history
        // TODO: Send call for attention to server
    }
}
