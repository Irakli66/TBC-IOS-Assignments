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
    
    let tabs = [
        ("spin", "spinActive", "Spin"),
        ("hold", "holdActive", "Hold"),
        ("rotate", "rotateActive", "Rotate"),
        ("trash", "trashActive", "Trash")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            TabContentView(selectedTab: selectedTab, wheelManager: wheelManager)
            
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
                        selectedTab = index
                    }
                    .onLongPressGesture(minimumDuration: 5) {
                        if index == 1 {
                            wheelManager.isBackgroundClear = true
                        }
                    } onPressingChanged: { test in
                        wheelManager.isBackgroundClear = false
                    }
                    
                    Spacer()
                }
            }
            .frame(height: 60)
            .background(.white)
            .padding(.bottom, 15)
        }
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct TabContentView: View {
    let selectedTab: Int
    let wheelManager: WheelManager
    
    var body: some View {
        switch selectedTab {
        case 0:
            WheelView(wheelManager: wheelManager)
        case 1:
            WheelView(wheelManager: wheelManager)
        case 2:
            RotateView()
        case 3:
            TrashView()
        default:
            Text("Unknown Tab")
        }
    }
}

struct RotateView: View { var body: some View { Text("Rotate View") } }
struct TrashView: View { var body: some View { Text("Trash View") } }

#Preview {
    MainTabView()
}
