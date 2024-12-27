//
//  RiddleModel.swift
//  Emoji-Riddle
//
//  Created by irakli kharshiladze on 27.12.24.
//
import Foundation

struct RiddleModel {
    let id: UUID = UUID()
    let question: String
    let createdAt: Date = Date()
    let correctAnswer: String
    let answers: [String]
    let category: RiddleCategory
    let dificulty: RiddleDifficulty
    
    var score: Int {
        switch dificulty {
        case .easy: return 10
        case .medium: return 20
        case .hard: return 30
        }
    }
}

enum RiddleCategory: String {
    case movies = "Movies"
    case books = "Books"
    case animes = "Animes"
}

enum RiddleDifficulty: String {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}
