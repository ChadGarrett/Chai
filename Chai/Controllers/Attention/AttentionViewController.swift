//
//  AttentionViewController.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/10.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import SwiftyBeaver

// TODO: Move to models
enum AttentionType {
    case snacks
    case cuddles
    case massage
    case dinner
}

protocol AttentionViewDelegate: class {
    func onAskForAttention(of type: AttentionType)
}

final class AttentionViewController: AppViewController {

    private lazy var attentionView: AttentionView = {
        let view = AttentionView()
        view.delegate = self
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = R.string.localizable.title_attention()
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.view.addSubview(self.attentionView)
        self.attentionView.autoPinEdgesToSuperviewEdges()
    }
}

extension AttentionViewController: AttentionViewDelegate {
    func onAskForAttention(of type: AttentionType) {
        BannerService.shared.showNotImplementedBanner()
        
        // TODO: Record attention to history
        // TODO: Send call for attention to server
    }
}
