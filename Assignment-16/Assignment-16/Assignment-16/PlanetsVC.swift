//
//  PlanetsVC.swift
//  Assignment-16
//
//  Created by irakli kharshiladze on 18.10.24.
//

import UIKit


final class PlanetsVC: UIViewController {
    
    private let tableViewTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor(red: 179/255, green: 68/255, blue: 22/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        
        return label
    }()
    
    private let planetsTableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
       return tableView
    }()
    
    var planetsList: [Planet] = [
        Planet(image: UIImage(named: "Mars") ?? UIImage(), name: "Mars", area: 1_258_250, temperature: -18, mass: 60745),
        Planet(image: UIImage(named: "Jupiter") ?? UIImage(), name: "Jupiter", area: 6_142_210, temperature: 25, mass: 620745),
        Planet(image: UIImage(named: "Earth") ?? UIImage(), name: "Earth", area: 500_100_100, temperature: 39, mass: 607445),
        Planet(image: UIImage(named: "Saturn") ?? UIImage(), name: "Saturn", area: 2_608_250, temperature: 11, mass: 607425)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 33/255, green: 13/255, blue: 4/255, alpha: 1)
        setupTableViewTitle()
        configurePlanetsTableView()
    }
    
    private func setupTableViewTitle() {
        view.addSubview(tableViewTitle)
        
        NSLayoutConstraint.activate([
            tableViewTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            tableViewTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        tableViewTitle.text = "Planets"
    }

    private func configurePlanetsTableView() {
        view.addSubview(planetsTableView)
        
        NSLayoutConstraint.activate([
            planetsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            planetsTableView.topAnchor.constraint(equalTo: tableViewTitle.bottomAnchor, constant: 70),
            planetsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            planetsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        planetsTableView.backgroundColor = .none
        planetsTableView.register(PlanetsDataCell.self, forCellReuseIdentifier: "PlanetsDataCell")
        
        planetsTableView.dataSource = self
        planetsTableView.delegate = self
    }

}

extension PlanetsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentPlanet = planetsList[indexPath.row]
        
        let vc = PlanetDetailsVC()
        vc.planet = currentPlanet
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PlanetsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        planetsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetsDataCell", for: indexPath) as? PlanetsDataCell {
            let currentPlanet = planetsList[indexPath.row]
            
            cell.planetsList = planetsList
            cell.planeNametLbl.text = currentPlanet.name
            cell.planetAreaLbl.text = "\(currentPlanet.area) km2"
            cell.imageView?.image = currentPlanet.image
            
            return cell
        }
        
        return UITableViewCell()
    }
}


import SwiftUI
#Preview {
    return PlanetsVC()
}
