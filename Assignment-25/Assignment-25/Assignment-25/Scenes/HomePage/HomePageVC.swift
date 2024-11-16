//
//  ViewController.swift
//  Assignment-25
//
//  Created by irakli kharshiladze on 15.11.24.
//

import UIKit

class HomePageVC: UIViewController {
    private let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        startButton.addAction(UIAction(handler: { [weak self] _ in
            let gamePageVC = GamePageVC()
            gamePageVC.modalPresentationStyle = .fullScreen
            self?.present(gamePageVC, animated: true)
        }), for: .touchUpInside)
    }
    
}

