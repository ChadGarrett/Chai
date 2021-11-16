//
//  UIView+App.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/04.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import PureLayout
import UIKit

extension UIView {
    func addDropShadow() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3
    }

    func addBorder(color: UIColor = .black, width: CGFloat = 1.0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }

    /// Pins all passed edges to their superviews edge, with the given inset if any
    func autoPinEdges(toSuperviewEdges edges: [ALEdge], withInset inset: CGFloat = 0) {
        edges.forEach { edge in
            self.autoPinEdge(toSuperviewEdge: edge, withInset: inset)
        }
    }
}
