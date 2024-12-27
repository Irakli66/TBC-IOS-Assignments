//
//  HomeViewModel.swift
//  Emoji-Riddle
//
//  Created by irakli kharshiladze on 27.12.24.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    private let defaultRiddles: [RiddleModel] = [
        // Movies
        RiddleModel(
            question: "🧊🛳️❄️❤️",
            correctAnswer: "Titanic",
            answers: ["Titanic", "Frozen", "Ice Age", "Love Boat"],
            category: .movies,
            dificulty: .easy
        ),
        RiddleModel(
            question: "🦸‍♂️🦸‍♀️🛡️⚡🦇",
            correctAnswer: "The Avengers",
            answers: ["The Avengers", "Justice League", "X-Men", "Superman"],
            category: .movies,
            dificulty: .medium
        ),
        RiddleModel(
            question: "🦖🌴🏃‍♂️🦕🔬",
            correctAnswer: "Jurassic Park",
            answers: ["Jurassic Park", "Land Before Time", "King Kong", "The Lost World"],
            category: .movies,
            dificulty: .medium
        ),
        RiddleModel(
            question: "🚀🌌👩‍🚀🔴🤖",
            correctAnswer: "Interstellar",
            answers: ["Interstellar", "Gravity", "The Martian", "2001: A Space Odyssey"],
            category: .movies,
            dificulty: .hard
        ),
        RiddleModel(
            question: "🕶️🧥🔫💻🔵",
            correctAnswer: "The Matrix",
            answers: ["The Matrix", "John Wick", "Blade Runner", "Tron"],
            category: .movies,
            dificulty: .medium
        ),
        RiddleModel(
            question: "🐀👨‍🍳🍝🇫🇷🏙️",
            correctAnswer: "Ratatouille",
            answers: ["Ratatouille", "Chef", "Cloudy With a Chance of Meatballs", "Zootopia"],
            category: .movies,
            dificulty: .easy
        ),
        RiddleModel(
            question: "🧙‍♂️🧝‍♀️🗡️🕯️💍",
            correctAnswer: "The Lord of the Rings",
            answers: ["The Lord of the Rings", "Harry Potter", "The Hobbit", "Game of Thrones"],
            category: .movies,
            dificulty: .medium
        ),
        RiddleModel(
            question: "🚖🎷💛👩‍❤️‍👨🌃",
            correctAnswer: "La La Land",
            answers: ["La La Land", "Taxi Driver", "Singin' in the Rain", "Whiplash"],
            category: .movies,
            dificulty: .easy
        ),
        RiddleModel(
            question: "🕷️🕸️🏙️🔵🔴",
            correctAnswer: "Spider-Man",
            answers: ["Spider-Man", "Ant-Man", "Venom", "Iron Man"],
            category: .movies,
            dificulty: .easy
        ),
        RiddleModel(
            question: "🤠🐍🌵🏺👨‍🎤",
            correctAnswer: "Indiana Jones",
            answers: ["Indiana Jones", "Tomb Raider", "The Mummy", "Wild Wild West"],
            category: .movies,
            dificulty: .medium
        ),
        
        // Books
        RiddleModel(
            question: "📕🌊🦑🚢👨‍🚀",
            correctAnswer: "Twenty Thousand Leagues Under the Sea",
            answers: ["Twenty Thousand Leagues Under the Sea", "Moby Dick", "The Old Man and the Sea", "The Life of Pi"],
            category: .books,
            dificulty: .hard
        ),
        RiddleModel(
            question: "🐉⚔️🏰👸🔥",
            correctAnswer: "Game of Thrones",
            answers: ["Game of Thrones", "The Hobbit", "Eragon", "Beowulf"],
            category: .books,
            dificulty: .medium
        ),
        RiddleModel(
            question: "🪞🍎👸🌲🧙‍♀️",
            correctAnswer: "Snow White",
            answers: ["Snow White", "Cinderella", "Sleeping Beauty", "Rapunzel"],
            category: .books,
            dificulty: .easy
        ),
        RiddleModel(
            question: "🕵️‍♂️🔍🖋️📜🎩",
            correctAnswer: "Sherlock Holmes",
            answers: ["Sherlock Holmes", "Hercule Poirot", "The Da Vinci Code", "Nancy Drew"],
            category: .books,
            dificulty: .medium
        ),
        RiddleModel(
            question: "👦⚡🪄📚🧙‍♂️",
            correctAnswer: "Harry Potter",
            answers: ["Harry Potter", "The Magicians", "Percy Jackson", "Eragon"],
            category: .books,
            dificulty: .easy
        ),
        RiddleModel(
            question: "👩‍⚕️🚪🛏️🐻📘",
            correctAnswer: "The Three Bears",
            answers: ["The Three Bears", "Cinderella", "Alice in Wonderland", "Peter Pan"],
            category: .books,
            dificulty: .easy
        ),
        RiddleModel(
            question: "🚣‍♂️🐳🌀💀📜",
            correctAnswer: "Moby Dick",
            answers: ["Moby Dick", "The Old Man and the Sea", "Robinson Crusoe", "Treasure Island"],
            category: .books,
            dificulty: .medium
        ),
        RiddleModel(
            question: "🐷🐰🦊🏡🌾",
            correctAnswer: "Charlotte's Web",
            answers: ["Charlotte's Web", "The Tale of Peter Rabbit", "The Wind in the Willows", "Animal Farm"],
            category: .books,
            dificulty: .easy
        ),
        RiddleModel(
            question: "👩🔪🍖💀🎭",
            correctAnswer: "Macbeth",
            answers: ["Macbeth", "Hamlet", "Julius Caesar", "Othello"],
            category: .books,
            dificulty: .hard
        ),
        RiddleModel(
            question: "🌹🐻🏰🌟👑",
            correctAnswer: "Beauty and the Beast",
            answers: ["Beauty and the Beast", "Sleeping Beauty", "Cinderella", "The Frog Prince"],
            category: .books,
            dificulty: .easy
        ),
        
        // Animes
        RiddleModel(
            question: "🍙🎌👺🏯🧙‍♀️",
            correctAnswer: "Spirited Away",
            answers: ["Spirited Away", "My Neighbor Totoro", "Princess Mononoke", "Kiki’s Delivery Service"],
            category: .animes,
            dificulty: .easy
        ),
        RiddleModel(
            question: "👊🔥🍜🍥🌌",
            correctAnswer: "Naruto",
            answers: ["Naruto", "Dragon Ball", "Demon Slayer", "One Piece"],
            category: .animes,
            dificulty: .medium
        ),
        RiddleModel(
            question: "🚴‍♂️🛣️🌊☀️🍂",
            correctAnswer: "Your Name",
            answers: ["Your Name", "Weathering With You", "A Silent Voice", "5 Centimeters per Second"],
            category: .animes,
            dificulty: .medium
        ),
        RiddleModel(
            question: "🏴‍☠️⛵⚓🦜💰",
            correctAnswer: "One Piece",
            answers: ["One Piece", "Black Lagoon", "Attack on Titan", "Fairy Tail"],
            category: .animes,
            dificulty: .easy
        ),
        RiddleModel(
            question: "🤖👦🌌💣☄️",
            correctAnswer: "Neon Genesis Evangelion",
            answers: ["Neon Genesis Evangelion", "Gundam", "Cowboy Bebop", "Akira"],
            category: .animes,
            dificulty: .hard
        ),
        RiddleModel(
            question: "⚔️👹🏰🌙🍂",
            correctAnswer: "Demon Slayer",
            answers: ["Demon Slayer", "Bleach", "Attack on Titan", "InuYasha"],
            category: .animes,
            dificulty: .medium
        ),
        RiddleModel(
            question: "🌀💤👨‍🎓📒👹",
            correctAnswer: "Death Note",
            answers: ["Death Note", "Code Geass", "Tokyo Ghoul", "Monster"],
            category: .animes,
            dificulty: .medium
        ),
        RiddleModel(
            question: "👊🌌🌟🛸🐉",
            correctAnswer: "Dragon Ball Z",
            answers: ["Dragon Ball Z", "My Hero Academia", "One Punch Man", "Fairy Tail"],
            category: .animes,
            dificulty: .easy
        ),
        RiddleModel(
            question: "🐭🧀⚡🌌⚔️",
            correctAnswer: "Sword Art Online",
            answers: ["Sword Art Online", "Hunter x Hunter", "Fullmetal Alchemist", "Fairy Tail"],
            category: .animes,
            dificulty: .medium
        ),
        RiddleModel(
            question: "🐉🌱🌍💔☀️",
            correctAnswer: "Princess Mononoke",
            answers: ["Princess Mononoke", "My Neighbor Totoro", "Nausicaä of the Valley of the Wind", "Spirited Away"],
            category: .animes,
            dificulty: .medium
        )
    ]
    
    @Published var player: PlayerModel {
        didSet {
            savePlayerToUserDefaults()
        }
    }
    
    @Published var riddles: [RiddleModel] {
        didSet {
            saveRiddlesToUserDefaults()
        }
    }
    
    private let playerKey = "playerData"
    private let riddlesKey = "riddlesData"
    
    init() {
        self.player = PlayerModel(name: "John")
        self.riddles = defaultRiddles
        
        if let loadedPlayer = loadPlayerFromUserDefaults() {
            self.player = loadedPlayer
        }
        
        if let loadedRiddles = loadRiddlesFromUserDefaults() {
            self.riddles = loadedRiddles
        }
    }
    
    
    func saveRiddlesToUserDefaults() {
        do {
            let data = try JSONEncoder().encode(riddles)
            UserDefaults.standard.set(data, forKey: riddlesKey)
        } catch {
            print("Failed to save riddles: \(error)")
        }
    }
    
    func loadRiddlesFromUserDefaults() -> [RiddleModel]? {
        guard let data = UserDefaults.standard.data(forKey: riddlesKey) else { return nil }
        do {
            return try JSONDecoder().decode([RiddleModel].self, from: data)
        } catch {
            print("Failed to load riddles: \(error)")
            return nil
        }
    }
    
    func updateRiddle(_ updatedRiddle: RiddleModel) {
        if let index = riddles.firstIndex(where: { $0.question == updatedRiddle.question }) {
            riddles[index] = updatedRiddle
            saveRiddlesToUserDefaults()
        }
    }
    
    func getDefaultRiddles() -> [RiddleModel] {
        return defaultRiddles
    }
    
    func savePlayerToUserDefaults() {
        do {
            let data = try JSONEncoder().encode(player)
            UserDefaults.standard.set(data, forKey: playerKey)
        } catch {
            print("Failed to save player: \(error)")
        }
    }
    
    func loadPlayerFromUserDefaults() -> PlayerModel? {
        guard let data = UserDefaults.standard.data(forKey: playerKey) else { return nil }
        do {
            return try JSONDecoder().decode(PlayerModel.self, from: data)
        } catch {
            print("Failed to load player: \(error)")
            return nil
        }
    }
    
    func getPlayer() -> PlayerModel {
        if let loadedPlayer = loadPlayerFromUserDefaults() {
            self.player = loadedPlayer
            return loadedPlayer
        } else {
            return player
        }
    }
    
    func getCategorizedRiddles(_ category: RiddleCategory) -> [RiddleModel] {
        riddles.filter { $0.category == category }
    }
    
    func getCategorizedRiddlesCount(_ category: RiddleCategory) -> Int {
        riddles.filter { $0.category == category }.count
    }
    
    func getRiddle(index: Int, category: RiddleCategory) -> RiddleModel? {
        let filteredRiddles = getCategorizedRiddles(category)
        guard index >= 0 && index < filteredRiddles.count else { return nil }
        return filteredRiddles[index]
    }
    
    func getRiddleDetail(with question: String) -> RiddleModel? {
        return riddles.first { $0.question == question }
    }
    func updatePlayerStats(forCorrectAnswer correct: Bool, score: Int) {
        if correct {
            player.correctAnswers += 1
            player.streak += 1
            player.score += score
        } else {
            player.incorrectAnswers += 1
            player.streak = 0
        }
        savePlayerToUserDefaults()
    }
    
    func resetGame() {
        self.player = PlayerModel(name: "John")

        self.riddles = getDefaultRiddles()

        savePlayerToUserDefaults()
        saveRiddlesToUserDefaults()
    }
}
