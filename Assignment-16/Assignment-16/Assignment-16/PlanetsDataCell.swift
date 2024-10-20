//
//  PlanetsDataCell.swift
//  Assignment-16
//
//  Created by irakli kharshiladze on 18.10.24.
//

import UIKit

class PlanetsDataCell: UITableViewCell {
    var planetsList: [Planet] = []
    
    var planetImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    private let planetLblStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()
    
    let planeNametLbl: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        
        return label
    }()
    
    let planetAreaLbl: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        return label
    }()

    private let navigationButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = UIColor(red: 179/255, green: 68/255, blue: 22/255, alpha: 1)

        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
            self.backgroundColor = .clear
            contentView.backgroundColor = .clear
        
            contentView.backgroundColor = .none
            contentView.addSubview(planetImageView)
            contentView.addSubview(planetLblStackView)
            contentView.addSubview(navigationButton)
            
            planetLblStackView.addArrangedSubview(planeNametLbl)
            planetLblStackView.addArrangedSubview(planetAreaLbl)
            
            setupConstraints()
        }
        
    private func setupConstraints() {
            NSLayoutConstraint.activate([
                planetImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                planetImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                planetImageView.widthAnchor.constraint(equalToConstant: 100),
                planetImageView.heightAnchor.constraint(equalToConstant: 100),

                navigationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                navigationButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                navigationButton.widthAnchor.constraint(equalToConstant: 24),
                navigationButton.heightAnchor.constraint(equalToConstant: 24),
                
                planetLblStackView.leadingAnchor.constraint(equalTo: planetImageView.trailingAnchor, constant: 36),
                planetLblStackView.trailingAnchor.constraint(lessThanOrEqualTo: navigationButton.leadingAnchor, constant: -16),
                planetLblStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
    
}
