//
//  HomeViewModel.swift
//  Emoji-Riddle
//
//  Created by irakli kharshiladze on 27.12.24.
//

import Foundation

final class HomeViewModel {
    private let Player = PlayerModel(name: "John")
    private let riddles: [RiddleModel] = [
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
}
