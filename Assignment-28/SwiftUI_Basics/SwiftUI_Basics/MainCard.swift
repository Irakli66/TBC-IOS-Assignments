//
//  ContentView.swift
//  SwiftUI_Basics
//
//  Created by irakli kharshiladze on 06.12.24.
//

import SwiftUI

struct MainCard: View {
    @State private var isOnline = false
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blueTop, .purpleBottom], startPoint: .topLeading, endPoint: .bottomTrailing)
                .cornerRadius(20)
                .opacity(0.65)
            
            VStack (spacing: 20) {
                ProfileCard(isOnline: $isOnline)
                Socials()
                
                VStack(alignment: .leading) {
                    SkillList()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text(isOnline ? "Set Offline" : "Set Online")
                        .foregroundStyle(Color.white)
                    Toggle("", isOn: $isOnline)
                }
                .frame(height: 25)
                .padding(.vertical, 12)
                .padding(.horizontal, 10)
                .background(Color.white.opacity(0.2))
                .cornerRadius(20)
                .padding(.top, 20)
                .padding(.horizontal, 30)
            }
            .padding(20)
        }
        .frame(width: 300, height: 500)
        .padding()
    }
}

#Preview {
    MainCard()
}
