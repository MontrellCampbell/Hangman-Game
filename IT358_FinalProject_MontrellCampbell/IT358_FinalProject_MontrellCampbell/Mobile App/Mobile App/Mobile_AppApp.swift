//
//  Mobile_AppApp.swift
//  Mobile App
//
//  Created by user254287 on 5/1/24.
//

import SwiftUI

@main
struct Mobile_AppApp: App {
    @State var retrievedWord: String = ""

    var body: some Scene {
        
        WindowGroup {
            MainMenuView(retrievedWord: $retrievedWord)
        }
    }
}


