// WordSearch.swift
// Created for Assignment 5 of CSI 380

import Foundation

// YOU FILL IN HERE
// Feel free to put in additional utility code as long as you have
// no loops, no *mutable* global variables, and no custom classes.

// Replaces each character in a phone number with an array of the
// possible letters that could be in place of that character
// For instance, 234 becomes [["A", "B", "C"], ["D", "E", "F"], ["G", "H", "I"]]
public func letters(for phoneNumber: String) -> [[String]] {
    // Map each number char to an array of letter chars
    let charArray = Array(phoneNumber).map { (numberChar: Character) -> [String] in
        if (numberChar == "0"){
            return ["0"]
        }
        if (numberChar == "1"){
            return ["1"]
        }
        if (numberChar == "2"){
            return ["A", "B", "C"]
        }
        if (numberChar == "3"){
            return ["D", "E", "F"]
        }
        if (numberChar == "4"){
            return ["G", "H", "I"]
        }
        if (numberChar == "5"){
            return ["J", "K", "L"]
        }
        if (numberChar == "6"){
            return ["M", "N", "O"]
        }
        if (numberChar == "7"){
            return ["P", "Q", "R", "S"]
        }
        if (numberChar == "8"){
            return ["T", "U", "V"]
        }
        if (numberChar == "9"){
            return ["W", "X", "Y", "Z"]
        }
        return []
    }
    return charArray
}

// Finds all of the ordered permutations of a given
// array of arrays of strings
// combining each choice in one
// array with each choice in the next array, and so on to produce strings
// For instance permuations(of: [["a", "b"], ["c"], ["d", "e"]]) will return
// ["acd", "ace" "bcd", "bce"]
// SOURCE: https://codereview.stackexchange.com/questions/111758/generating-phone-words-in-swift
public func permutations(of arrays: [[String]]) -> [String] {
    // YOU FILL IN HERE
    guard let prefixes = arrays.first else { return [] } 
    if (arrays.count <= 1){
        return prefixes
    }
    let lettersToAdd = permutations(of: Array(arrays.dropFirst(1))) // Reduces until there is one element left
    return prefixes.flatMap { letter in lettersToAdd.map {s in letter + s}} // dds them to each section mapping them to the new string
}

// Finds all of the possible strings of characters that a phone number
// can potentially represent
// Uses letters(for:) and permutations(of:) to do this
public func possibles(for phoneNumber: String) -> [String] {
    // return permutations() of letters()
    return permutations(of: letters(for: phoneNumber))
}

// Returns all of the words in a given *string* from the wordlist.txt file
// using only words in the word list of minimum length ofMinLength
public func wordsInString(_ string: String, ofMinLength length: UInt) -> [String] {
    // return the contents of the text file filtered where only words that the given string contains are added to the list.
    return importQuery().minLength(length).filter( { string.contains($0) })
}

// Returns all possibles strings of characters that a phone number
// can potentially represent that contain words in words.txt
// greater than or equal to ofMinLength characters
public func possiblesWithWholeWords(ofMinLength length: UInt, for phoneNumber: String) -> [String] {
    // filter the permutations where there is atleast one word from the text file in the string.
    return possibles(for: phoneNumber).filter( {wordsInString($0, ofMinLength: 0).count > 0} )
}

// Returns the phone number mnemonics that have the most words present in words.txt
// within them (note that these words could be overlapping)
// For instance, if there are two mnemonics that contain three words from
// words.txt, it will return both of them, if the are no other mnemonics
// that contain more than three words
public func mostWords(for phoneNumber: String) -> [String] {
    // Get all possible strings of characters that contain words that a phone number can represent
    let possibles = possiblesWithWholeWords(ofMinLength: 0, for: phoneNumber)
    // Get the most words found in any of these strings
    let mostWords = possibles.map({wordsInString($0, ofMinLength: 0).count}).max()
    // Filter out strings that contain less words than that
    return possibles.filter({ wordsInString($0, ofMinLength: 0).count == mostWords})
}

// Returns the phone number mnemonics with the longest words from words.txt
// If more than one word is tied for the longest, returns all of them
public func longestWords(for phoneNumber: String) -> [String] {
    // Get all possible strings of characters that contain words that a phone number can represent
    let possibles = possiblesWithWholeWords(ofMinLength: 0, for: phoneNumber)
    // filter by taking that list then get the longest word from that list then get the length of that word then check if any of the words contained in the value currently being tested is as long as the longest word.
    return possibles.filter({ possibles.map({ wordsInString($0, ofMinLength: 0).max( by: { $1.count > $0.count })! }).max( by: { $1.count > $0.count })!.count == wordsInString($0, ofMinLength: 0).max( by: { $1.count > $0.count })!.count })
}

