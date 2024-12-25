//
//  MusicfyApp.swift
//  Musicfy
//
//  Created by irakli kharshiladze on 24.12.24.
//

import SwiftUI

@main
struct MusicfyApp: App {
    @AppStorage("isDarkTheme") private var isDarkTheme = false
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(isDarkTheme ? .dark : .light)
        }
    }
}
