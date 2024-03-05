//
//  Strings.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 16/02/24.
//

import Foundation


extension String {
    func isEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        //no caso self é a própria string
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    func charAtIndex(index: Int) -> Character? {
        var indexCurrent = 0
        for char in self {
            if index == indexCurrent {
                return char
            }
            indexCurrent = indexCurrent + 1
        }
        return nil
    }
}
