//
//  ContentView.swift
//  TapGestures
//
//  Created by irakli kharshiladze on 17.12.24.
//

import SwiftUI

struct WheelView: View {
    @ObservedObject var wheelManager: WheelManager
    
    let colors: [Color] = [
        .red, .blue, .green, .yellow, .purple,
        .orange, .pink, .brown, .gray, .cyan,
        .indigo, .teal, .mint,
    ]
    @State var spin: Double = 0
    @State var count: Int = 13
    var body: some View {
        VStack {
            ZStack{
                ForEach(0..<count, id: \.self) { index in
                    Pie(startAngle: .degrees(Double(index) / Double(count) * 360), endAngle: .degrees(Double(index + 1) / Double(count) * 360))
                        .fill(wheelManager.isBackgroundClear ? .clear : colors[index % colors.count])
                        .stroke(.black)
                }
            }
            .rotationEffect(.degrees(spin))
            .onChange(of: wheelManager.makeSpin) {
                if wheelManager.makeSpin {
                    spinWheel()
                }
            }
            .onLongPressGesture(minimumDuration: 1) {
                wheelManager.isBackgroundClear = true
                let impact = UIImpactFeedbackGenerator(style: .medium)
                impact.impactOccurred()
            } onPressingChanged: { _ in
                wheelManager.isBackgroundClear = false
            }
            Spacer()
            
        }
        .padding()
        .background(.clear)
    }
    
    func spinWheel() {
        withAnimation(.spring(response: 2, dampingFraction: 1.5)) {
            spin += 720
        }
    }
}

#Preview {
    WheelView(wheelManager: WheelManager())
}
