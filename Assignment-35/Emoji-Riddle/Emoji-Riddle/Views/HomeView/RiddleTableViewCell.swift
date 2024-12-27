//
//  RiddleTableViewCell.swift
//  Emoji-Riddle
//
//  Created by irakli kharshiladze on 27.12.24.
//

import UIKit

final class RiddleTableViewCell: UITableViewCell {
    private let riddleStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.distribution = .equalSpacing
        return stackview
    }()
    
    private let riddleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    private let riddleDifficultyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var answeredImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        contentView.addSubview(riddleStackview)
        contentView.addSubview(answeredImageView)
        [riddleLabel, riddleDifficultyLabel].forEach{ riddleStackview.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            riddleStackview.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            riddleStackview.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            riddleStackview.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            answeredImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            answeredImageView.topAnchor.constraint(equalTo: riddleStackview.bottomAnchor, constant: 5),
        ])
    }
    
    func configureCell(with riddle: RiddleModel) {
        riddleLabel.text = riddle.question
        riddleDifficultyLabel.text = riddle.dificulty.rawValue.capitalized
        
        if riddle.isAnswered && riddle.correctAnswer == riddle.selectedAnswer {
            answeredImageView.image = UIImage(systemName: "checkmark.circle")
            answeredImageView.tintColor = .systemGreen
        } else if riddle.isAnswered {
            answeredImageView.image = UIImage(systemName: "xmark.circle")
            answeredImageView.tintColor = .red
        } else {
            answeredImageView.image = nil
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
    }
}

