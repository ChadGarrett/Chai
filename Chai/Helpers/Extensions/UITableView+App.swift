//
//  UITableView+App.swift
//  Chai
//
//  Created by Chad Garrett on 2020/07/08.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

extension UITableView {
    internal func dequeueBlankCell(for indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(for: indexPath, cellType: BlankTableCell.self)
    }
}
