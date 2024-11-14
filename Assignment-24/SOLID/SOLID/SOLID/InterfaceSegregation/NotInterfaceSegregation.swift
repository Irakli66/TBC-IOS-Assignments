//
//  NotInterfaceSegregation.swift
//  SOLID
//
//  Created by irakli kharshiladze on 13.11.24.
//

//MARK: ეს მიდგომა არ არის სწორი, რადგან კლასს ვაიძულებთ დააკმაყოფილოს ის ინტერფეისები, რომლებსაც არ იყენებს. ამის მიზეზი არის ზედმეტად გაბერილი ინტერფეისი და კლასებიც იძულებული ხდებიან დააკმაყოფილონ ის. ამის თავიდან ასარიდებლად უნდა გამოვიყენოთ ზუსტად ინტერფეიცის სეგრეგაციის პრინციპი წინააღმდეგ შემთხვევაში კოდის შენახვა და მისი მწყობრში ყოფნა გართულდება, როდესაც გაიზრდება Animal პროტოკოლი და კლსაები რომლებიც არ იყენებენ მის ზოგიერთ ინტერფეისს ვეღარ იფუნქციონირებენ.

protocol Animal {
    func eatingFruits()
    func swimming()
    func running()
    func edible()
}

final class Deer: Animal {
    func eatingFruits() {
        print("ჭამს ხილს")
    }
    
    func swimming() {
        print("ცურავს")
    }
    
    func running() {
        print("დარბის")
    }
    
    func edible() {
        print("იჭმება შემწვარი")
    }
    
    
}

final class Hippopotamus: Animal {
    func eatingFruits() {
        print("ჭამს ხილს")
    }
    
    func swimming() {
        print("შეუძლია ცურვა")
    }
    
    func running() {
        print("დარბის")
    }
    // ეს ფუნქცია არ უნდა ქონდეს რადგან არ იჭმება
    func edible() {
        
    }
}
