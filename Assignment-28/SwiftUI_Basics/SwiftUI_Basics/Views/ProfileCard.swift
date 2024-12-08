//
//  ProfileCard.swift
//  SwiftUI_Basics
//
//  Created by irakli kharshiladze on 06.12.24.
//

import SwiftUI

struct ProfileCard: View {
    @Binding var isOnline: Bool
    var body: some View {
        VStack (spacing: 10) {
            ZStack {
                Image("cat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 7)
                    )
                    .shadow(radius: 5)
                Text(isOnline ? "Online" : "Offline")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.white)
                    .bold()
                    .padding(.vertical, 2)
                    .padding(.horizontal, 5)
                    .background(isOnline ? Color.online : Color.offline)
                    .cornerRadius(12)
                    .padding(.leading, 70)
                    .padding(.top, 90)
                    .shadow(color: isOnline ? Color.online.opacity(0.3) : Color.offline.opacity(0.3), radius: 5, x: 0, y: 3)
            }
            Text("Beberi Kverna")
                .bold()
                .font(.system(size: 18))
                .foregroundStyle(Color.white)
            Text("iOS Developer")
                .foregroundStyle(Color.white)
                .font(.system(size: 16))
                .opacity(0.8)
        }
    }
}

#Preview {
    ProfileCard(isOnline: .constant(true))
}
