//
//  BaseViewController.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/11.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import PureLayout
import Rswift
import UIKit

class BaseViewController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = Style.colors.clouds
    }
    
    @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    /// Adds the passed view controller to the stack
    internal func route(to controller: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(controller, animated: animated)
        }
    }
}
