//
//  BaseCollectionViewCell.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/13.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Reusable

class BaseCollectionViewCell: UICollectionViewCell, Reusable {

    // MARK: Helpers

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Called on init, override to setup the cell
    public func setupCell() {
        // Subclasses to override
    }

    // MARK: Helper

    private func getIndexPath() -> IndexPath? {
        guard let collectionView = self.superview as? UICollectionView
        else { return nil }

        return collectionView.indexPath(for: self)
    }
}
