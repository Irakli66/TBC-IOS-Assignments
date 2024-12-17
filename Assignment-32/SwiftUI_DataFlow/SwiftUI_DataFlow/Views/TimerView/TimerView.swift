//
//  TimerView.swift
//  SwiftUI_DataFlow
//
//  Created by irakli kharshiladze on 11.12.24.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel = TimerViewModel()
    @State private var isActive: Bool = false
    @State private var alertMessage: String = ""
    @State private var timerName: String = ""
    @State private var hours: String = ""
    @State private var minutes: String = ""
    @State private var seconds: String = ""
    @State private var showAlert: Bool = false
    @State private var isSheetPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("ტაიმერები")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    
                    Button(action: {
                        isSheetPresented.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 80)
                .padding(.horizontal, 20)
                .background(Color.mineShaft)
                
                TimerCard()
                
                VStack(spacing: 12) {
                    TextField("", text: $timerName, prompt: Text("ტაიმერის სახელი...").foregroundStyle(.boulder))
                        .textFieldModifier(alignment: .leading)
                    HStack {
                        TextField("", text: $hours, prompt: Text("სთ").foregroundStyle(.boulder))
                            .textFieldModifier(alignment: .center)
                        TextField("", text: $minutes, prompt: Text("წთ").foregroundStyle(.boulder))
                            .textFieldModifier(alignment: .center)
                        TextField("", text: $seconds, prompt: Text("წმ").foregroundStyle(.boulder))
                            .textFieldModifier(alignment: .center)
                        
                    }
                    Button("დამატება"){
                        addTimer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 50)
                    .foregroundStyle(.white)
                    .background(.azure)
                    .cornerRadius(8)
                    .alert("Invalid Input", isPresented: $showAlert) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text(alertMessage)
                    }
                    
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.mineShaft)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.codGray)
            .overlay(
                ZStack {
                    if isSheetPresented {
                        Color.overlaycolor.opacity(0.7)
                            .blur(radius: 50)
                            .ignoresSafeArea()
                    }
                }
            )
            .sheet(isPresented: $isSheetPresented) {
                QuickTimersView()
                    .presentationDetents([.height(410), .medium, .height(600)])
                    .background(.codGray)
            }
            .environmentObject(viewModel)
        }
    }
    
    private func addTimer() {
        if timerName.isEmpty {
            alertMessage = "ტაიმერის სახელი ცარიელია. გთხოვთ შეავსოთ"
            showAlert = true
        } else if hours.isEmpty && minutes.isEmpty && seconds.isEmpty {
            alertMessage = "დროის ყველა ველი ცარიელია. გთხოვთ შეავსოთ ერთი ველი მაინც"
            showAlert = true
        } else {
            viewModel.addTimer(name: timerName, hours: hours, minutes: minutes, seconds: seconds)
            timerName = ""
            hours = ""
            minutes = ""
            seconds = ""
        }
        
    }
}

#Preview {
    TimerView()
}

