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
           self.words = try String(contentsOfFile: "/home/ty/Documents/phonenum/phonenumber_mnemonics/words.txt").components(separatedBy: .newlines).map { $0.lowercased() }
           //print("file found")
           //print(self.words)
        }
        
        catch{
            print("Error in finding file")
            self.words = [""]
        }
    }
        /*
    init(){
        self.filename = 
        do{
            
            self.fileFound = true
        }
        catch{
            print("Something went wrong. File not found")
            self.fileFound = false 
        }

    }
    */

    public func minLength(_ minLength: UInt) -> [String]{
        return self.words.filter {$0.count > minLength}
    }

}
