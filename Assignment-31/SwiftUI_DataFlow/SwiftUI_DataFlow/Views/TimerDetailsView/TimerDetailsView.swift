//
//  TimerDetailsView.swift
//  SwiftUI_DataFlow
//
//  Created by irakli kharshiladze on 13.12.24.
//

import SwiftUI

struct TimerDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    private let timers = [1,2,3,4,5,6,7,8,9,10]
    var timer: TimerModel
    var body: some View {
        VStack (spacing: 12){
            ZStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                            .font(.system(size: 18, weight: .bold))
                            .padding(.leading, 25)
                    }
                    Spacer()
                }
                Text(timer.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 80)
            .background(Color.mineShaft)
            
            GeometryReader { geometry in
                let isSmallDevice = geometry.size.width < 376
                
                VStack(spacing: isSmallDevice ? 16 : 22) {
                    Image("stopwatch")
                    Text("ხანგრძლივობა")
                        .foregroundStyle(.white)
                        .font(.system(size: isSmallDevice ? 16 : 18, weight: .medium))
                    Text(timer.formatedTime(from: timer.defaultDuration))
                        .foregroundStyle(.azure)
                        .font(.system(size: isSmallDevice ? 32 : 38, weight: .bold))
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(
                    top: isSmallDevice ? 45 : 65,
                    leading: 20,
                    bottom: isSmallDevice ? 55 : 85,
                    trailing: 20
                ))
                .background(.mineShaft)
                .cornerRadius(16)
                .padding(.horizontal, 15)
            }
            
            VStack (spacing: 17) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("აქტივობის ისტორია")
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .medium))
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    HStack {
                        Text("თარიღი")
                            .foregroundStyle(.white)
                            .font(.system(size: 14, weight: .medium))
                        Spacer()
                        Text("დრო")
                            .foregroundStyle(.white)
                            .font(.system(size: 14, weight: .medium))
                    }
                    .padding(.trailing, 26)
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 12) {
                            ForEach(timer.history, id: \.self) { historyEntry in
                                HStack {
                                    let dateString = historyEntry["date"] ?? ""
                                    Text(dateString)
                                        .foregroundStyle(.white)
                                        .font(.system(size: 14, weight: .medium))
                                    
                                    Spacer()
                                    
                                    if let timeUsedString = historyEntry["timeUsed"],
                                       let timeUsed = Int(timeUsedString) {
                                        let formattedTime = timer.formatedTime(from: TimeInterval(timeUsed))
                                        Text(formattedTime)
                                            .foregroundStyle(.white)
                                            .font(.system(size: 14, weight: .medium))
                                    } else {
                                        Text("00:00:00")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 14, weight: .medium))
                                    }
                                }
                            }
                        }
                        .padding(.leading, 5)
                    }
                    
                }
                .padding(.leading, 12)
                .padding(.trailing, 20)
            }
            .padding(.top, 31)
            .padding(.horizontal, 15)
            .background(.mineShaft)
            .cornerRadius(12)
            .padding(.horizontal, 15)
            
        }
        .background(.codGray)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TimerDetailsView(timer: TimerModel(name: "ვარჯიში", duration: 2700, defaultDuration: 2700))
}
