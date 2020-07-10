//
//  UIAlertController+App.swift
//  Chai
//
//  Created by Chad Garrett on 2020/07/10.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

extension UIAlertController {
    func addCancelAction(_ completion: @escaping () -> Void = {}) {
        self.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: completion)
        }))
    }
}
