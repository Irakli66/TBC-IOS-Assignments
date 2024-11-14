//
//  InterfaceSegregation.swift
//  SOLID
//
//  Created by irakli kharshiladze on 13.11.24.
//

//MARK: "Interface Segregation" მიდგომით კი უკვე ყველა კლასი აკმაყოფილებს მხოლოდ იმ პროტოკოლს, რომელიც არის შესაბამისი მისთვის და გვარიდებს გამოუყენებელ მეთოდებს.

protocol Movement {
    func swimming()
    func running()
}

protocol FeedsWith {
    func eatingFruits()
}

protocol Edible {
    func edible()
}

final class DeerISP: Movement, FeedsWith, Edible {
    func swimming() {
        print("ცურავს")
    }
    
    func running() {
        print("დარბის")
    }
    
    func eatingFruits() {
        print("ჭამს ხილს")
    }
    
    func edible() {
        print("იჭმება")
    }
    
    
}

final class HippopotamusISP: Movement, FeedsWith {
    func swimming() {
        print("ცურავს")
    }
    
    func running() {
        print("დარბის")
    }
    
    func eatingFruits() {
        print("ჭამს ხილს")
    }
    
    
}
