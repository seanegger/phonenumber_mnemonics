// WordList.swift
// Created for Assignment 5 of CSI 380

import Foundation

// YOU FILL IN HERE
// You'll want to create a mechanism here for loading and querying
// words.txt. It's up to you how you do this. You may consider a struct.

struct importQuery {
    let words: [String]
    init() {
        do{
            // Store contents of text file in words all converted to uppercase
           self.words = try String(contentsOfFile: "words.txt").components(separatedBy: .newlines).map( { $0.uppercased() } )
        }
        catch{
            print("Error in finding file")
            self.words = [""]
        }
    }

    public func minLength(_ minLength: UInt) -> [String]{
        return self.words.filter {$0.count >= minLength}
    }

}
