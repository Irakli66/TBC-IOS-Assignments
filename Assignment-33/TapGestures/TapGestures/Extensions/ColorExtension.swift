//
//  ColorExtension.swift
//  TapGestures
//
//  Created by irakli kharshiladze on 18.12.24.
//
import SwiftUI

extension Color {
    static func Random() -> Color {
        let colors: [Color] = [
            .red, .blue, .green, .yellow, .purple,
            .orange, .pink, .brown, .gray, .cyan,
            .indigo, .teal, .mint
        ]
        return colors.randomElement() ?? .blue
    }
}
