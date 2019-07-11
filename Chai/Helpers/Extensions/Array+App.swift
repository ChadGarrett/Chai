//
//  Array+App.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/11.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation

extension Array {
    func isIndexValid(_ index: Int) -> Bool {
        return index >= 0 && index < count
    }
    
    /// Safe index operator. Returns the item at the index if it doesn't exceed the array's range.
    func item(at index: Int) -> Element? {
        guard isIndexValid(index) else { return nil }
        return self[index]
    }
}
