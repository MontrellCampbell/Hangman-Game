//
//  MainMenuView.swift
//  Mobile App
//
//  Created by user254287 on 5/7/24.
//

import SwiftUI

struct MainMenuView: View {
    @State private var play = false
    @Binding var retrievedWord: String
    
    var body: some View {
        
        VStack{
            Text("Hangman")
                .font(
                    .custom("AmericanTypewriter", fixedSize: 40))
                .bold()
                .padding(.top, 150)
                .foregroundColor(.white)
                
            Spacer()
            Button(action: {
                play = true
            }){
                Image("play-removebg-preview")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200,height: 250)
                    .padding(.bottom, 50)
                
            }
            
        }
        .background(Image("darkforestiphone"))
        .fullScreenCover(isPresented: $play) {
            ContentView(retrievedWord: retrievedWord)
        }
    }
    
}

