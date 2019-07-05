//
//  ShoppingItem.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/11.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

final class ShoppingItem {
    internal var name: String
    internal var isBought: Bool
    
    private var dateModified: String
    
    init(name: String, isBought: Bool = false) {
        self.name = name
        self.isBought = isBought
        self.dateModified = "11 March 2019"
    }
    
    static internal func ==(lhs: ShoppingItem, rhs: ShoppingItem) -> Bool {
        return lhs.name == rhs.name && lhs.isBought == rhs.isBought
    }
    
    /// Sets the item to bought if not bought, or vice-versa
    internal func updateBoughtStatus() {
        self.isBought = !self.isBought
    }
}
