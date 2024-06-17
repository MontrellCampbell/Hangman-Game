//
//  ContentView.swift
//  Mobile App
//
//  Created by user254287 on 5/1/24.
//

import SwiftUI

struct ContentView: View {
    @State var retrievedWord: String
    @State private var errorMessage: String?
    @State private var censoredWord: String = ""
    @State private var hangman: String = "Hangman"
    @State private var hangmanCount: Int = 1
    @State private var isLosingViewPresented = false
    @State private var isWinningViewPresented = false
    @State var lettersRow1 = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M"]
    @State var lettersRow2 = ["N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    
    @State private var letterClicked = false

    var body: some View {
        VStack {
            Spacer()
            Text("\(retrievedWord)")
                .font(.largeTitle)
                .bold()
                .padding(.top, 150)
        
            Image("\(hangman)\(hangmanCount)")
                .resizable()
                .scaledToFit()
                .frame(width: 200,height: 250)
                .padding(.bottom, 50)
            
            Spacer()
            
            HStack{
                ForEach(Array(censoredWord), id: \.self){ letter in
                action:do {
                        Text("  \(letter)")
                            .foregroundColor(.black)
                            .bold()
                            .font(.title2)
                    }
                }
            }
            
            
            VStack{
                HStack {
                    ForEach(Array(lettersRow1), id: \.self) { letter in
                        Button(action: {
                            if checkLetter(word: retrievedWord, letter: letter, censoredWord: censoredWord) == censoredWord {
                                hangmanCount += 1
                                if hangmanCount == 8 {
                                    isLosingViewPresented = true
                                }
                            } else {
                                censoredWord = checkLetter(word: retrievedWord, letter: letter, censoredWord: censoredWord)
                                if(censoredWord.lowercased() == retrievedWord.lowercased()){
                                    isWinningViewPresented = true
                                }
                            }
                            removeElementRow1(letter, from: &lettersRow1)
                        }) {
                            Text(String(letter))
                                .foregroundColor(.white)
                                .bold()
                                .font(.title2)
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 10)
                .fullScreenCover(isPresented: $isLosingViewPresented){
                    LosingView(retrievedWord: $retrievedWord)
                }
                .fullScreenCover(isPresented: $isWinningViewPresented){
                    WinningView(retrievedWord: $retrievedWord)
                }
                HStack{
                    ForEach(Array(lettersRow2), id: \.self){ letter in
                        Button(action: {
                            if checkLetter(word: retrievedWord, letter: letter, censoredWord: censoredWord) == censoredWord {
                                hangmanCount += 1
                                if hangmanCount == 8 {
                                    isLosingViewPresented = true
                                }
                            } else {
                                censoredWord = checkLetter(word: retrievedWord, letter: letter, censoredWord: censoredWord)
                                if(censoredWord.lowercased() == retrievedWord.lowercased()){
                                    isWinningViewPresented = true
                                }
                            }
                            removeElementRow2(letter, from: &lettersRow2)
                        }){
                            Text(String(letter))
                                .foregroundColor(.white)
                                .bold()
                                .font(.title2)
                        }
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 10)
                .fullScreenCover(isPresented: $isLosingViewPresented){
                    LosingView(retrievedWord: $retrievedWord)
                }
                .fullScreenCover(isPresented: $isWinningViewPresented){
                    WinningView(retrievedWord: $retrievedWord)
                }
                
            }
            .background(Color.gray)
            .cornerRadius(10)
            .padding()
            .frame(width: 1000, height: 400)
            Spacer()
            
        }
        .padding()
        
        .onAppear {
            wordAPICall { (word, error) in
                if let word = word {
                    if word.count > 8 {
                        wordAPICall { (newWord, error) in
                            if let newWord = newWord {
                                retrievedWord = newWord
                                censoredWord = String(repeating: "_", count: newWord.count)
                            }
                        }
                    } else {
                        retrievedWord = word
                        censoredWord = String(repeating: "_", count: word.count)
                    }
                }
            }
        }

    }
}



