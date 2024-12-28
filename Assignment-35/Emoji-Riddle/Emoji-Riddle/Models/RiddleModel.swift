//
//  RiddleModel.swift
//  Emoji-Riddle
//
//  Created by irakli kharshiladze on 27.12.24.
//
import Foundation

struct RiddleModel: Codable {
    var id: UUID = UUID()
    let question: String
    var createdAt: Date = Date()
    let correctAnswer: String
    let answers: [String]
    let category: RiddleCategory
    let dificulty: RiddleDifficulty
    var selectedAnswer: String? = nil
    var isAnswered: Bool = false
    
    var score: Int {
        switch dificulty {
        case .easy: return 10
        case .medium: return 20
        case .hard: return 30
        }
    }
}

enum RiddleCategory: String, Codable {
    case movies = "Movies"
    case books = "Books"
    case animes = "Animes"
}

enum RiddleDifficulty: String, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}
