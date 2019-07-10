//
//  UIEdgeInsets+App.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/10.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    /// Inset all sides with the same amount
    init(inset: CGFloat) {
        self.init(
            top: inset,
            left: inset,
            bottom: inset,
            right: inset)
    }
    
    init(insetHorizontal: CGFloat, insetVertical: CGFloat) {
        self.init(
            top: insetVertical,
            left: insetHorizontal,
            bottom: insetVertical,
            right: insetHorizontal)
    }
}
