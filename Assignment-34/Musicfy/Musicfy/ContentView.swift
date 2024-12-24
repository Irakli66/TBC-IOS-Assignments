//
//  ContentView.swift
//  Musicfy
//
//  Created by irakli kharshiladze on 24.12.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.mainBackground
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.customShape)
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
        }
    }
}

#Preview {
    ContentView()
}
