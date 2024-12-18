//
//  RotateView.swift
//  TapGestures
//
//  Created by irakli kharshiladze on 18.12.24.
//

import SwiftUI

struct RotateView: View {
    @ObservedObject var rotateManager: RotateManager
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("calculator")
                .rotationEffect(.degrees(rotationAngle))
                .animation(.easeInOut(duration: 0.5), value: rotationAngle)
                .onChange(of: rotateManager.shouldRotate) {
                    rotationAngle += 90
                }
                .onTapGesture {
                    rotateManager.doRotate()
                }
            Spacer()
        }
    }
}


#Preview {
    RotateView(rotateManager: RotateManager())
}
