//
//  RiddleDetailsCard.swift
//  Emoji-Riddle
//
//  Created by irakli kharshiladze on 27.12.24.
//

import SwiftUI

struct RiddleDetailsCard: View {
    @State var riddle: RiddleModel
    @ObservedObject var viewModel: HomeViewModel
    @State private var selectedAnswer: String? = nil
    @State private var isAnswerCorrect: Bool? = nil
    @State private var areButtonsDisabled: Bool = false
    
    var body: some View {
        VStack {
            VStack(spacing: 25) {
                Text(riddle.question)
                    .font(.title)
                HStack {
                    Text("Potential score: \(riddle.score)")
                        .font(.caption)
                    Spacer()
                    Text("Difficulty: \(riddle.dificulty.rawValue)")
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
                            
                            riddle.isAnswered = true
                            riddle.selectedAnswer = answer
                            viewModel.updateRiddle(riddle)
                            
                            viewModel.updatePlayerStats(forCorrectAnswer: isAnswerCorrect ?? false, score: riddle.score)
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
                    .disabled(areButtonsDisabled || riddle.isAnswered)
                }
            }
            .padding()
            
            if riddle.isAnswered {
                Text(isAnswerCorrect == true ? "Correct! 🎉 \n\(riddle.score) points added" : "Wrong! 😢")
                    .font(.headline)
                    .foregroundColor(isAnswerCorrect == true ? .green : .red)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            selectedAnswer = riddle.selectedAnswer
            areButtonsDisabled = riddle.isAnswered
            if let answer = riddle.selectedAnswer {
                isAnswerCorrect = (answer == riddle.correctAnswer)
            }
        }
    }
}
