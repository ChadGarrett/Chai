//
//  DebitOrderEditController.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/15.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Eureka
import UIKit
import SwiftyBeaver

final class DebitOrderEditController: FormViewController {
    
    enum Mode {
        case create
        case edit(DebitOrder)
    }
    
    // MARK: Properties
    
    private let mode: Mode
    
    // MARK: Setup
    
    init(mode: Mode) {
        self.mode = mode
        super.init(style: .plain)
        
        self.navigationItem.setRightBarButton(self.btnSave, animated: true)
        self.setupForm(for: mode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupForm(for mode: Mode) {
        switch mode {
        case .create: break
        case .edit(let debitOrder): self.prepopulateForm(with: debitOrder)
        }
    }
    
    private func prepopulateForm(with debitOrder: DebitOrder) {
        self.rowTitle.value = debitOrder.title
        self.rowDescription.value = debitOrder.descriptionAbout
        self.rowAmount.value = debitOrder.amount
        self.rowBillingDate.value = self.stringToDate(string: debitOrder.billingDate)
        self.rowStartDate.value = self.stringToDate(string: debitOrder.startDate)
        self.rowEndDate.value = self.stringToDate(string: debitOrder.endDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ self.aboutSection
            <<< self.rowTitle
            <<< self.rowDescription
            +++ self.detailSection
            <<< self.rowAmount
            <<< self.rowBillingDate
            <<< self.rowStartDate
            <<< self.rowEndDate
            
            
        // Sections only available when editing
        if case .edit = self.mode {
            form +++ self.advancedSection
                <<< self.rowDelete
        }
    }
    
    private func stringToDate(string date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: date)
    }
    
    private func dateToString(date: Date?) -> String? {
        guard let date = date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    // MARK: -Subviews
    
    private lazy var btnSave: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(onSave))
        return button
    }()
    
    private lazy var aboutSection: Section = Section("About")
    private lazy var detailSection: Section = Section("Detail")
    private lazy var advancedSection: Section = Section("Advanced")
    
    private lazy var rowTitle: TextRow = {
        let row = TextRow()
        row.title = "Title"
        row.placeholder = "Enter title"
        return row
    }()
    
    private lazy var rowDescription: TextRow = {
        let row = TextRow()
        row.title = "Description"
        row.placeholder = "Enter description"
        return row
    }()
    
    private lazy var rowAmount: DecimalRow = {
        let row = DecimalRow()
        row.title = "Amount"
        row.placeholder = "Enter the amount"
        row.value = 0
        return row
    }()
    
    private lazy var rowBillingDate: DateRow = {
        let row = DateRow()
        row.title = "Billing date"
        row.value = Date()
        return row
    }()
    
    private lazy var rowStartDate: DateRow = {
        let row = DateRow()
        row.title = "Start Date"
        row.value = Date()
        return row
    }()
    
    private lazy var rowEndDate: DateRow = {
        let row = DateRow()
        row.title = "End Date"
        row.value = Date()
        return row
    }()
    
    private lazy var rowDelete: ButtonRow = {
        let row = ButtonRow()
        row.title = "Delete"
        row.onCellSelection(self.onDelete)
        return row
    }()
}

// MARK: Save action

extension DebitOrderEditController {
    @objc private func onSave() {
        switch self.mode {
        case .create: self.addNewDebitOrder()
        case .edit(let debitOrder): self.updateDebitOrder(debitOrder)
        }
    }
    
    private func getDebitOrderFromForm(appendTo debitOrder: DebitOrder? = nil) -> DebitOrder {
        let order: DebitOrder
        
        switch self.mode {
        case .create:
            order = DebitOrder()
            
        case .edit(let oldDebitOrder):
            order = DebitOrder(value: oldDebitOrder) // Deep copy
        }
        
        if let title = self.rowTitle.value {
            order.title = title
        }
        
        if let description = self.rowDescription.value {
            order.descriptionAbout = description
        }
        
        if let amount = self.rowAmount.value {
            order.amount = amount
        }
        
        if let billingDate = self.dateToString(date: self.rowBillingDate.value) {
            order.billingDate = billingDate
        }
        
        if let startDate = self.dateToString(date: self.rowStartDate.value) {
            order.startDate = startDate
        }
        
        if let endDate = self.dateToString(date: self.rowEndDate.value) {
            order.endDate = endDate
        }
        
        return order
    }
    
    private func addNewDebitOrder() {
        let debitOrder: DebitOrder = self.getDebitOrderFromForm()
        
        DebitOrderDataService.createDebitOrder(debitOrder: debitOrder) { (result) in
            switch result {
            case .success: self.handleSuccessAdding()
            case .failure: self.handleFailureAdding()
            }
        }
    }
    
    private func handleSuccessAdding() {
        BannerService.shared.showBanner(title: "Created new debit order", style: .success)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func handleFailureAdding() {
        BannerService.shared.showBanner(title: "Failed creating debit order", style: .danger)
    }
    
    private func updateDebitOrder(_ debitOrder: DebitOrder) {
        let debitOrder: DebitOrder = self.getDebitOrderFromForm(appendTo: debitOrder)
        
        DebitOrderDataService.updateDebitOrder(debitOrder: debitOrder) { (result) in
            switch result {
            case .success: self.handleSuccessUpdating()
            case .failure: self.handleFailureUpdating()
            }
        }
    }
    
    private func handleSuccessUpdating() {
        BannerService.shared.showBanner(title: "Updated debit order.", style: .success)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func handleFailureUpdating() {
        BannerService.shared.showBanner(title: "Failed updating debit order.", style: .danger)
    }
}

// MARK: Delete action

extension DebitOrderEditController {
    private func onDelete(cell: ButtonCellOf<String>, row: ButtonRow) {
        guard case .edit(let debitOrder) = self.mode
            else { return }
        
        SwiftyBeaver.info("Deleting debit order.")
        DebitOrderDataService.deleteDebitOrder(debitOrder: debitOrder) { (result) in
            switch result {
            case .failure: self.handleFailureDeleting()
            case .success: self.handleSuccessDeleting()
            }
        }
    }
    
    private func handleSuccessDeleting() {
        BannerService.shared.showBanner(title: "Deleted debit order.", style: .success)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func handleFailureDeleting() {
        BannerService.shared.showBanner(title: "Unable to delete debit order.", style: .danger)
    }
}
