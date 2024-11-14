//
//  OpenClosed.swift
//  SOLID
//
//  Created by irakli kharshiladze on 13.11.24.
//
//MARK: Open Closed პრინციპის თანახმად კლასები, მოდულები, ფუნქციები უნდა ფარტოვდებონენ მაგრამ დახურული იყვნენ მოდიფიკაციისთვის ანუ უნდა შეგვეძლოს ახალი ფუნქციონალის დამატება უკვე არსებული კოდის შეცვლის გარეშე. ამ მაგალითშიც თუ გვსურს ახალი გადახდის მეთოდის დამატება შევქმნით კლასს, რომელიც აკმაყოფილებს "PaymentMethod" პროტოკოლს.

protocol PaymentMethod {
    func processPayment()
}

final class CreditCardPayment: PaymentMethod {
    func processPayment() {
        print("Processing credit card payment...")
    }
}

final class PayPalPayment: PaymentMethod {
    func processPayment() {
        print("Processing PayPal payment...")
    }
}

final class ApplePayPayment: PaymentMethod {
    func processPayment() {
        print("Processing Apple Pay payment...")
    }
}

final class PaymentProcessorOCP {
    func processPayment(method: PaymentMethod) {
        method.processPayment()
    }
}

let creditCardPayement = CreditCardPayment()
let payPalPayment = PayPalPayment()
let applePayment = ApplePayPayment()

//print(creditCardPayement.processPayment())
//print(payPalPayment.processPayment())
//print(applePayment.processPayment())
