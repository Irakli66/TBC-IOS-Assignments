//
//  RotateView.swift
//  TapGestures
//
//  Created by irakli kharshiladze on 18.12.24.
//

import SwiftUI

struct RotateView: View {
    @State private var rotationAngle: Double = 0
    @State private var currentZoom = 1.0
    @State private var gestureRotation: Angle = .zero
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("calculator")
                .scaleEffect(currentZoom)
                .rotationEffect(.degrees(rotationAngle) + gestureRotation)
                .animation(.easeInOut(duration: 0.5), value: rotationAngle)
                .gesture(
                    SimultaneousGesture(
                        MagnificationGesture()
                            .onChanged { scale in
                                currentZoom = max(0.5, min(scale, 3.0))
                            },
                        RotationGesture()
                            .onChanged { angle in
                                gestureRotation = angle
                            }
                            .onEnded { angle in
                                rotationAngle += angle.degrees
                                gestureRotation = .zero
                            }
                    )
                )
            
            Spacer()
        }
    }
}

#Preview {
    RotateView()
}
