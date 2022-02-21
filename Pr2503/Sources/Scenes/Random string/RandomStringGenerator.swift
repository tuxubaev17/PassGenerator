//
//  RandomStringGenerator.swift
//  Pr2503
//
//  Created by Admin on 21.02.2022.
//

import Foundation

class RandomStringGenerator {
    
    static func randomString(completion: @escaping (String) -> (Void)) {
       DispatchQueue.global(qos: .userInitiated).async {
           var letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
           let rndPswd = String((0..<3).compactMap({ _ in letters.randomElement()! }))
           print(rndPswd)
           completion(rndPswd)
       }
       
    }
}
