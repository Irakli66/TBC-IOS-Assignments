//
//  PlanetDetailsTableViewCell.swift
//  Assignment-17
//
//  Created by irakli kharshiladze on 20.10.24.
//

import UIKit

private func createLabels(labelTitle: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 18)
    label.text = labelTitle
    
    return label
}

final class PlanetDetailsTableViewCell: UITableViewCell {
    var planet: Planet? = nil
    
    let statisticLabel = createLabels(labelTitle: "")
    let statistic = createLabels(labelTitle: "")

    private let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.layer.cornerRadius = 15
        stackView.layer.borderColor = UIColor.white.cgColor
        stackView.layer.borderWidth = 1
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 8, bottom: 15, right: 8)
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        setupDetailsStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupDetailsStackView() {
        contentView.addSubview(detailsStackView)
        
        NSLayoutConstraint.activate([
            detailsStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            detailsStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            detailsStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            detailsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        detailsStackView.addArrangedSubview(statisticLabel)
        detailsStackView.addArrangedSubview(statistic)
    }

    func updateUI(title: String, stat: String) {
        statisticLabel.text = title
        statistic.text = "\(stat)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
    }
}
