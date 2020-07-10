//
//  SettingsController.swift
//  Chai
//
//  Created by Chad Garrett on 2020/07/08.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import SwiftyBeaver

final class SettingsController: BaseViewController {
    
    override func setupView() {
        self.title = "Settings"
        
        self.view.addSubview(self.tableView)
        self.tableView.autoPinEdgesToSuperviewEdges()
    }
    
    // MARK: Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(cellType: ButtonCell.self)
        tableView.dataSource = self
        return tableView
    }()
}

// MARK: Section enums
extension SettingsController {
    private enum SettingSection: Int, CaseIterable {
        
        /// Settings related to managing defaults and storage for the app
        case housekeeping
    }
    
    private enum HouseKeepingSection: Int, CaseIterable {
        case reset
    }
    
    private func getSectionType(from section: Int) -> SettingSection? {
        return SettingSection(rawValue: section)
    }
}

// MARK: UITableViewDataSource
extension SettingsController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionType = self.getSectionType(from: section)
            else { return nil }
        
        switch sectionType {
        case .housekeeping:
            return "House Keeping"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = self.getSectionType(from: section)
            else { return 0 }
        
        switch sectionType {
        case .housekeeping:
            return HouseKeepingSection.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = self.getSectionType(from: indexPath.section)
            else { return tableView.dequeueBlankCell(for: indexPath) }
        
        switch sectionType {
        case .housekeeping:
            return self.getHouseKeepingRow(for: indexPath)
        }
    }
}

// MARK: Table cells
extension SettingsController {
    private func getHouseKeepingRow(for indexPath: IndexPath) -> UITableViewCell {
        guard let houseKeepingRow = HouseKeepingSection(rawValue: indexPath.row)
            else { return self.tableView.dequeueBlankCell(for: indexPath) }
        
        switch houseKeepingRow {
        case .reset:
            let cell: ButtonCell = self.tableView.dequeueReusableCell(for: indexPath)
            cell.prepareForDisplay(buttonText: "Reset")
            cell.delegate = self
            return cell
        }
    }
}

// MARK:
extension SettingsController: ButtonCellDelegate {
    func onAction(at indexPath: IndexPath) {
        guard let sectionType = self.getSectionType(from: indexPath.section)
            else { return }
        
        switch sectionType {
        case .housekeeping:
            self.handleHouseKeepingActions(at: indexPath)
        }
    }
    
    private func handleHouseKeepingActions(at indexPath: IndexPath) {
        guard let houseKeepingRow = HouseKeepingSection(rawValue: indexPath.row)
            else { return }
        
        switch houseKeepingRow {
        case .reset:
            self.resetApp()
        }
    }
    
    private func resetApp() {
        SwiftyBeaver.info("RESETING APP!")
        
        SwiftyBeaver.info("Emptying Realm")
        DBManager().deleteAllFromDatabase()
        
        BannerService.shared.showBanner(title: "Reset app", style: .danger)
    }
}
