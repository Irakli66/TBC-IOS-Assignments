//
//  OperationBtns.swift
//  TBC-Assignment-14
//
//  Created by irakli kharshiladze on 14.10.24.
//

import UIKit

class OperationBtns: UIButton {
    let buttonImage: String
    
    init(buttonImage: String) {
        self.buttonImage = buttonImage
        super.init(frame: .zero)
        createOperationBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createOperationBtn() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setImage(UIImage(systemName: buttonImage), for: .normal)
        self.backgroundColor = .systemGray5
        self.tintColor = buttonImage == "equal" ? .white : .label
        self.layer.cornerRadius = 33
        self.clipsToBounds = true
    }
}

