//
//  RandomStringGenerator.swift
//  Pr2503
//
//  Created by Admin on 21.02.2022.
//

import Foundation

class RandomStringGenerator {
    
   static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
