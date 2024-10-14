//
//  CalculatorVC.swift
//  TBC-Assignment-14
//
//  Created by irakli kharshiladze on 12.10.24.
//

import UIKit


final class CalculatorVC: UIViewController {
    private var isDark: Bool = false
    private let gradient = CAGradientLayer()
    
    private let resultsView: UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
        
       return view
    }()
    
    private let resultsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .trailing
        stackView.spacing = 8
        
        return stackView
    }()
    
    private var historyLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .ultraLight)
        
        return label
    }()
    
    private var resultLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)

        return label
    }()
    
    private let numbersView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 30
        
        return view
    }()
    
    private let numbersStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
        
       stackView.axis = .horizontal
       stackView.distribution = .fillEqually
       stackView.spacing = 16
        
       return stackView
    }()
    
    private let firstColStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
       stackView.axis = .vertical
       stackView.distribution = .fillEqually
       stackView.spacing = 16

       return stackView
    }()
    
    private let secondColStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
       return stackView
    }()
    
    private let thirdColStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
       return stackView
    }()
    
    private let fourthColStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        
       return stackView
    }()
    
    private let threeBtnStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        return stackView
    }()
    
    private let equalBtnStackView: UIStackView = {
       let stackView = UIStackView()
        
        return stackView
    }()
        
    let dotBtn = NumberBtns(buttonTitle: ".")
    let zeroBtn = NumberBtns(buttonTitle: "0")
    let oneBtn = NumberBtns(buttonTitle: "1")
    let twoBtn = NumberBtns(buttonTitle: "2")
    let threeBtn = NumberBtns(buttonTitle: "3")
    let fourBtn = NumberBtns(buttonTitle: "4")
    let fiveBtn = NumberBtns(buttonTitle: "5")
    let sixBtn = NumberBtns(buttonTitle: "6")
    let sevenBtn = NumberBtns(buttonTitle: "7")
    let eightBtn = NumberBtns(buttonTitle: "8")
    let nineBtn = NumberBtns(buttonTitle: "9")
    let resetBtn = NumberBtns(buttonTitle: "AC")
    let percentBtn = OperationBtns(buttonImage: "percent")
    let divideBtn = OperationBtns(buttonImage: "divide")
    let multiplyBtn = OperationBtns(buttonImage: "multiply")
    let minusBtn = OperationBtns(buttonImage: "minus")
    let plusBtn = OperationBtns(buttonImage: "plus")
    let equalBtn = OperationBtns(buttonImage: "equal")
    let themeSwitchBtn = OperationBtns(buttonImage: "moon")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        viewWillLayoutSubviews()
    }
    
    private func setupUI() {
        setupResultsView()
        setupResultsStackView()
        setupHistoryLbl()
        setupResultLbl()
        setupNumbersView()
        setupNumbersStackView()
        setupNumbersColStackView()
        setupBtns()
    }
    
    
    private func setupResultsView() {
        view.addSubview(resultsView)
        
        resultsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        resultsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        resultsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    }
    
    private func setupResultsStackView() {
        resultsView.addSubview(resultsStackView)
        resultsStackView.rightAnchor.constraint(equalTo: resultsView.rightAnchor, constant: -33).isActive = true
        resultsStackView.bottomAnchor.constraint(equalTo: resultsView.bottomAnchor, constant: -40).isActive = true
    }
    
    private func setupHistoryLbl() {
        resultsStackView.addArrangedSubview(historyLbl)
        historyLbl.text = "120 x 3 + 608 + 1080"
    }
    
    private func setupResultLbl() {
        resultsStackView.addArrangedSubview(resultLbl)
        resultLbl.text = "2,048"
    }
    
    private func setupNumbersView() {
        view.addSubview(numbersView)
        
        numbersView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        numbersView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        numbersView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        numbersView.heightAnchor.constraint(equalTo: resultsView.heightAnchor, multiplier: 1.5).isActive = true
        numbersView.topAnchor.constraint(equalTo: resultsView.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupNumbersStackView() {
        numbersView.addSubview(numbersStackView)
        
        numbersStackView.rightAnchor.constraint(equalTo: numbersView.rightAnchor, constant: -33).isActive = true
        numbersStackView.leftAnchor.constraint(equalTo: numbersView.leftAnchor, constant: 33).isActive = true
        numbersStackView.topAnchor.constraint(equalTo: numbersView.topAnchor, constant: 38).isActive = true
        numbersStackView.bottomAnchor.constraint(equalTo: numbersView.bottomAnchor, constant: -56).isActive = true
    }
    
    private func setupNumbersColStackView() {
        [firstColStackView, secondColStackView, thirdColStackView, fourthColStackView].forEach { numbersStackView.addArrangedSubview($0) }
        setupThreeBtnStackView()
        setupEqualBtnStackView()
    }
    
    private func setupThreeBtnStackView() {
        fourthColStackView.addArrangedSubview(threeBtnStackView)
    }
    
    private func setupEqualBtnStackView() {
        fourthColStackView.addArrangedSubview(equalBtnStackView)
        equalBtnStackView.heightAnchor.constraint(equalTo: threeBtnStackView.heightAnchor, multiplier: 2/3).isActive = true
    }
    
    
    private func setupBtns() {
        [themeSwitchBtn, sevenBtn, fourBtn, oneBtn, resetBtn].forEach { firstColStackView.addArrangedSubview($0) }
        
        [percentBtn, eightBtn, fiveBtn, twoBtn, zeroBtn].forEach { secondColStackView.addArrangedSubview($0) }
        
        [divideBtn, nineBtn, sixBtn, threeBtn, dotBtn].forEach { thirdColStackView.addArrangedSubview($0) }
        
        [multiplyBtn, minusBtn, plusBtn].forEach { threeBtnStackView.addArrangedSubview($0) }

        equalBtnStackView.addArrangedSubview(equalBtn)
        
        setupThemeSwitchBtn()
        setupEqualBtn()
    }
    
    private func setupThemeSwitchBtn() {
        themeSwitchBtn.addTarget(self, action: #selector(changeTheme), for: .touchUpInside)
        themeSwitchBtn.clipsToBounds = true
        themeSwitchBtn.backgroundColor = .none
        themeSwitchBtn.tintColor = .red
        themeSwitchBtn.layer.borderWidth = 1
        themeSwitchBtn.layer.cornerRadius = 33
        themeSwitchBtn.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    @objc private func changeTheme() {
        isDark.toggle()
        
        themeSwitchBtn.setImage(UIImage(systemName: isDark ? "sun.max" : "moon"), for: .normal)
        view.overrideUserInterfaceStyle = isDark ? .dark : .light
        view.backgroundColor = isDark ? .systemFill : .white
    }
    
    private func setupEqualBtn() {
        equalBtn.layer.shadowColor = UIColor(red: 247/255, green: 60/255, blue: 87/255, alpha: 1).cgColor
        equalBtn.layer.shadowOffset = .zero
        equalBtn.layer.shadowOpacity = 0.7
        equalBtn.layer.shadowRadius = 10.0
        equalBtn.layer.masksToBounds = false
        
        applyGradient()
    }
    
    private func applyGradient() {
        let colorOne = UIColor(red: 237/255, green: 14/255, blue: 152/255, alpha: 1.0)
        let colorTwo = UIColor(red: 254/255, green: 90/255, blue: 46/255, alpha: 1.0)
        
        gradient.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.cornerRadius = 33
        equalBtn.layer.insertSublayer(gradient, below: equalBtn.imageView?.layer)
        updateGradientFrame()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateGradientFrame()
    }
    
    private func updateGradientFrame() {
        gradient.frame = equalBtn.bounds
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.updateGradientFrame()
        }, completion: nil)
    }
}
