//
//  MainTabView.swift
//  TapGestures
//
//  Created by irakli kharshiladze on 18.12.24.
//
import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    @StateObject private var wheelManager = WheelManager()
    @StateObject private var rotateManager = RotateManager()
    
    let tabs = [
        ("spin", "spinActive", "Spin"),
        ("hold", "holdActive", "Hold"),
        ("rotate", "rotateActive", "Rotate"),
        ("trash", "trashActive", "Trash")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            TabContentView(selectedTab: selectedTab, wheelManager: wheelManager, rotateManager: rotateManager)
            
            HStack {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Spacer()
                    VStack {
                        Image(selectedTab == index ? tabs[index].1 : tabs[index].0)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text(tabs[index].2)
                            .font(.caption)
                            .foregroundColor(selectedTab == index ? .customGreen : .gray)
                    }
                    .onTapGesture {
                        if index == 0 {
                            wheelManager.resetAndTriggerSpin()
                        }
                        if index == 2 {
                            rotateManager.doRotate()
                        }
                        selectedTab = index
                    }
                    .onLongPressGesture(minimumDuration: 5) {
                        if index == 1 {
                            wheelManager.isBackgroundClear = true
                            let impact = UIImpactFeedbackGenerator(style: .medium)
                            impact.impactOccurred()
                        }
                    } onPressingChanged: { _ in
                        wheelManager.isBackgroundClear = false
                    }
                    
                    Spacer()
                }
            }
            .frame(height: 60)
            .padding(.vertical, 10)
            .padding(.bottom, 15)
            .background(.white)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(.customGreen)
    }
}

struct TabContentView: View {
    let selectedTab: Int
    let wheelManager: WheelManager
    let rotateManager: RotateManager
    
    var body: some View {
        switch selectedTab {
        case 0:
            WheelView(wheelManager: wheelManager)
        case 1:
            WheelView(wheelManager: wheelManager)
        case 2:
            RotateView(rotateManager: rotateManager)
        case 3:
            TrashView()
        default:
            Text("Unknown Tab")
        }
    }
}

#Preview {
    MainTabView()
}
