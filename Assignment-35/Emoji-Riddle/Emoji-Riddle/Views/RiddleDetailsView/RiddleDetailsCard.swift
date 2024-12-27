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
                    Text("Difficulty: \(riddle.dificulty.rawValue.capitalized)")
                        .font(.caption)
                }
            }
            .padding()
            
            VStack {
                ForEach(riddle.answers, id: \.self) { answer in
                    Button(action: {
                        guard !areButtonsDisabled else { return }
                        selectedAnswer = answer
                        isAnswerCorrect = (answer == riddle.correctAnswer)
                        areButtonsDisabled = true
                        
                        riddle.isAnswered = true
                        riddle.selectedAnswer = answer
                        viewModel.updateRiddle(riddle)
                        
                        viewModel.updatePlayerStats(forCorrectAnswer: isAnswerCorrect ?? false, score: riddle.score)
                    }) {
                        HStack {
                            Text(answer)
                                .foregroundStyle(Color.black)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            if riddle.isAnswered && riddle.selectedAnswer == answer {
                                Image(systemName: answer == riddle.correctAnswer ? "checkmark.circle" : "xmark.circle")
                                    .foregroundColor(answer == riddle.correctAnswer ? .green : .red)
                                    .padding(.trailing, 8)
                            }
                        }
                        .background(
                            riddle.isAnswered && riddle.selectedAnswer == answer
                            ? (answer == riddle.correctAnswer ? Color.green.opacity(0.3) : Color.red.opacity(0.3))
                            : Color.gray.opacity(0.1)
                        )
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    riddle.isAnswered && riddle.selectedAnswer == answer
                                    ? (answer == riddle.correctAnswer ? Color.green : Color.red)
                                    : Color.gray,
                                    lineWidth: 1
                                )
                        )
                    }
                    .disabled(areButtonsDisabled || riddle.isAnswered)
                    .foregroundColor(.black)
                }
            }
            .padding()
            
            if riddle.isAnswered {
                VStack(spacing: 20) {
                    Text(isAnswerCorrect == true ? "Correct! 🎉" : "Wrong! 😢")
                        .font(.headline)
                        .foregroundColor(isAnswerCorrect == true ? .green : .red)
                    Text(isAnswerCorrect == true ? "You earned \(riddle.score) points" : "")
                        .font(.headline)
                        .foregroundColor(isAnswerCorrect == true ? .green : .red)
                }
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
