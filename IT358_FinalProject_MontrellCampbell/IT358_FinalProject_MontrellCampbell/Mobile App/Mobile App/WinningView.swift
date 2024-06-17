//
//  WinningView.swift
//  Mobile App
//
//  Created by user254287 on 5/7/24.
//

import SwiftUI

struct WinningView: View {
    @State private var menu = false
    @State private var retry = false
    @Binding var retrievedWord: String
    
    var body: some View {
        
        VStack{
            Text("You Win!")
                .font(.largeTitle)
                .bold()
                .padding(.top, 150)
                .foregroundColor(.white)
            
            Text("The word was \"\(retrievedWord)\"")
                .font(.title)
                .bold()
                .padding(.top, 150)
                .foregroundColor(.green)
            
            
            Button(action: {
                menu = true
            }){
                Image("menu-removebg-preview")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200,height: 250)
                    .padding(.bottom, 50)
                    .padding(.bottom, -150)
                
            }
            
            Button(action: {
                retry = true
            }){
                Image("retry-removebg-preview")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200,height: 250)
                    .padding(.bottom, 50)
                
            }
        }
        .background(Image("darkforestiphone"))
        .fullScreenCover(isPresented: $menu){
            MainMenuView(retrievedWord: $retrievedWord)
        }
        .fullScreenCover(isPresented: $retry){
            ContentView(retrievedWord: retrievedWord)
        }
    }

}
