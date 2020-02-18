//
//  HomeView.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/14.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import UIKit
import SwiftyBeaver

protocol MainViewDelegate: class {
    func didSelect(_ menuItem: MainMenuItem)
}

final class MainView: BaseView {
    
    // MARK: -Delegate
    
    internal weak var delegate: MainViewDelegate?
    
    // MARK: -Setup
    override func setupView() {
        super.setupView()
        
        self.addSubview(self.collectionView)
        self.collectionView.autoPinEdgesToSuperviewSafeArea()
    }
    
    // MARK: -Subviews
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = Style.padding.xs
        layout.sectionInset = UIEdgeInsets(insetHorizontal: Style.padding.xs, insetVertical: Style.padding.m)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(cellType: MainMenuItemCell.self)
        collectionView.register(cellType: BlankCollectionCell.self)
        collectionView.dragDelegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
}

extension MainView: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return []
    }
}

extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainMenuItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let menuItem = MainMenuItem.allCases.item(at: indexPath.row)
            else { return self.getBlankCollectionCell(for: indexPath) }
        
        return self.getMenuItemCell(for: indexPath, menuItem: menuItem)
    }
    
    private func getBlankCollectionCell(for indexPath: IndexPath) -> UICollectionViewCell {
        return self.collectionView.dequeueReusableCell(for: indexPath, cellType: BlankCollectionCell.self)
    }
    
    private func getMenuItemCell(for indexPath: IndexPath, menuItem: MainMenuItem) -> UICollectionViewCell {
        let cell: MainMenuItemCell = self.collectionView.dequeueReusableCell(for: indexPath)
        cell.prepareForDisplay(menuItem)
        return cell
    }
}

extension MainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width/2.0 - Style.padding.s
        let collectionViewHeight = collectionViewWidth

        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
}

extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let menuItem = MainMenuItem.allCases.item(at: indexPath.row)
        else { return }
        
        SwiftyBeaver.info("Tapped on \(menuItem.title)")
        self.delegate?.didSelect(menuItem)
    }
}
