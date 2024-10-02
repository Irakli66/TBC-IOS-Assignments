import Foundation

// 1. შექმენით "Genre" ტიპის enum, რომელიც შეიცავს წიგნის ჟანრებს (მაგ: fiction, nonFiction, mystery, sciFi, biography). დაამატეთ computed property "description", რომელიც დააბრუნებს ჟანრის აღწერას.

enum Genre: String {
    case fiction = "წარმოსახვითი ჟანრი არის გამოგონებული სცენარი"
    case nonFiction = "non fiction ჟანრი"
    case mystery = "მისტიკური ჟანრი"
    case sciFi = "სამეცნიერო ჟანრი"
    case biography = "ბიოგრაფიული ჟანრი"
    
    var description: String {
        self.rawValue
    }
    
}

print(Genre.mystery.description)

print("\n------------------\n")
/*
 2. შექმენით enum "ReadingLevel" მნიშვნელობებით: beginner, intermediate, advanced. შემდეგ შექმენით პროტოკოლი "Readable" შემდეგი მოთხოვნებით:
    - "title: String" ფროფერთი
    - "author: String" ფროფერთი
    - "publicationYear: Int" ფროფერთი
    - "readingLevel: ReadingLevel" ფროფერთი
    - "read()" მეთოდი, რომელიც დაბეჭდავს ინფორმაციას წიგნის წაკითხვის შესახებ, მაგ: "გილოცავთ თქვენ ერთ კლიკში წაიკითხეთ წიგნი" ან რამე სხვა, მიეცით ფანტაზიას გასაქანი 🤘
 */

enum ReadingLevel: String {
    case beginner
    case intermediate
    case advanced
}

protocol Readable {
    var title: String { get }
    var author: String { get }
    var publicationYear: Int { get }
    var readingLevel: ReadingLevel { get }
    
    func read()
}

print("\n------------------\n")
// 3. შექმენით სტრუქტურა "Book", რომელიც დააკმაყოფილებს "Readable" პროტოკოლს. დაამატეთ "genre: Genre" ფროფერთი და "description()" მეთოდი, რომელიც დაბეჭდავს სრულ ინფორმაციას წიგნზე.

struct Book: Readable {
    var title: String
    var author: String
    var publicationYear: Int
    var readingLevel: ReadingLevel
    var genre: Genre
    
    func read() {
        print("გილოცავ შენ წაიკითხე \(title), რომლის ავტორიცაა \(author).\nჟანრი: \(genre.description)\nგამოშვების წელი: \(publicationYear)\nსირთულე: \(readingLevel)")
    }
}

let robisnsonCrusoe = Book(title: "რობიზონ კრუზო", author: "დანიელ დეფო", publicationYear: 1719, readingLevel: .beginner, genre: .nonFiction)

robisnsonCrusoe.read()

print("\n------------------\n")
/*
 4. შექმენით "Library" კლასი შემდეგი ფროფერთებით:
    - "name: String" - ბიბლიოთეკის სახელი
    - "books: [Book]" - წიგნების მასივი

    დაამატეთ მეთოდები:
    - "add(book: Book)" - წიგნის დამატება
    - "removeBookWith(title: String)" - წიგნის წაშლა სათაურის მიხედვით
    - "listBooks()" - ყველა წიგნის ჩამონათვალის დაბეჭდვა
 
 გააფართოეთ “Library” კლასი “filterBooks” მეთოდით რომელიც არგუმენტად მიიღებს ქლოჟერს და დააბრუნებს ამ ქლოჟერის გამოყენებით გაფილტრულ წიგნთა მასივს.
 */


final class Library {
    let name: String
    var books: [Book] = []
    
    init(name: String, books: [Book] = []) {
        self.name = name
        self.books = books
    }
    
    func add(book: Book) {
        if books.contains(where: { $0.title == book.title }) {
            print("წიგნი \(book.title) უკვე არის ბიბლიოთეკაში")
        } else {
            books.append(book)
        }
    }
    
    func removeBookWith(title: String) {
        books.removeAll(where: { $0.title == title })
        print("\nწიგნი \(title) წაიშლა ბიბლიოთეკის სიიდან")
    }
    
    func listBooks() {
        books.map { print($0.title, $0.genre) }
    }
}

extension Library {
    
    func filterBooks(using filterClosure: ([Book]) -> [Book]) -> [Book] {
        filterClosure(books)
    }
}

// closure რომელიც იღებს პარამეტრს რის მიხედვითაც გვინდა გაფილტვრა და აბრუნებს ქლოჟერს
let filterBooksByGenre: (Genre) -> ([Book]) -> [Book] = { genre in
    return { books in
        books.filter { $0.genre == genre }
    }
}

let filterBooksByYear: (Int) -> ([Book]) -> [Book] = { year in
    return { books in
        books.filter { $0.publicationYear > year }
    }
}
let tbilisiLibrary = Library(name: "Library of Tbilisi")

let harryPotter = Book(title: "Harry Potter and the Philosopher's Stone 🪄", author: "J.K. Rowling", publicationYear: 1997, readingLevel: .intermediate, genre: .fiction)
let lordOfRings = Book(title: "The lord of the rings 💍", author: "J.R.R. Tolkien", publicationYear: 1954, readingLevel: .advanced, genre: .fiction)
let hamlet = Book(title: "Hamlet ✍🏻", author: "William Shakespeare", publicationYear: 1623, readingLevel: .advanced, genre: .biography)
let warAndPeace = Book(title: "War and peace ☢️🕊️", author: "Leo Tolstoy", publicationYear: 1869, readingLevel: .advanced, genre: .fiction)
let greatGatsby = Book(title: "The Great Gatsby 🕴🏻", author: "Scott Fitzgerald", publicationYear: 1925, readingLevel: .intermediate, genre: .biography)
let crimeAndPunishment = Book(title: "Crime and Punishment 🔫⚖️", author: "Fyodor Dostoevsky", publicationYear: 1866, readingLevel: .intermediate, genre: .nonFiction)
let hitchhikerGuideToGalaxy = Book(title: "The Hitchhiker's Guide to the Galaxy 🧑🏻‍🚀🪐", author: "Douglas Adams", publicationYear: 1979, readingLevel: .beginner, genre: .sciFi)

let booksArray: [Book] = [harryPotter, lordOfRings, hamlet, warAndPeace, greatGatsby, crimeAndPunishment, hitchhikerGuideToGalaxy]

booksArray.map { tbilisiLibrary.add(book: $0) }

print(tbilisiLibrary.books)
print("\n-----დამატებული წიგნები:------")
for book in tbilisiLibrary.books {
    print(book.title)
}

tbilisiLibrary.removeBookWith(title: harryPotter.title)

print("\n-----List of Books in library-----")
tbilisiLibrary.listBooks()

print("\n-----filtered list------")
//print(tbilisiLibrary.filterBooks(genre: .sciFi, operation: filterBooksClosure))
print(tbilisiLibrary.filterBooks(using: filterBooksByGenre(.fiction)))

print("\n------------------\n")
// 5.  შექმენით generic ფუნქცია groupBooksByLevel<T: Readable>(_ books: [T]) -> [ReadingLevel: [T]], რომელიც დააჯგუფებს წიგნებს კითხვის დონის მიხედვით. გამოიყენეთ ეს ფუნქცია ბიბლიოთეკის წიგნებზე და დაბეჭდეთ შედეგი.

func groupBooksByLevel<T: Readable>(_ books: [T]) -> [ReadingLevel: [T]] {
    let sortedBooks = books.reduce(into: [:]) { dict, book in
        dict[book.readingLevel, default: []].append(book)
    }
    return sortedBooks
}

print(groupBooksByLevel(tbilisiLibrary.books))

print("\n------------------\n")
/*
 6. შექმენით "LibraryMember" კლასი შემდეგი ფროფერთებით:
    - "id: Int"
    - "name: String"
    - "borrowedBooks: [Book]"
 
    დაამატეთ მეთოდები:
    - "borrowBook(_ book: Book, from library: Library)" - წიგნის გამოწერა ბიბლიოთეკიდან
    - "returnBook(_ book: Book, to library: Library)" - წიგნის დაბრუნება ბიბლიოთეკაში
 */

final class LibraryMember {
    let id: Int
    let name: String
    var borrowedBooks: [Book] = []
    
    init(id: Int, name: String, borrowedBooks: [Book] = []) {
        self.id = id
        self.name = name
        self.borrowedBooks = borrowedBooks
    }
    
    func borrowBook(_ book: Book, from library: Library) {
        if library.books.contains(where: { $0.title == book.title }) {
            
            print("\(name) შენ ითხოვე წიგნი: \(book.title)")
            borrowedBooks.append(book)
            tbilisiLibrary.books.removeAll(where: { $0.title == book.title })
            
        } else {
            print("\(name), \(book.title) წიგნი არ არის მარაგში")
        }
    }
    
    func returnBook(_ book: Book, to library: Library) {
        if borrowedBooks.contains(where: { $0.title == book.title }) {
            
            print("\(name) შენ დააბრუნე წიგნი: \(book.title)")
            borrowedBooks.removeAll(where: { $0.title == book.title })
            tbilisiLibrary.books.append(book)
            
        } else {
            print("\nწიგნი \(book.title) ვერ მოიძებნა შენს წიგნების სიაში")
        }
    }
}

let irakli = LibraryMember(id: 6, name: "Irakli")

irakli.borrowBook(hitchhikerGuideToGalaxy, from: tbilisiLibrary)
irakli.borrowBook(harryPotter, from: tbilisiLibrary)
irakli.borrowBook(greatGatsby, from: tbilisiLibrary)
irakli.borrowBook(lordOfRings, from: tbilisiLibrary)

irakli.returnBook(hamlet, to: tbilisiLibrary)
irakli.returnBook(lordOfRings, to: tbilisiLibrary)

print("\n----ნათხოვარი წიგნების სია-----")
irakli.borrowedBooks.map { print($0.title) }

print("\n------------------\n")
/*
 7. შექმენით მინიმუმ 5 "Book" ობიექტი და 1 "Library" ობიექტი. დაამატეთ წიგნები ბიბლიოთეკაში "add(book:)" მეთოდის გამოყენებით. შემდეგ:

    - გამოიყენეთ "listBooks()" მეთოდი ყველა წიგნის ჩამოსათვლელად
    - წაშალეთ ერთი წიგნი "removeBookWith(title:)" მეთოდის გამოყენებით
    - გამოიყენეთ "filterBooks" მეთოდი და დაბეჭდეთ მხოლოდ ის წიგნები, რომლებიც გამოცემულია 2000 წლის შემდეგ
 */

let killMockingbird = Book(title: "To kill a mockingbird 🐦‍🔥", author: "Harper Lee", publicationYear: 1960, readingLevel: .intermediate, genre: .mystery)
let heartOfDarkness = Book(title: "Heart of darkness 🌚", author: "Joseph Conrad", publicationYear: 1899, readingLevel: .advanced, genre: .fiction)
let stranger = Book(title: "The stranger", author: "Albert Camus", publicationYear: 1942, readingLevel: .beginner, genre: .fiction)
let stranger2 = Book(title: "The stranger 2", author: "Albert Camus", publicationYear: 1944, readingLevel: .beginner, genre: .fiction)
let kiteRunner = Book(title: "The kite runner 🏃", author: "Khaled Hosseini", publicationYear: 2003, readingLevel: .beginner, genre: .biography)
let road = Book(title: "The road 🛣️", author: "Cormac Mc Carthy", publicationYear: 2006, readingLevel: .advanced, genre: .fiction)

let bookList: [Book] = [killMockingbird, heartOfDarkness, stranger, stranger2, kiteRunner, road]

let freeLibrary: Library = Library(name: "Free Library")

bookList.map { freeLibrary.add(book: $0) }
print("----Free Library-ის წიგნების სია----\n")
freeLibrary.listBooks()

freeLibrary.removeBookWith(title: stranger.title)
print("\n----Free Library-ის წიგნების სია----\n")
freeLibrary.listBooks()

print("\n----Only Books published after 2000")
print(freeLibrary.filterBooks(using: filterBooksByYear(2000)))

print("\n------------------\n")
/*
 8. შექმენით მინიმუმ 2 "LibraryMember" ობიექტი. თითოეული წევრისთვის:
    - გამოიწერეთ 2 წიგნი "borrowBook(_:from:)" მეთოდის გამოყენებით
    - დააბრუნეთ 1 წიგნი "returnBook(_:to:)" მეთოდის გამოყენებით
    დაბეჭდეთ თითოეული წევრის გამოწერილი წიგნების სია
 */

let dato = LibraryMember(id: 3, name: "Dato")
let nodo = LibraryMember(id: 5, name: "Nodo")

[kiteRunner, road].map { dato.borrowBook($0, from: freeLibrary) }
dato.returnBook(road, to: freeLibrary)
print(dato.borrowedBooks)
print("\n")
[hamlet, warAndPeace].map { nodo.borrowBook($0, from: tbilisiLibrary) }
nodo.returnBook(hamlet, to: tbilisiLibrary)
print(nodo.borrowedBooks)

print("\n------------------\n")
/*
 9. გააფართოვეთ "Array" ტიპი, სადაც ელემენტი აკმაყოფილებს "Readable" პროტოკოლს (ანუ ამ ექსთენშენი მოცემული მეთოდები ხელმსიაწვდომი იქნება მხოლოდ [Readable] მასივისთვის), შემდეგი მეთოდებით:
    - "findByAuthor(_ author: String) -> [Readable]" - აბრუნებს ავტორის მიხედვით ნაპოვნ წიგნებს
    - "oldestBook() -> Readable?" - აბრუნებს ყველაზე ძველ წიგნს
 */

extension Array where Element: Readable {
    
    func filterByAuthor(_ author: String) -> [Readable] {
        self.filter { $0.author == author }
    }
    
    func oldestBook() -> Readable? {
        self.min(by: { $0.publicationYear < $1.publicationYear })
    }
}

let threeBooks: [Book] = [hitchhikerGuideToGalaxy, road, warAndPeace]
print(threeBooks.filterByAuthor("Douglas Adams"))

let oldesBook = tbilisiLibrary.books.oldestBook()
print("\n", oldesBook ?? "")

print("\n------------------\n")
/*
 10. შექმენით "EBook" სტრუქტურა, რომელიც დააკმაყოფილებს "Readable" პროტოკოლს და დაამატეთ "fileSize: Double" ფროფერთი.

   გამოიყენეთ "extension", რომ დაამატოთ "printDetails()" მეთოდი, რომელიც დაბეჭდავს ელექტრონული წიგნის დეტალებს.

   შექმენით მინიმუმ 2 "EBook" ობიექტი და გამოიძახეთ "printDetails()" მეთოდი თითოეულისთვის.
 */

struct Ebook: Readable {
    var title: String
    var author: String
    var publicationYear: Int
    var readingLevel: ReadingLevel
    var fileSize: Double
    
    func read() {
        print("გილოცავ შენ წაიკითხე \(title), რომლის ავტორიცაა \(author).")
    }
    
}

extension Ebook {
    func printDetails(){
        print("\nსათაური: \(title)\nავტორი: \(author)\nგამოცემის წელი: \(publicationYear)\nკითხვის დონე: \(readingLevel)\nფაილის ზომა: \(fileSize) MB")
    }
}

let catchingFire = Ebook(title: "Catching fire", author: "Suzanne Collins", publicationYear: 2009, readingLevel: .beginner, fileSize: 6.2)
let divergent = Ebook(title: "Divergent", author: "Veronica Roth", publicationYear: 2011, readingLevel: .advanced, fileSize: 3.4)
let martin = Ebook(title: "The Martin", author: "Andy Weir", publicationYear: 2011, readingLevel: .beginner, fileSize: 2.6)

let ebookList: [Ebook] = [catchingFire, divergent, martin]
ebookList.map { $0.printDetails() }

print("\n------------------\n")
// 11. შექმენით ჯენერიკ ფუნქცია "findMostFrequent<T: Hashable>(_ array: [T]) -> T?", რომელიც იპოვის და დააბრუნებს მასივში ყველაზე ხშირად გამეორებულ ელემენტს. თუ რამდენიმე ელემენტი თანაბრად ხშირად მეორდება, დააბრუნეთ პირველი მათგანი.

func findMostFrequent<T: Hashable>(_ array: [T]) -> T? {
    var freqDict = [T: Int]()
    
    array.map { freqDict[$0, default: 0] += 1 }
    
    return freqDict.max{ $0.value < $1.value }?.key
}

let numbers = [2, 3, 4, 15, 15, 15, 2, 3, 15, 3]

print(findMostFrequent(numbers) ?? 0)
print(findMostFrequent(["orange", "orange", "apple", "apple", "cherry", "cherry", "strawberry"]) ?? "")

print("\n------------------\n")
/*
 12. შექმენით მასივი, რომელიც შეიცავს ყველა წიგნის ავტორს მე-7 დავალებაში შექმნილი ბიბლიოთეკიდან.
 გამოიძახეთ "findMostFrequent" ფუნქცია ამ მასივზე, რათა იპოვოთ ყველაზე პოპულარული ავტორი.
 დაბეჭდეთ შედეგი: "ბიბლიოთეკაში ყველაზე პოპულარული ავტორი არის: [ავტორის სახელი]".
 */

var bookAuthors: [String] = []
bookList.map { bookAuthors.append($0.author) }

print(bookAuthors)
//print(findMostFrequent(bookAuthors) ?? "")
print("\nბიბლიოთეკაში ყველაზე პოპულარული ავტორი არის:", findMostFrequent(bookAuthors) ?? "")
