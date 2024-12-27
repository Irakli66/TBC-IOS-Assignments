//
//  RiddleDetailsCard.swift
//  Emoji-Riddle
//
//  Created by irakli kharshiladze on 27.12.24.
//

import SwiftUI

struct RiddleDetailsCard: View {
    @StateObject private var viewModel = HomeViewModel()
    @State var riddle: RiddleModel?
    @State private var selectedAnswer: String? = nil
    @State private var isAnswerCorrect: Bool? = nil
    @State private var areButtonsDisabled: Bool = false
    
    var body: some View {
        VStack {
            if let riddle = riddle {
                VStack(spacing: 25) {
                    Text(riddle.question)
                        .font(.title)
                    HStack {
                        Text("Potential score: \(riddle.score)")
                            .font(.caption)
                        Spacer()
                        Text("Dificulty: \(riddle.dificulty.rawValue)")
                            .font(.caption)
                    }
                }
                .padding()
                
                VStack {
                    ForEach(riddle.answers, id: \.self) { answer in
                        Button(action: {
                            if !areButtonsDisabled {
                                selectedAnswer = answer
                                isAnswerCorrect = (answer == riddle.correctAnswer)
                                areButtonsDisabled = true
                                if let correct = isAnswerCorrect {
                                    viewModel.updatePlayerStats(forCorrectAnswer: correct, score: riddle.score)
                                    print(viewModel.getPlayer().score)
                                }
                            }
                        }) {
                            Text(answer)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    selectedAnswer == answer
                                    ? (isAnswerCorrect == true ? Color.green.opacity(0.5) : Color.red.opacity(0.5))
                                    : Color.gray.opacity(0.1)
                                )
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            selectedAnswer == answer
                                            ? (isAnswerCorrect == true ? Color.green : Color.red)
                                            : Color.gray,
                                            lineWidth: 1
                                        )
                                )
                        }
                        .foregroundColor(.black)
                        .disabled(areButtonsDisabled)
                    }
                }
                .padding()
                
                if selectedAnswer != nil {
                    Text(isAnswerCorrect == true ? "Correct! 🎉 \n\(riddle.score) points added" : "Wrong! 😢")
                        .font(.headline)
                        .foregroundColor(isAnswerCorrect == true ? .green : .red)
                        .padding()
                }
                Spacer()
            } else {
                Text("No riddle available")
            }
        }
        .padding()
    }
}
