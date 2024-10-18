//
//  PlanetDetailsVC.swift
//  Assignment-16
//
//  Created by irakli kharshiladze on 18.10.24.
//

import UIKit

final class Planet {
    let image: UIImage
    let name: String
    let area: Int
    let temperature: Int
    let mass: Int
    
    init(name: String, area: Int, image: UIImage, temperature: Int, mass: Int) {
        self.name = name
        self.area = area
        self.image = image
        self.temperature = temperature
        self.mass = mass
    
    }
}

class PlanetDetailsVC: UIViewController {
    
    var planet: Planet? = nil
    
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
        label.textColor = UIColor(red: 179/255, green: 68/255, blue: 22/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        
        return label
    }()
    
    private let planetImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    private let planetDetailsStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let areaStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.layer.cornerRadius = 15
        stackView.layer.borderColor = UIColor.white.cgColor
        stackView.layer.borderWidth = 1
        
        return stackView
    }()
    
    private let temperatureStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.layer.cornerRadius = 15
        stackView.layer.borderColor = UIColor.white.cgColor
        stackView.layer.borderWidth = 1
        
        return stackView
    }()
    
    private let massStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.layer.cornerRadius = 15
        stackView.layer.borderColor = UIColor.white.cgColor
        stackView.layer.borderWidth = 1
        
        return stackView
    }()
    
    private let planetDetailsTableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let planetAreaLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Area"
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    private let planetArea: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    private let planetTemperatureLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Temperature"
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    private let planetTemperature: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    private let planetMassLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Mass"
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    private let planetMass: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 33/255, green: 13/255, blue: 4/255, alpha: 1)
        setupPlanetName()
        setupNavigationButton()
        setupPlanetImageView()
        setupPlanetDetailsStackView()
        setupPlanetDetailsStackViewRows()
        setupPlanetDetails()
    }
    
    private func setupPlanetName() {
        view.addSubview(planetName)
        
        NSLayoutConstraint.activate([
            planetName.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            planetName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        planetName.text = planet?.name
    }
    
    private func setupNavigationButton() {
        view.addSubview(navigationButton)
        
        NSLayoutConstraint.activate([
            navigationButton.trailingAnchor.constraint(equalTo: planetName.leadingAnchor, constant: -90),
            navigationButton.centerYAnchor.constraint(equalTo: planetName.centerYAnchor)
        ])
        
        navigationButton.addAction(UIAction(handler: { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
    }
    
    private func setupPlanetImageView() {
        view.addSubview(planetImageView)
        
        planetImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        planetImageView.topAnchor.constraint(equalTo: planetName.bottomAnchor, constant: 60).isActive = true
        planetImageView.heightAnchor.constraint(equalTo: planetImageView.widthAnchor).isActive = true
        planetImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        planetImageView.image = planet?.image
    }
    
    private func setupPlanetDetailsStackView() {
        view.addSubview(planetDetailsStackView)
        
        NSLayoutConstraint.activate([
            planetDetailsStackView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            planetDetailsStackView.topAnchor.constraint(equalTo: planetImageView.bottomAnchor,constant: 70),
            planetDetailsStackView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            planetDetailsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -60)
        ])
    }
    
    private func setupPlanetDetailsStackViewRows() {
        [areaStackView, temperatureStackView, massStackView].forEach {
            planetDetailsStackView.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }
    }
    
    private func setupPlanetDetails() {
        [planetAreaLbl, planetArea].forEach { areaStackView.addArrangedSubview($0) }
        [planetTemperatureLbl, planetTemperature].forEach { temperatureStackView.addArrangedSubview($0) }
        [planetMassLbl, planetMass].forEach { massStackView.addArrangedSubview($0) }
        
        planetArea.text = "\(planet?.area ?? 0) km2"
        planetTemperature.text = "\(planet?.temperature ?? 0)℃"
        planetMass.text = "\(planet?.mass ?? 0) kg"
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
