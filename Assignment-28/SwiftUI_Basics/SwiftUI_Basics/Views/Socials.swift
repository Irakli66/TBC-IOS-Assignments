//
//  Socials.swift
//  SwiftUI_Basics
//
//  Created by irakli kharshiladze on 06.12.24.
//

import SwiftUI

struct Socials: View {
    let socialIcons = ["phone", "mail", "website"]
    var body: some View {
        HStack (spacing: 30) {
            ForEach(socialIcons, id: \.self) { icon in
                Image("\(icon)")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .frame(width: 40, height: 40)
                    .background(Color.black.opacity(0.2))
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
            }
            
        }
    }
}

#Preview {
    Socials()
}
