//
//  StringExtension.swift
//  Pr2503
//
//  Created by Admin on 21.02.2022.
//

import Foundation

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
    
    static func random(length: Int = 10) -> String {

        let printable = String().printable.map { String($0) }
        var randomString = ""

        for _ in 0 ..< length {
            randomString.append(printable.randomElement()!)
        }
        return randomString
    }
    
    func split(by length: Int = 2) -> [String] {
        var startIndex = self.startIndex
        var result = [Substring]()
        
        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            result.append(self[startIndex..<endIndex])
            startIndex = endIndex
         }
    
        return result.map { String($0) }
    }
}
