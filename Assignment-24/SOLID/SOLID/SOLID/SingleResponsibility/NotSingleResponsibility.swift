//
//  NotSingleResponsibility.swift
//  SOLID
//
//  Created by irakli kharshiladze on 13.11.24.
//
//MARK: ეს მიდგომა ეწინააღმდეგება NotSingle Responsibility პრინციპს რადგან ერთი კლასი არის პასუხისმგებელი რამდენიმე საქმის გაკეთებაზე.

final class UserManager {
    func createUser(username: String, password: String) {
        print("მომხმარებელი: \(username) შეიქმნა")
        
        sendWelcomeEmail(to: username)
        logUserCreation(username: username)
    }
    
    private func sendWelcomeEmail(to username: String) {
        print("\(username), თქვენ წარმატებით გაიარეთ რეგისტრაცია")
    }
    
    private func logUserCreation(username: String) {
        print("მომხმარებელი \(username) შეიქმნა")
    }
}
