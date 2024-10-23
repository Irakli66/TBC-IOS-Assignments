//
//  ViewController.swift
//  Assignment-17
//
//  Created by irakli kharshiladze on 20.10.24.
//

import UIKit

final class PlanetsViewController: UIViewController {
     private var planetsList: [Planet] = [
        Planet(image: UIImage(named: "Mercury") ?? UIImage(), name: "Mercury", area: 926725476, temperature: -8, mass: 4734653),
        Planet(image: UIImage(named: "Venus") ?? UIImage(), name: "Venus", area: 623725476, temperature: -18, mass: 7734653),
        Planet(image: UIImage(named: "Earth") ?? UIImage(), name: "Earth", area: 475167254, temperature: 35, mass: 2734653),
        Planet(image: UIImage(named: "Mars") ?? UIImage(), name: "Mars", area: 672547623, temperature: 18, mass: 3434653),
        Planet(image: UIImage(named: "Jupiter") ?? UIImage(), name: "Jupiter", area: 3326725476, temperature: -6, mass: 12534653),
        Planet(image: UIImage(named: "Uranus") ?? UIImage(), name: "Uranus", area: 4356725476, temperature: 25, mass: 9834653)
    ]
    
    private let pageTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Planets"
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private let planetsCollectionView: UICollectionView = {
        let collectionView: UICollectionView
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.itemSize = CGSize(width: 165, height: 300)
        
        collectionView = UICollectionView(frame: CGRect(x: 20, y: 20, width: 100, height: 100), collectionViewLayout: collectionLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 33/255, green: 13/255, blue: 4/255, alpha: 1)
        setupPageTitle()
        setupPlanetCollectionView()
    }
    
    private func setupPageTitle() {
        view.addSubview(pageTitle)
        
        pageTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        pageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupPlanetCollectionView() {
        view.addSubview(planetsCollectionView)
        
        NSLayoutConstraint.activate([
            planetsCollectionView.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 56),
            planetsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            planetsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            planetsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44)
        ])
        
        planetsCollectionView.dataSource = self
        planetsCollectionView.register(PlanetsCollectionViewCell.self, forCellWithReuseIdentifier: "PlanetsCollectionViewCell")
        planetsCollectionView.delegate = self
    }
}

extension PlanetsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        planetsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetsCollectionViewCell", for: indexPath) as? PlanetsCollectionViewCell {
            let currentPlanet = planetsList[indexPath.row]
            
            cell.updateUI(with: currentPlanet)
            cell.delegate = self
            return cell
        } else {
            return  UICollectionViewCell()
        }
    }
}

extension PlanetsViewController: PlanetCellDelegate {
    func addToFavorites(cell: PlanetsCollectionViewCell) {
        if let index = planetsCollectionView.indexPath(for: cell) {
            let currentIndex = index.row
            
            planetsList[currentIndex].favorite.toggle()
            planetsList.sort { $0.favorite && !$1.favorite }
            planetsCollectionView.reloadData()
            
        } else {
            return printContent("empty")
        }
    }
}

extension PlanetsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentPlanet = planetsList[indexPath.row]
        
        let vc = PlanetDetailsViewController()
        vc.addFavorites = { [weak self] in
            self?.planetsList[indexPath.row].favorite.toggle()
            self?.planetsList.sort { $0.favorite && !$1.favorite }
            self?.planetsCollectionView.reloadData()
        }
        vc.planet = currentPlanet
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

