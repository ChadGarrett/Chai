//
//  BaseTableViewCell.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/11.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Reusable

class BaseTableViewCell: UITableViewCell, Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Called on init, override to setup the cell
    public func setupCell() {
        // Subclasses to override
    }

    public func getIndexPath() -> IndexPath? {
        guard let tableView = self.superview as? UITableView
            else { return nil }

        return tableView.indexPath(for: self)
    }
}
