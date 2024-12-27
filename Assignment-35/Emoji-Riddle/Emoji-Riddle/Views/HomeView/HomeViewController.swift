//
//  HomeViewController.swift
//  Emoji-Riddle
//
//  Created by irakli kharshiladze on 27.12.24.
//

import UIKit

class HomeViewController: UIViewController {
    private var currentCategory: RiddleCategory = .movies
    private let viewModel = HomeViewModel()
    
    private let segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Movies", "Books", "Animes"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
    }()
    
    private let dificultyPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        setupSegmentControl()
        //        setupDificultyPicker()
        setupRiddleTableView()
    }
    
    private func setupSegmentControl() {
        view.addSubview(segmentControl)
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    @objc private func segmentChanged() {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            currentCategory = .movies
        case 1:
            currentCategory = .books
        case 2:
            currentCategory = .animes
        default:
            break
        }
        print("Current category: \(currentCategory)")
        tableView.reloadData()
    }
    
    private func setupDificultyPicker() {
        view.addSubview(dificultyPicker)
        
        NSLayoutConstraint.activate([
            dificultyPicker.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 20),
            dificultyPicker.centerXAnchor.constraint(equalTo: segmentControl.centerXAnchor),
        ])
    }
    
    private func setupRiddleTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RiddleTableViewCell.self, forCellReuseIdentifier: "RiddleTableViewCell")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getRiddlesForCurrentCategory().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RiddleTableViewCell", for: indexPath) as? RiddleTableViewCell else {
            return UITableViewCell()
        }
        
        let riddles = getRiddlesForCurrentCategory()
        let currentRiddle = riddles[indexPath.row]
        cell.configureCell(with: currentRiddle)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
}

extension HomeViewController {
    private func getRiddlesForCurrentCategory() -> [RiddleModel] {
        switch currentCategory {
        case .movies:
            return viewModel.getCategorizedRiddles(.movies)
        case .books:
            return viewModel.getCategorizedRiddles(.books)
        case .animes:
            return viewModel.getCategorizedRiddles(.animes)
        }
    }
}
