//
//  NotLiskovSubstitution.swift
//  SOLID
//
//  Created by irakli kharshiladze on 13.11.24.
//
//MARK: ეს არის "Liskov Substitution"-ის პირობების დარღვევა ვინაიდან მოცემულ მაგალითში ვამბობთ, რომ რაღაც სატრანსპორტო საშუალებას შეუძლია ფრენა და ყველა მის ქვე-კლასსაც უნდა შეეძლოს ფრენა. ხოლო ავტობუსი (ტრანსპორტის შვილობილი კლასი) ცვლის fly ფუნქციას რადგან ავტობუსს არ შეუძლია ფრენა და ბეჭდავს "ავტობუსები ვერ დაფრინავენ", შესაბამისად არღვევს ლისკოვის პრინციპს რადგან შვილობილი კლასი ცვლის მშობლის (სუპერ კლასის) მეთოდს რაც ცვლის მის თვისებებს და მოქმედებას

class Transport {
    func fly() {
        print("გადამყავს მგზავრები ფრენით")
    }
}

final class Bus: Transport {
    override func fly() {
        print("ავტობუსები ვერ დაფრინავენ")
    }
}
