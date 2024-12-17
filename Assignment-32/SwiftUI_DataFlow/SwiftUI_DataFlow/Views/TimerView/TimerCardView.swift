//
//  TimerCardView.swift
//  SwiftUI_DataFlow
//
//  Created by irakli kharshiladze on 17.12.24.
//
import SwiftUI

struct TimerCard: View {
    @EnvironmentObject var viewModel: TimerViewModel
    
    var body: some View {
        ScrollView {
            if viewModel.timers.isEmpty {
                VStack {
                    Spacer()
                    Text("ტაიმერები არ გაქვს, დაამატე")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 400)
            } else {
                LazyVStack(spacing: 15) {
                    ForEach(viewModel.timers.reversed(), id: \.self.id) { timer in
                        NavigationLink(destination: TimerDetailsView(timer: timer)) {
                            VStack(spacing: 15) {
                                HStack {
                                    Text(timer.name)
                                        .foregroundStyle(.white)
                                    Spacer()
                                    Button(action: {
                                        viewModel.removeTimer(with: timer.id)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundStyle(.redOrange)
                                    }
                                }
                                .padding(.horizontal, 20)
                                Text(timer.formatedTime(from: timer.duration))
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundStyle(.azure)
                                HStack {
                                    if !timer.isRunning {
                                        Button("დაწყება") {
                                            viewModel.startTimer(with: timer)
                                        }
                                        .buttonModifier(backgroundColor: .emerald)
                                    } else {
                                        Button("პაუზა") {
                                            viewModel.pauseTimer(with: timer)
                                        }
                                        .buttonModifier(backgroundColor: .pizazz)
                                    }
                                    
                                    Button("გადატვირთვა") {
                                        viewModel.resetTimer(with: timer)
                                    }
                                    .buttonModifier(backgroundColor: .redOrange)
                                }
                            }
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(.mineShaft)
                            .cornerRadius(16)
                            .padding(.horizontal, 15)
                        }
                    }
                }
            }
        }
    }
}


