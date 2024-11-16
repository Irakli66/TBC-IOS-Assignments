//
//  GamePageVC.swift
//  Assignment-25
//
//  Created by irakli kharshiladze on 15.11.24.
//

import UIKit

class GamePageVC: UIViewController {
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Score: 0"
        return label
    }()
    
    private let monkeyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "monkey")
        return imageView
    }()
    
    private var setScore: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(setScore)"
            
            if setScore == 20 {
                showGameOverAlert()
            }
        }
    }
    
    private var monkeyCenterX: NSLayoutConstraint?
    private var monkeyCenterY: NSLayoutConstraint?
    private var fallingBananas = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScoreLabel()
        setupMonkeyImageView()
        startFallingBananas()
    }
    
    private func setupScoreLabel() {
        view.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            scoreLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20)
        ])
    }
    
    private func setupMonkeyImageView() {
        view.addSubview(monkeyImageView)
        
        NSLayoutConstraint.activate([
            monkeyImageView.widthAnchor.constraint(equalToConstant: 80),
            monkeyImageView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        monkeyCenterY = monkeyImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150)
        monkeyCenterY?.isActive = true
        
        monkeyCenterX = monkeyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        monkeyCenterX?.isActive = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        monkeyImageView.addGestureRecognizer(panGesture)
        monkeyImageView.isUserInteractionEnabled = true
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        guard let monkeyView = gesture.view else { return }
        
        monkeyView.center = CGPoint(x: monkeyView.center.x + translation.x, y: monkeyView.center.y + translation.y)
        gesture.setTranslation(.zero, in: view)
        
        monkeyCenterX?.constant = monkeyView.center.x - (view.bounds.width / 2)
        monkeyCenterY?.constant = monkeyView.center.y - (view.bounds.height / 2)
    }
    
    private func startFallingBananas() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(createFallingBanana), userInfo: nil, repeats: true)
    }
    
    @objc private func createFallingBanana() {
        let bananaImageView = UIImageView(image: UIImage(named: "banana"))
        bananaImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bananaImageView)
        bananaImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        bananaImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let randomX = CGFloat.random(in: 0...view.frame.width - 50)
        bananaImageView.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: randomX).isActive = true
        bananaImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -50).isActive = true
        
        fallingBananas.append(bananaImageView)
        
        UIView.animate(withDuration: 3.0, animations: {
            bananaImageView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.removeMissedBananas()
            self.checkForCollisions()
            bananaImageView.removeFromSuperview()
            self.fallingBananas.removeAll { $0 == bananaImageView }
        }
    }
    
    private func removeMissedBananas() {
        for banana in fallingBananas {
            if banana.frame.origin.y > view.frame.height {
                banana.removeFromSuperview()
                fallingBananas.removeAll { $0 == banana }
            }
        }
    }
    
    private func checkForCollisions() {
        for banana in fallingBananas {
            if monkeyImageView.frame.intersects(banana.frame) {
                setScore += 1
                banana.removeFromSuperview()
                fallingBananas.removeAll { $0 == banana }
            }
        }
    }
    
    private func showGameOverAlert() {
        let alertController = UIAlertController(title: "Winner winner chicken dinner", message: "I think 20 bananas will be enough ^_^", preferredStyle: .alert)
        
        let startAgainAction = UIAlertAction(title: "Start Again", style: .default) { [weak self] _ in
            self?.resetGame()
            self?.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(startAgainAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func resetGame() {
        setScore = 0
        fallingBananas.forEach { $0.removeFromSuperview() }
        fallingBananas.removeAll()
        
        monkeyImageView.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.checkForCollisions()
        }
    }
}
