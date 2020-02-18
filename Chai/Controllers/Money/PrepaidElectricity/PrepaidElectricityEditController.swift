//
//  PrepaidElectricityEditController.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/16.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Eureka
import UIKit
import SwiftyBeaver

final class PrepaidElectricityEditController: FormViewController {
    
    enum Mode {
        case create
        case edit(PrepaidElectricityObject)
    }
    
    // MARK: Properties
    
    private let mode: Mode
    
    // MARK: Setup
    
    init(mode: Mode) {
        self.mode = mode
        super.init(style: .plain)
        
        self.setupTitle()
        self.navigationItem.setRightBarButton(self.btnSave, animated: true)
        self.setupForm(for: mode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitle() {
        switch self.mode {
        case .create: self.title = R.string.localizable.title_add()
        case .edit: self.title = R.string.localizable.title_edit()
        }
    }
    
    private func setupForm(for mode: Mode) {
        switch mode {
        case .create: break
        case .edit(let prepaidElectricity): self.prepopulateForm(with: prepaidElectricity)
        }
    }
    
    private func prepopulateForm(with prepaidElectricity: PrepaidElectricityObject) {
        self.rowBuyer.value = prepaidElectricity.buyer
        self.rowRandAmount.value = prepaidElectricity.randAmount
        self.rowCharges.value = prepaidElectricity.charges
        self.rowAmountBought.value = prepaidElectricity.amountBought
        self.rowDateBought.value = DateHelper.stringToDate(string: prepaidElectricity.dateBought)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.form +++ self.detailSection
            <<< self.rowBuyer
            <<< self.rowRandAmount
            <<< self.rowCharges
            <<< self.rowAmountBought
            <<< self.rowDateBought
        
        if case .edit = self.mode {
            self.form
                +++ self.advancedSection
                <<< self.rowDelete
        }
    }
    
    // MARK: -Subviews
    
    private lazy var btnSave: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(onSave))
        return button
    }()
    
    private lazy var detailSection: Section = Section("Detail")
    private lazy var advancedSection: Section = Section("Advanced")
    
    private lazy var rowBuyer: TextRow = {
        let row = TextRow()
        row.title = "Buyer"
        row.placeholder = "Who bought the voucher"
        return row
    }()
    
    private lazy var rowRandAmount: DecimalRow = {
        let row = DecimalRow()
        row.title = "Rand Amount"
        row.placeholder = "200.00"
        return row
    }()
    
    private lazy var rowCharges: DecimalRow = {
        let row = DecimalRow()
        row.title = "Charges"
        return row
    }()
    
    private lazy var rowAmountBought: DecimalRow = {
        let row = DecimalRow()
        row.title = "Amount bought (Kwh)"
        row.placeholder = "Amount"
        return row
    }()
    
    private lazy var rowDelete: ButtonRow = {
        let row = ButtonRow()
        row.title = "Delete"
        row.onCellSelection(self.onDelete)
        return row
    }()
    
    private lazy var rowDateBought: DateRow = {
        let row = DateRow()
        row.title = "Date bought"
        return row
    }()
}

// MARK: -Save action

extension PrepaidElectricityEditController {
    @objc private func onSave() {
        switch self.mode {
        case .create: self.addNewPrepaidElectricity()
        case .edit(let object): self.updatePrepaidElectricity(object)
        }
    }
    
    private func getObjectFromForm(appendTo: PrepaidElectricityObject? = nil) -> PrepaidElectricityObject {
        let object: PrepaidElectricityObject
        
        switch self.mode {
        case .create:
            object = PrepaidElectricityObject()
            
        case .edit(let oldObject):
            object = PrepaidElectricityObject(value: oldObject)
        }
        
        if let buyer: String = self.rowBuyer.value {
            object.buyer = buyer
        }
        
        if let randAmount: Double = self.rowRandAmount.value {
            object.randAmount = randAmount
        }
        
        if let charges: Double = self.rowCharges.value {
            object.charges = charges
        }
        
        if let amountBought: Double = self.rowAmountBought.value {
            object.amountBought = amountBought
        }
        
        if let dateBought: String = DateHelper.dateToString(date: self.rowDateBought.value) {
            object.dateBought = dateBought
        }
        
        return object
    }
    
    private func addNewPrepaidElectricity() {
        let object: PrepaidElectricityObject = self.getObjectFromForm()
        
        PrepaidElectricityDataService.create(prepaidElectricity: object) { (result) in
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
    
    private func updatePrepaidElectricity(_ object: PrepaidElectricityObject) {
        let object: PrepaidElectricityObject = self.getObjectFromForm(appendTo: object)
        
        PrepaidElectricityDataService.update(object) { (result) in
            switch result {
            case .success: self.handleSuccessUpdating()
            case .failure: self.handleFailureUpdating()
            }
        }
    }
    
    private func handleSuccessUpdating() {
        BannerService.shared.showBanner(title: "Updated prepaid electricity.", style: .success)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func handleFailureUpdating() {
        BannerService.shared.showBanner(title: "Failed updating prepaid electricity.", style: .danger)
    }
}

// MARK: -Delete action

extension PrepaidElectricityEditController {
    private func onDelete(cell: ButtonCellOf<String>, row: ButtonRow) {
        guard case .edit(let object) = self.mode
            else { return }
        
        SwiftyBeaver.info("Deleting prepaid electricity")
        PrepaidElectricityDataService.delete(object) { (result) in
            switch result {
            case .success: self.handleSuccessDeleting()
            case .failure: self.handleFailureDeleting()
            }
        }
    }
    
    private func handleSuccessDeleting() {
        BannerService.shared.showBanner(title: "Deleted prepaid electricity.", style: .success)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func handleFailureDeleting() {
        BannerService.shared.showBanner(title: "Unable to delete prepaid electricity.", style: .danger)
    }
}
