//
//  NumberBtns.swift
//  TBC-Assignment-14
//
//  Created by irakli kharshiladze on 14.10.24.
//

import UIKit

class NumberBtns: UIButton {
    let buttonTitle: String
    
    init(buttonTitle: String) {
        self.buttonTitle = buttonTitle
        super.init(frame: .zero)
        createNumberBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createNumberBtn() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setTitle(buttonTitle, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        self.setTitleColor(buttonTitle == "AC" ? .red : UIColor.label, for: .normal)
    }
}
