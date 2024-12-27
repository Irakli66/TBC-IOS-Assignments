//
//  WinningAnimation.swift
//  Emoji-Riddle
//
//  Created by irakli kharshiladze on 27.12.24.
//

import UIKit

class WinningAnimation {
    static func show(on view: UIView, message: String, completion: @escaping () -> Void) {
        let winningLabel = UILabel()
        winningLabel.text = message
        winningLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        winningLabel.textAlignment = .center
        winningLabel.textColor = .white
        winningLabel.numberOfLines = 0
        winningLabel.backgroundColor = .systemGreen
        winningLabel.layer.cornerRadius = 12
        winningLabel.clipsToBounds = true
        winningLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(winningLabel)
        
        NSLayoutConstraint.activate([
            winningLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            winningLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            winningLabel.widthAnchor.constraint(equalToConstant: 250),
            winningLabel.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        UIView.animate(withDuration: 2.0, delay: 0, options: [.curveEaseInOut], animations: {
            winningLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: [.curveEaseInOut], animations: {
                winningLabel.alpha = 0.0
            }) { _ in
                winningLabel.removeFromSuperview()
                completion()
            }
        }
    }
}
