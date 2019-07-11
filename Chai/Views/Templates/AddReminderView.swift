//
//  AddReminderView.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import UIKit

protocol AddReminderDelegate: class {
    func onAdd()
}

/// View used to add a reminder
/// Displays a textfield, datepicker and button
class AddReminderView: AppView {
    
    // Delegate
    
    internal weak var delegate: AddReminderDelegate?
    
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
        
        self.addSubview(self.txtReminder)
        self.addSubview(self.txtPersonResponisble)
        self.addSubview(self.txtDateTimePicker)
        self.addSubview(self.btnAdd)
        
        self.txtReminder.autoPinEdge(toSuperviewEdge: .top, withInset: Style.padding.s)
        self.txtReminder.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.txtReminder.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)
        
        self.txtPersonResponisble.autoPinEdge(.top, to: .bottom, of: self.txtReminder, withOffset: Style.padding.s)
        self.txtPersonResponisble.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.txtPersonResponisble.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)
        
        self.txtDateTimePicker.autoPinEdge(.top, to: .bottom, of: self.txtPersonResponisble, withOffset: Style.padding.s)
        self.txtDateTimePicker.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.txtDateTimePicker.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)
        
        self.btnAdd.autoPinEdge(.top, to: .bottom, of: self.txtDateTimePicker, withOffset: Style.padding.s)
        self.btnAdd.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.btnAdd.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)
        self.btnAdd.autoPinEdge(toSuperviewEdge: .bottom, withInset: Style.padding.s)
    }
    
    // Subviews
    
    private lazy var txtReminder: UITextField = {
        let textField = UITextField()
        textField.placeholder = R.string.localizable.placeholder_add_reminder()
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.addTarget(self, action: #selector(textFieldDidEdit(_:)), for: .editingChanged)
        textField.delegate = self
        return textField
    }()
    
    private lazy var txtPersonResponisble: UITextField = {
        let textField = UITextField()
        textField.placeholder = R.string.localizable.placeholder_reminder_person_responsible()
        textField.clearButtonMode = .whileEditing
        textField.inputAccessoryView = self.tbResponsibleSuggestions
        textField.addTarget(self, action: #selector(textFieldDidEdit(_:)), for: .editingChanged)
        textField.delegate = self
        textField.autocorrectionType = UITextAutocorrectionType.no
        return textField
    }()
    
    private lazy var tbResponsibleSuggestions: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.items = self.getResponsiblePersonSuggestions()
        toolbar.sizeToFit()
        return toolbar
    }()
    
    /// Returns quick actions for selecting a person responsible
    private func getResponsiblePersonSuggestions() -> [UIBarButtonItem] {
        var items: [UIBarButtonItem] = []
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        User.allCases.forEach { user in
            let item = UIBarButtonItem(title: user.firstName, style: .done, target: self, action: #selector(onResponsibleSuggestion(_:)))
            item.tag = user.rawValue
            items.append(item)
        }
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        return items
    }
    
    private lazy var txtDateTimePicker: UITextField = {
        let textField = UITextField()
        textField.inputView = self.dateTimePickerView
        textField.inputAccessoryView = self.tbBtnDone
        textField.placeholder = R.string.localizable.placeholder_reminder_date()
        return textField
    }()
    
    private lazy var dateTimePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(onDateChanged), for: .valueChanged)
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.minimumDate = Date() // Cannot set reminders in the past
        datePicker.setDate(Date().addingTimeInterval(TimeInterval(exactly: 60)!), animated: true) // One hour from now
        datePicker.minuteInterval = 15
        return datePicker
    }()
    
    private lazy var tbBtnDone: UIToolbar = {
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnDone = UIBarButtonItem(title: R.string.localizable.button_done(), style: .done, target: self, action: #selector(onCloseKeyboard))
        toolbar.items = [flexibleSpace, btnDone]
        toolbar.sizeToFit()
        return toolbar
    }()
    
    private lazy var btnAdd: ConfirmButton = {
        let button = ConfirmButton(R.string.localizable.button_add())
        button.addTarget(self, action: #selector(onAdd), for: .touchUpInside)
        button.isEnabled = false // Until updated
        return button
    }()
    
    // Interface
    
    internal func getReminder() -> Reminder? {
        guard let text = self.txtReminder.text
            else { return nil }
        
        let reminder = Reminder()
        reminder.text = text
        reminder.date = self.dateTimePickerView.date
        reminder.isComplete = false
        reminder.personResponsible = self.txtPersonResponisble.text ?? ""
        return reminder
    }
    
    // Actions
    
    @objc private func onAdd() {
        self.delegate?.onAdd()
        self.resetView()
    }
    
    @objc private func onDateChanged() {
        self.txtDateTimePicker.text = dateTimePickerView.date.weekdayMonthDayHourMinute
    }
    
    @objc private func onCloseKeyboard() {
        self.txtDateTimePicker.endEditing(true)
    }
    
    /// Once a reminder has been added, close any persisting keyboards and clear input fields
    private func resetView() {
        self.txtReminder.attributedText = nil
        self.txtDateTimePicker.text = nil
        self.dateTimePickerView.date = Date()
        self.txtDateTimePicker.resignFirstResponder()
        self.btnAdd.isEnabled = false
    }
}

extension AddReminderView: UITextFieldDelegate {
    // Toggle add button enabledness
    @objc private func textFieldDidEdit(_ textField: UITextField) {
        if textField === self.txtReminder {
            guard let text = textField.text
                else { return }
            
            self.btnAdd.isEnabled = !(text.isEmpty)
            
        }
        
        if textField === self.txtPersonResponisble {
            // N/A
        }
    }
    
    @objc private func onResponsibleSuggestion(_ item: UIBarButtonItem) {
        if let person = User(rawValue: item.tag) {
            self.txtPersonResponisble.text = person.firstName
        }
    }
}
