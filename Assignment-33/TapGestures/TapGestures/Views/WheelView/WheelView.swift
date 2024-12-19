//
//  ContentView.swift
//  TapGestures
//
//  Created by irakli kharshiladze on 17.12.24.
//

import SwiftUI

struct WheelView: View {
    @ObservedObject var wheelManager: WheelManager
    
    @State var spin: Double = 0
    @State var count: Int = 0
    var body: some View {
        VStack {
            Button("Add Segment") {
                count += 1
            }
            .padding(10)
            .background(.purple)
            .foregroundStyle(.white)
            .cornerRadius(12)
            
            if count == 0 {
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color.black.opacity(0.4))
                        .frame(width: 370, height: 370)
                    Text("Add Segments to see the wheel")
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .bold))
                }
            }
            
            ZStack{
                ForEach(0..<count, id: \.self) { index in
                    Pie(startAngle: .degrees(Double(index) / Double(count) * 360), endAngle: .degrees(Double(index + 1) / Double(count) * 360))
                        .fill(wheelManager.isBackgroundClear ? .clear : Color.Random())
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
            spin += 1080
        }
    }
}

#Preview {
    WheelView(wheelManager: WheelManager())
}
