//
//  PlanetsCollectionViewCell.swift
//  Assignment-17
//
//  Created by irakli kharshiladze on 20.10.24.
//

import UIKit

protocol PlanetCellDelegate: AnyObject {
    func addToFavorites(cell: PlanetsCollectionViewCell)
}

final class PlanetsCollectionViewCell: UICollectionViewCell {
    var planetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let detailsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let planetName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let planetArea: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: PlanetCellDelegate?
    
    private func setupUI() {
        setupPlanetImageView()
        setupDetailsView()
        setupFavoriteButton()
    }
    
    private func setupPlanetImageView() {
        contentView.addSubview(planetImageView)
        
        NSLayoutConstraint.activate([
          planetImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
          planetImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
          planetImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
          planetImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setupDetailsView() {
        contentView.addSubview(detailsView)
        
        NSLayoutConstraint.activate([
          detailsView.topAnchor.constraint(equalTo: planetImageView.bottomAnchor),
          detailsView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
          detailsView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
          detailsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        detailsView.addSubview(planetName)
        detailsView.addSubview(planetArea)
               
        NSLayoutConstraint.activate([
            planetName.topAnchor.constraint(equalTo: detailsView.topAnchor, constant: 8),
            planetName.leftAnchor.constraint(equalTo: detailsView.leftAnchor, constant: 10),

            planetArea.topAnchor.constraint(equalTo: planetName.bottomAnchor, constant: 8),
            planetArea.leadingAnchor.constraint(equalTo: planetName.leadingAnchor),
            planetArea.rightAnchor.constraint(equalTo: detailsView.rightAnchor, constant: -16),
            planetArea.bottomAnchor.constraint(lessThanOrEqualTo: detailsView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupFavoriteButton() {
        detailsView.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(equalTo: planetName.centerYAnchor),
            favoriteButton.leadingAnchor.constraint(equalTo: planetName.trailingAnchor, constant: 5),
        ])
        
        favoriteButton.addAction(UIAction(handler: { [weak self] action in
            self?.addToFavorites()
        }), for: .touchUpInside)
    }
    
    private func addToFavorites() {
        delegate?.addToFavorites(cell: self)
    }
    
    func updateUI(with planet: Planet) {
        planetImageView.image = planet.image
        planetName.text = planet.name
        planetArea.text = "\(planet.area) km2"
        favoriteButton.tintColor = planet.favorite ? .yellow : .white
    }
}
