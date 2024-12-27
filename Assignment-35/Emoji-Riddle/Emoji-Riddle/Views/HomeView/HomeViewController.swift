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

    private let playerStatsView = PlayerStats()
    
    private let resetGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset Game", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        updatePlayerStats()
    }

    private func setupUI() {
        setupSegmentControl()
        setupPlayerStats()
        setupResetGameButton()
        setupRiddleTableView()
    }

    private func setupSegmentControl() {
        view.addSubview(segmentControl)
        
        NSLayoutConstraint.activate([
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        ])
        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }

    private func setupPlayerStats() {
        view.addSubview(playerStatsView)
        playerStatsView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            playerStatsView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 25),
            playerStatsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            playerStatsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            playerStatsView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupResetGameButton() {
        view.addSubview(resetGameButton)
        
        NSLayoutConstraint.activate([
            resetGameButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            resetGameButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            resetGameButton.topAnchor.constraint(equalTo: playerStatsView.bottomAnchor, constant: 20),
        ])
        
        resetGameButton.addAction(UIAction(handler: {[weak self] action in
            guard let self = self else { return }
            self.viewModel.resetGame()
            self.tableView.reloadData()
            self.playerStatsView.configure(with: self.viewModel.getPlayer() )
        }), for: .touchUpInside)
    }

    private func setupRiddleTableView() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: resetGameButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RiddleTableViewCell.self, forCellReuseIdentifier: "RiddleTableViewCell")
    }

    private func updatePlayerStats() {
        playerStatsView.configure(with: viewModel.getPlayer())

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updatePlayerStats()
        tableView.reloadData()
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
        tableView.reloadData()
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
        let riddles = getRiddlesForCurrentCategory()
        let currentRiddle = riddles[indexPath.row]
        let vc = RiddleDetailsViewController(riddle: currentRiddle, viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
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
