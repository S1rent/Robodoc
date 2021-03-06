//
//  String+Extensions.swift
//  Robodoc
//
//  Created by IT Division on 08/06/21.
//

import Foundation

extension String {
    func stemmed(withoutSeparator: Bool = true) -> String {
        let stopWords: [String] = [
            "doc", "docter", "doctor", "docters", "hospital", "have", "not", "a",
            "about", "above", "after", "again", "against", "all", "am", "an", "and", "any", "are", "aren't", "as",
            "at", "be", "because", "been", "before", "being", "below", "between", "both", "but", "by", "can't", "cannot",
            "could", "couldn't", "did", "didn't", "do", "does", "doesn't", "doing", "don't", "down", "during", "each", "few",
            "for", "from", "further", "had", "hadn't", "has", "hasn't", "have", "haven't", "having", "he", "he'd", "he'll",
            "he's", "her", "here", "here's", "hers", "herself", "herself", "him", "himself", "his", "how", "how's", "i", "i'd", "i'll", "i'm", "i've", "if", "in", "into", "is", "isn't", "it", "it's", "its", "itself", "let's", "me", "more", "most", "my", "mustn't", "myself", "no", "nor", "not", "of", "off", "on", "once", "only", "or", "other", "ought", "our", "ours", "ourselves", "out", "over", "own", "same", "shan't", "she", "she'd", "she'll", "she's", "should", "shouldn't", "so", "some", "such", "than", "that", "that's", "the", "their", "theirs", "them", "themselves", "then", "there", "there's", "these", "they", "they'd", "they'll", "they're", "they've", "this", "those", "through", "to", "too", "under", "until", "up", "very", "was", "wasn't", "we", "we'd", "we'll", "we're", "we've", "were", "weren't", "what", "what's", "when", "when's", "where", "where's", "which", "while", "who", "who's", "whom", "why", "why's", "with", "won't", "would", "wouldn't", "you", "you'd", "you'll", "you're", "you've", "your", "yours", "yourself", "yourselves", "suffer", "look", "looks", "like", "occurs", "think", "thought", "feel", "hello", "get", "im", "i'am", "uncle", "aunt", "mom", "dad", "mommy", "momma", "father", "mother", "uncle", "grandma", "grandpa", "family", "grandmother", "grandfather", "help", "if", "friend", "colleague", "friends", "colleagues", "hurt", "got", "keep", "time", "overtime", "please", "im", "always", "kinda", "reason", "sometimes", "sometime", "something", "feeling", "said", "suffering", "mention", "mentioned", "couple", "day", "days", "awfull", "awfully", "bad", "since"
        ]
        var newStemmedWords = ""
        var splitWord = self.replacingOccurrences(of: ",", with: "").split(separator: " ")
        for (index, sWord) in splitWord.enumerated() {
            for word in stopWords {
                if sWord == word {
                    splitWord[index] = ""
                }
            }
        }
        for word in splitWord {
            newStemmedWords += word
            if !withoutSeparator {
                newStemmedWords += " "
            }
        }
        if withoutSeparator {
            newStemmedWords = newStemmedWords.replacingOccurrences(of: " ", with: "")
        }
        //print("TESTING \(newStemmedWords)")
        return newStemmedWords
    }
    
    func checkNegativeAnswer() -> Bool {
        let possibleWord: [String] = [
            "no", "don't", "do not", "negative", "not", "nay", "nope", "tidak", "dont know", "dont"
        ]
        let splitWord = self.split(separator: " ")
        for possible in possibleWord {
            for word in splitWord {
                if word == possible { return true }
            }
        }
        
        return false
    }
    
    func checkPositiveAnswer() -> Bool {
        let possibleWord: [String] = [
            "yes", "do", "positive", "affirmative", "yep", "ye", "iya", "ayay", "do know", "know"
        ]
        for possible in possibleWord {
            if self.contains(possible) {
                return true
            }
        }
        
        return false
    }
}
