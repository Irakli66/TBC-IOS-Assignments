//
//  PlanetDetailsViewController.swift
//  Assignment-17
//
//  Created by irakli kharshiladze on 20.10.24.
//

import UIKit

struct Planet {
    let image: UIImage
    let name: String
    let area: Int
    let temperature: Int
    let mass: Int
    var favorite: Bool = false
}


final class PlanetDetailsViewController: UIViewController {
    var planet: Planet? = nil
    
    private let planetNameNavigationFavoriteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let navigationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = UIColor(red: 179/255, green: 68/255, blue: 22/255, alpha: 1)
        
        return button
    }()
    
    private let planetName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    private let planetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let planetDetailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    var addFavorites: (() -> Void)?

    private func setupUI() {
        view.backgroundColor = UIColor(red: 33/255, green: 13/255, blue: 4/255, alpha: 1)
        setupPlanetNameNavigationFavoriteStackView()
        setupPlanetImageView()
        setupPlanetDetailsTableView()
    }
    
    private func setupPlanetNameNavigationFavoriteStackView() {
        view.addSubview(planetNameNavigationFavoriteStackView)
        
        NSLayoutConstraint.activate([
            planetNameNavigationFavoriteStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            planetNameNavigationFavoriteStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            planetNameNavigationFavoriteStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            
        ])
        setupNavigationButton()
        
        planetNameNavigationFavoriteStackView.addArrangedSubview(planetName)
        planetName.text = planet?.name
        
        setupFavoriteButton()
        
    }
    
    private func setupNavigationButton() {
        planetNameNavigationFavoriteStackView.addArrangedSubview(navigationButton)
        
        navigationButton.addAction(UIAction(handler: { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
    }
    
    private func setupFavoriteButton() {
        planetNameNavigationFavoriteStackView.addArrangedSubview(favoriteButton)
        
        favoriteButton.tintColor = planet?.favorite ?? false ? .yellow : .white
        
        favoriteButton.addAction(UIAction(handler: {[weak self] action in
            self?.buttonAction()
        }), for: .touchUpInside)
    }
    
    private func updateFavoriteButtonUI() {
        favoriteButton.tintColor = planet?.favorite ?? false ? .yellow : .white
    }
    
    func buttonAction() {
        addFavorites?()
        planet?.favorite.toggle()
        updateFavoriteButtonUI()
    }
    
    private func setupPlanetImageView() {
        view.addSubview(planetImageView)
        
        NSLayoutConstraint.activate([
            planetImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            planetImageView.topAnchor.constraint(equalTo: planetNameNavigationFavoriteStackView.bottomAnchor, constant: 85),
            planetImageView.heightAnchor.constraint(equalTo: planetImageView.widthAnchor),
            planetImageView.heightAnchor.constraint(equalToConstant: 280)
        ])
        
        planetImageView.image = planet?.image
    }
    
    private func setupPlanetDetailsTableView() {
        view.addSubview(planetDetailsTableView)
        
        NSLayoutConstraint.activate([
            planetDetailsTableView.topAnchor.constraint(equalTo: planetImageView.bottomAnchor, constant: 70),
            planetDetailsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            planetDetailsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            planetDetailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
        
        planetDetailsTableView.backgroundColor = .none
        planetDetailsTableView.dataSource = self
        planetDetailsTableView.delegate = self
        planetDetailsTableView.register(PlanetDetailsTableViewCell.self, forCellReuseIdentifier: "PlanetDetailsTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension PlanetDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        [planet?.area, planet?.temperature, planet?.mass].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetDetailsTableViewCell", for: indexPath) as? PlanetDetailsTableViewCell {
            let planetDetails = ["\(planet?.area ?? 0) km2", "\(planet?.temperature ?? 0)℃", "\(planet?.mass ?? 0) kg"]
            let currentStat = planetDetails[indexPath.row]
            
            cell.updateUI(title: "\(indexPath.row == 0 ? "Area" : indexPath.row == 1 ? "Temperature" : "Mass")", stat: currentStat)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
}

extension PlanetDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
