//
//  SingleResponsibility.swift
//  SOLID
//
//  Created by irakli kharshiladze on 13.11.24.
//
//MARK: Single Responsibility პრინციპის მიზანია რომ კლას ჰქონდეს მხოლოდ პასუხისმგებლობა, რომელსაც შეასრულებს შესაბამისად ეს ამარტივებს ტესტირების პროცესს და კოდის შენარჩუნებას და გაზრდას. ამ მაგალითში გვაქვს სამი კლასი სამივეს აქვს თავისი მოვალეობა რომელსაც ასრულებენ.

final class UserManagerSRP {
    private let emailService: EmailService
    private let logger: Logger
    
    init(emailService: EmailService, logger: Logger) {
        self.emailService = emailService
        self.logger = logger
    }
    
    func createUser(username: String, password: String) {
        print("მომხმარებელი \(username) შეიქმნა")
        
        emailService.sendWelcomeEmail(to: username)
        logger.logUserCreation(username: username)
    }
}

final class EmailService {
    func sendWelcomeEmail(to username: String) {
        print("\(username), თქვენ წარმატებით გაიარეთ რეგისტრაცია")
    }
}

final class Logger {
    func logUserCreation(username: String) {
        print("მომხმარებელი \(username) შეიქმნა")
    }
}

