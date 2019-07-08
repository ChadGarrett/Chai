//
//  ReminderAddView.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import UIKit

protocol ReminderAddViewDelegate: class {
    func onAdd()
}

class ReminderAddView: AppView {
    
    // Delegate
    
    internal weak var delegate: ReminderAddViewDelegate?
    
    // Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Style.colors.clouds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        super.setupView()
        
        self.addSubview(self.lblHeading)
        self.addSubview(self.txtReminder)
        self.addSubview(self.txtDateTimePicker)
        self.addSubview(self.btnAdd)
        
        self.lblHeading.autoPinEdge(toSuperviewEdge: .top, withInset: Style.padding.s)
        self.lblHeading.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.lblHeading.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)
        
        self.txtReminder.autoPinEdge(.top, to: .bottom, of: self.lblHeading, withOffset: Style.padding.xxs)
        self.txtReminder.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.txtReminder.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)
        
        self.txtDateTimePicker.autoPinEdge(.top, to: .bottom, of: self.txtReminder, withOffset: Style.padding.xxs)
        self.txtDateTimePicker.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.txtDateTimePicker.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)
        
        self.btnAdd.autoPinEdge(.top, to: .bottom, of: self.txtDateTimePicker, withOffset: Style.padding.xs)
        self.btnAdd.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.btnAdd.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)
        self.btnAdd.autoPinEdge(toSuperviewEdge: .bottom, withInset: Style.padding.s)
    }
    
    // Subviews
    
    private lazy var lblHeading: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: R.string.localizable.heading_add_reminder())
        return label
    }()
    
    private lazy var txtReminder: UITextField = {
        let textField = UITextField()
        textField.placeholder = R.string.localizable.placeholder_add_reminder()
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.delegate = self
        return textField
    }()
    
    private lazy var btnAdd: ConfirmButton = {
        let button = ConfirmButton(R.string.localizable.button_add())
        button.addTarget(self, action: #selector(onAdd), for: .touchUpInside)
        return button
    }()
    
    private lazy var txtDateTimePicker: UITextField = {
        let textField = UITextField()
        textField.inputView = self.dateTimePickerView
        return textField
    }()
    
    private lazy var dateTimePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(onDateChanged), for: .valueChanged) // TODO: Necessary?
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.setDate(Date().addingTimeInterval(TimeInterval(exactly: 60)!), animated: true) // One hour from now
        return datePicker
    }()
    
    // Interface
    
    internal func getReminder() -> Reminder? {
        guard let text = self.txtReminder.text
            else { return nil }
        
        let reminder = Reminder()
        reminder.text = text
        reminder.date = self.dateTimePickerView.date
        reminder.isComplete = false
        return reminder
    }
    
    // Actions
    
    @objc private func onAdd() {
        self.delegate?.onAdd()
        self.resetView()
    }
    
    @objc private func onDateChanged() {
        self.txtDateTimePicker.text = dateTimePickerView.date.description
    }
    
    /// Once a reminder has been added, close any persisting keyboards and clear input fields
    private func resetView() {
        self.txtReminder.attributedText = nil
        self.txtDateTimePicker.text = nil
        self.dateTimePickerView.date = Date()
        self.txtDateTimePicker.resignFirstResponder()
    }
}

extension ReminderAddView: UITextFieldDelegate {
    // TODO: Enable/disable add button if there is not content to be added
}
