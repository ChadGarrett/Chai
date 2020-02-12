//
//  LoadingTableCell.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/11.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

/// A table view cell that shows loading text, to be used when fetching data
final class LoadingTableCell: AppTableViewCell {

    // MARK: Setup
    
    override func setupCell() {
        super.setupCell()
        
        self.contentView.addSubview(self.lblLoading)
        self.lblLoading.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(insetHorizontal: 0, insetVertical: Style.padding.s))
    }
    
    // MARK: Subviews
    
    private lazy var lblLoading: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(
            string: R.string.localizable.loading(),
            attributes: Style.body_center)
        return label
    }()
}
