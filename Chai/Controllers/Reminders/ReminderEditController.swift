//
//  ReminderEditController.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/14.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Eureka
import Foundation

class ReminderEditController: FormViewController {
    
    enum FormTags: String {
        case firstName = "FirstName"
        case surname = "Surname"
    }
    
    private lazy var sectionPersonalDetails: Section = {
        let section = Section("Personal Details")
        
        let firstName = TextRow(tag: FormTags.firstName.rawValue)
        let surname = TextRow(tag: FormTags.surname.rawValue)
        
        firstName.placeholder = "First Name"
        surname.placeholder = "Surname"
        
        section.append(firstName)
        section.append(surname)
        
        return section
    }()
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        
        self.title = "Hello!"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.form.append(sectionPersonalDetails)
    }
}
