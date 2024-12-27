//
//  PlayerModel.swift
//  Emoji-Riddle
//
//  Created by irakli kharshiladze on 27.12.24.
//

import Foundation

struct PlayerModel {
    let id: UUID = UUID()
    let name: String
    let score: Int = 0
    let createdAt: Date = Date()
    let correctAnswers: Int = 0
    let incorrectAnswers: Int = 0
    let streak: Int = 0
}
