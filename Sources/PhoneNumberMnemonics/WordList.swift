// WordList.swift
// Created for Assignment 5 of CSI 380

import Foundation

// YOU FILL IN HERE
// You'll want to create a mechanism here for loading and querying
// words.txt. It's up to you how you do this. You may consider a struct.

struct importQuery {
    var fileFound = false
    let filename = "../../words.txt"
    do{
        let words = try String(contentsOfFile: filename).components(separatedBy: .newlines)
        fileFound = true
    }
    catch{
        print("Something went wrong. File not found")
        fileFound = false
    }
    
}
