import UIKit

var greeting = "Hello, playground"

// 1. შექმენით FoodGroup Enum, რომელიც მოიცავს: fruit, vegetable, protein, dairy, grain ჩამონათვალს.

enum FoodGroup {
    case fruit
    case vegetable
    case protein
    case dairy
    case grain
}

// 2. შექმენით enum ProductStatus (გაყიდულია, ხელმისაწვდლომია ქეისებით)

enum ProductStatus {
    case sold
    case available
}

/*
 3. შექმენით სტრუქტურა Product რომელიც შეიცავს.
    ცვლადებს: name, category(FoodGroup), price, info(რომელიც ფასის და სახელის ინფოს მოგვაწვდის),
    ფასდაკლება, მასა, კალორია100გრამზე, ProductStatus ცვლადი
    ფუნქციები: ფადაკლებული ფასის ჩვენება, ყიდვა, გამოითვალე კალორია მასაზე დაყრდნობით.
*/

struct Product {
    var name: String
    var category: FoodGroup
    var price: Double
    var discount: Double = 2
    var weight: Double
    var calories: Int
    var productStatus: ProductStatus
    
    var info: String {
        "1 კილო \(name) ღირს: \(price) ლარი"
    }
    
    func priceAfterDiscount() -> Double { ( price - discount ) * weight }
    
    func buyProduct() -> Double {
        switch productStatus {
        case .available:
            print("თქვენ იყიდეთ \(weight) კილო  \(name) \(priceAfterDiscount()) ლარად ფასდაკლებით")
            return priceAfterDiscount()
        case .sold:
            print("\(name)-ს მარაგი ამოიწურე")
            return 0.0
        @unknown default:
        print("unknown")
        }
        
    }
    
    func calculateCalories() -> Double {
        let caloriesInProduct = weight * 10.0 * Double(calories)
        print("\(weight) კილო \(name) არის \(Int(caloriesInProduct)) კალორია \n")
        return caloriesInProduct
    }
    
    mutating func changeStatus(with newStatus: ProductStatus) { productStatus = newStatus }
}


let cheese = Product(name: "ყველი", category: .dairy, price: 15, weight: 2, calories: 230, productStatus: .available)
let carrot = Product(name: "სტაფილო", category: .vegetable, price: 5, weight: 2, calories: 25, productStatus: .available)

print("\n------- ყველი 🧀 --------")
print(cheese.info)
cheese.buyProduct()
cheese.calculateCalories()
print("\n------- სტაფილო 🥕 --------")
print(carrot.info)
carrot.buyProduct()
carrot.calculateCalories()

print("\n---------------------------\n")
// 4. შექმენით მასივი პროდუქტებით სადაც მინიმუმ 15 პროდუქტი გექნებათ.

var productsArray: [Product] = [
    Product(name: "ყველი", category: .dairy, price: 15, weight: 2, calories: 230, productStatus: .available),
    Product(name: "კარაქი", category: .dairy, price: 20, weight: 0.7, calories: 650, productStatus: .available),
    Product(name: "არაჟანი", category: .dairy, price: 6, weight: 0.5, calories: 250, productStatus: .sold),
    Product(name: "სტაფილო", category: .vegetable, price: 5, weight: 2, calories: 25, productStatus: .available),
    Product(name: "კომბოსტო", category: .vegetable, price: 3, weight: 1, calories: 75, productStatus: .available),
    Product(name: "კარტოფილი", category: .vegetable, price: 3.5, weight: 6, calories: 155, productStatus: .sold),
    Product(name: "ორაგული", category: .protein, price: 85, weight: 1.5, calories: 325, productStatus: .available),
    Product(name: "საქონლის ხორცი", category: .protein, price: 25, weight: 2.5, calories: 445, productStatus: .sold),
    Product(name: "ქათამი", category: .protein, price: 15, weight: 1.4, calories: 125, productStatus: .available),
    Product(name: "ვაშლი", category: .fruit, price: 2.5, weight: 3, calories: 75, productStatus: .sold),
    Product(name: "გარგარი", category: .fruit, price: 6, weight: 1.6, calories: 54, productStatus: .available),
    Product(name: "ატამი", category: .fruit, price: 4.3, weight: 0.6, calories: 65, productStatus: .available),
    Product(name: "ბრინჯი", category: .grain, price: 3.5, weight: 3, calories: 25, productStatus: .available),
    Product(name: "წიწიბურა", category: .grain, price: 2.5, weight: 1.5, calories: 45, productStatus: .available),
    Product(name: "მუხუდო", category: .grain, price: 4.3, weight: 1.2, calories: 55, productStatus: .sold)
]

//productsArray.map{ print($0) }
//productsArray.map{ print($0.info); $0.buyProduct(); $0.calculateCalories() }

print("\n---------------------------\n")
// 5. მიღებული მასივისგან შექმენით ახალი მასივი სადაც მხოლოდ პროდუქტის name იქნება ჩამოწერილი

var productsNameArray: [String] = []

productsArray.map{ productsNameArray.append($0.name) }
print(productsNameArray)

print("\n---------------------------\n")
// 6. თავდაპირველი მასივის ელემენტები დაალაგეთ ფასის ზრდადობის მიხედვით.

let sortedProductsArrayByPrice = (productsArray.sorted{ $0.price < $1.price })
//sortedProductsArrayByPrice.map{ print($0) }

print("\n---------------------------\n")
// 7. რენდომ (1)კატეგორიის ყველა პროდუქტის სტატუსი შეცვალეთ ხელმისაწვდომიდან გაყიდულზე.

func changeStatusOfProductToSold(products: [Product]) -> [Product] {
    var filteredProductsByCategory = products.filter{ $0.category == .grain }
    
    for index in 0..<filteredProductsByCategory.count {
        filteredProductsByCategory[index].changeStatus(with: .sold)
    }
    return filteredProductsByCategory
}

changeStatusOfProductToSold(products: productsArray).map{ print("\($0.name) is \($0.productStatus)") }

print("\n---------------------------\n")
// 8. გაიგეთ ყველა იმ პროდუქტის ერთეულის ჯამური ღირებულება რომელიც ხელმისაწვდომია.

print(productsArray.filter{ $0.productStatus == .available }.map{ $0.priceAfterDiscount() }.reduce( 0.0, + ))

print("\n---------------------------\n")
// 9. შექმენით ფუნქცია რომელიც მიიღებს პროდუქტების მასივს და დააბრუნებს dictionary-ს სადაც key იქნება კატეგორიის სახელწოდება და value იქნება იმ პროდუქტების მასივი რომლებიც შეესაბამება მოცემულ კატეგორიას.

func sortProductsByCategory(products: [Product]) -> [FoodGroup: [Product]] {
   return products.reduce(into: [:]){ result, product in
        result[product.category, default: []].append(product)
    }

}

let result = sortProductsByCategory(products: productsArray)

for (category, productsInCategory) in result {
    print("\n\(category):")
    for product in productsInCategory {
        print("- \(product.name)")
    }
}
