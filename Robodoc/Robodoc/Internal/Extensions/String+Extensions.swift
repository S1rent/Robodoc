//
//  String+Extensions.swift
//  Robodoc
//
//  Created by IT Division on 08/06/21.
//

import Foundation

extension String {
    func stemmed() -> String {
        return self
    }
    
    func checkNegativeAnswer() -> Bool {
        let possibleWord: [String] = [
            "n", "no", "don't", "do not", "negative", "not", "nay", "nope", "tidak", "dont know", "dont"
        ]
        
        for possible in possibleWord {
            if self.contains(possible) {
                return true
            }
        }
        
        return false
    }
    
    func checkPositiveAnswer() -> Bool {
        let possibleWord: [String] = [
            "y", "yes", "do", "positive", "affirmative", "yep", "ye", "iya", "ayay", "do know", "know"
        ]
        for possible in possibleWord {
            if self.contains(possible) {
                return true
            }
        }
        
        return false
    }
}
