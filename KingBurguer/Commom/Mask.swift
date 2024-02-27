//
//  Mask.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 27/02/24.
//

import Foundation


class Mask {
    private let mask: String
    var oldString = ""
    
    init(mask: String) {
        self.mask = mask
    }
    
    private func replaceChars(value: String) -> String{
        return value.replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "/", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
    
    func process(value: String) -> String? {
        if value.count > mask.count {
            return String(value.dropLast())
        }
        
        let str = replaceChars(value: value)
        
        let isDeleting = str <= oldString
        
        if value.count == mask.count {
            return nil
        }
        
        
        oldString = str
        var result = ""
       
        
        var i = 0
        for char in mask {
            if char != "#" {
                //pula a logica dessa iteração e vai pra próxima
                if isDeleting {
                    continue
                }
                result = result + String(char)
            } else {
                let character = str.charAtIndex(index: i)
                guard let c = character else { break }
                result  = result + String(c)
                
                i = i + 1
            }
        }
        
        return result
    }
}
