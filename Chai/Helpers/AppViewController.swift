//
//  AppViewController.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/11.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import UIKit

class AppViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    internal func route(to controller: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(controller, animated: animated)
        }
    }
}
