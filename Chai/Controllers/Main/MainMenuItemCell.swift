//
//  MainMenuItemCell.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/13.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

// _____________
// |           |
// |    ***    |
// |   *****   |
// |   *****   |
// |    ***    |
// |           |
// | ********* |
// |___________|

final class MainMenuItemCell: BaseCollectionViewCell {
    typealias MenuItem = MainMenuItem
    
    // MARK: -Setup
    
    override func setupCell() {
        super.setupCell()
        
        self.backgroundColor = UIColor.white
        
        self.addDropShadow()
        
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.lblTitle)
        
        self.imageView.autoCenterInSuperview()
        self.imageView.autoSetDimensions(to: .square(of: 75))
        
        self.lblTitle.autoPinEdge(.top, to: .bottom, of: self.imageView, withOffset: Style.padding.m)
        self.lblTitle.autoPinEdges(toSuperviewEdges: [.left, .right, .bottom], withInset: Style.padding.m)
    }
    
    // MARK: -Interface
    
    internal func prepareForDisplay(_ item: MenuItem) {
        self.imageView.image = item.image
        
        self.backgroundColor = item.color
        
        self.lblTitle.attributedText = NSAttributedString(
            string: item.title,
            attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: Style.fontSize.xl),
                .paragraphStyle: Style.centerParagraphStyle
        ])
    }
    
    // MARK: - Subviews
    
    private lazy var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
}
