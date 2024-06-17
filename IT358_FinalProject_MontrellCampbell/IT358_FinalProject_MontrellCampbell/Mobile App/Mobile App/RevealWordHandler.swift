//
//  RevealWordHandler.swift
//  Mobile App
//
//  Created by user254287 on 5/1/24.
//

import Foundation

    
    func checkLetter(word: String, letter: String, censoredWord: String) -> String{
        
        var indicies: [Int] = []
        var updatedCensored = Array(censoredWord)
        
        
        for (index, char) in word.enumerated(){
            if String(char) == letter.lowercased() || String(char) == letter{
                indicies.append(index)
            }
        }
        
        for i in indicies{
            updatedCensored[i] = Character(letter)
        }
        
        return String(updatedCensored)
    
}

func removeElementRow1(_ element: String, from lettersRow1: inout [String]){
    lettersRow1.removeAll { $0 == element }
}

func removeElementRow2(_ element: String, from lettersRow2: inout [String]){
    lettersRow2.removeAll { $0 == element }
}
