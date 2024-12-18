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
    @State private var currentZoom = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("calculator")
                .scaleEffect(currentZoom)
                .rotationEffect(.degrees(rotationAngle))
                .animation(.easeInOut(duration: 0.5), value: rotationAngle)
                .onChange(of: rotateManager.shouldRotate) {
                    rotationAngle += 90
                }
                .onTapGesture {
                    rotateManager.doRotate()
                }
                .gesture(
                    MagnificationGesture()
                        .onChanged { scale in
                            currentZoom = max(0.5, min(scale, 3.0))
                        }
                )
            
            Spacer()
        }
    }
}

#Preview {
    RotateView(rotateManager: RotateManager())
}
