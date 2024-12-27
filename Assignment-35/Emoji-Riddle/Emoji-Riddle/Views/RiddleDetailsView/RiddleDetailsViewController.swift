//
//  RiddleDetailsViewController.swift
//  Emoji-Riddle
//
//  Created by irakli kharshiladze on 27.12.24.
//

import UIKit
import SwiftUI

class RiddleDetailsViewController: UIViewController {
    var riddle: RiddleModel
    
    init(riddle: RiddleModel) {
        self.riddle = riddle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let riddleDetailsCard = RiddleDetailsCard(riddle: riddle)
        
        let hostingController = UIHostingController(rootView: riddleDetailsCard)
        
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
}
