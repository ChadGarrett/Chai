//
//  CGSize+App.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/13.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

extension CGSize {
    public static func square(of side: CGFloat) -> CGSize {
        return CGSize(width: side, height: side)
    }
}
