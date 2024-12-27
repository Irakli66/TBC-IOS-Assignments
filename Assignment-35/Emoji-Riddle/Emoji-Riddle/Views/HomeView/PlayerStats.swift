//
//  PlayerStats.swift
//  Emoji-Riddle
//
//  Created by irakli kharshiladze on 27.12.24.
//
import UIKit

final class PlayerStats: UIStackView {
    private var player: PlayerModel?

    private let stackViewOne: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let stackViewTwo: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let playerScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let playerStreakLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let playerCorrectAnswersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGreen
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let playerWrongAnswersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        axis = .vertical
        distribution = .fillEqually
        spacing = 8
        
        stackViewOne.addArrangedSubview(playerScoreLabel)
        stackViewOne.addArrangedSubview(playerStreakLabel)
        stackViewTwo.addArrangedSubview(playerCorrectAnswersLabel)
        stackViewTwo.addArrangedSubview(playerWrongAnswersLabel)
        addArrangedSubview(stackViewOne)
        addArrangedSubview(stackViewTwo)
    }

    func configure(with player: PlayerModel) {
        self.player = player
        playerScoreLabel.text = "Score: \(player.score)"
        playerStreakLabel.text = "Streak: \(player.streak) \(player.streak >= 5 ? "🔥" : "")"
        playerCorrectAnswersLabel.text = "Correct: \(player.correctAnswers)"
        playerWrongAnswersLabel.text = "Wrong: \(player.incorrectAnswers)"
    }
}
