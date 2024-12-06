//
//  SkillList.swift
//  SwiftUI_Basics
//
//  Created by irakli kharshiladze on 06.12.24.
//

import SwiftUI

struct SkillList: View {
    let skills = ["SwiftUI", "iOS Development", "Problem Solving", "UI/UX Design"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Skills")
                .foregroundStyle(Color.white)
                .bold()
            ForEach(skills, id: \.self) { skill in
                HStack(spacing: 8) {
                    Text("•")
                        .font(.system(size: 24))
                        .foregroundStyle(Color.white)
                        .opacity(0.8)
                    Text(skill)
                        .foregroundStyle(Color.white)
                        .opacity(0.8)
                }
                .padding(.leading, 10)
            }
        }
    }
}

#Preview {
    SkillList()
}

