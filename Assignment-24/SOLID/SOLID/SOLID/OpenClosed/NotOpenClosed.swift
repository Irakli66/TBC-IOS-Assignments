//
//  NotOpenClosed.swift
//  SOLID
//
//  Created by irakli kharshiladze on 13.11.24.
//
//MARK: ამ მაგალითში დარღვეულია Open Closed პრინციპი, რადგან ყოველ ჯერზე ჭირდება კლასს მოდიფიკაცია როცა გვინდა დავამატოთ ახალი ფუნქციონალი. მაგალთად როცა გვინდა დავამატოთ ახალი გადახდის მეთოდი უნდა დავამატოთ ახალი if else ბლოკი

final class PaymentProcessor {
    func processPayment(type: String) {
        if type == "CreditCard" {
            print("Processing credit card payment")
        } else if type == "PayPal" {
            print("Processing PayPal payment")
        } else if type == "ApplePay" {
            print("Processing Apple Pay payment")
        } else {
            print("Unknown payment type")
        }
    }
}
