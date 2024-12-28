//
//  PlayerModel.swift
//  Emoji-Riddle
//
//  Created by irakli kharshiladze on 27.12.24.
//

import Foundation

struct PlayerModel: Codable {
    var id: UUID = UUID()
    let name: String
    var score: Int = 0
    var createdAt: Date = Date()
    var correctAnswers: Int = 0
    var incorrectAnswers: Int = 0
    var streak: Int = 0
}
