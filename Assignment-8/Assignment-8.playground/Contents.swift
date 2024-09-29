import Foundation

/*
 1.შექმენით Genre ტიპის enum, რომელიც შეიცავს ფილმის ჟანრებს, მაგალითად: action, drama, comedy, thriller და სხვა. შექმენით ძირითადი კლასი Film, რომელსაც ექნება შემდეგი თვისებები:
    title - ფილმის სახელი,
    releaseYear— გამოშვების წელი,
    genre — ფილმის ჟანრი,
    revenue - შემოსავალი
    მეთოდი description(), რომელიც დაბეჭდავს ინფორმაციას ფილმზე.
 */

enum Genre {
    case action
    case drama
    case comedy
    case thriller
}

final class Film {
    let title: String
    let releaseYear: Int
    let genre: Genre
    let revenue: Int
    
    init(title: String, releaseYear: Int, genre: Genre, revenue: Int) {
        self.title = title
        self.releaseYear = releaseYear
        self.genre = genre
        self.revenue = revenue
    }
    
    func description() {
        print("\(title) არის \(genre) ჟანრის და გამოსულია \(releaseYear) წელს \nშემოსავალო: \(revenue)$")
    }
    
    static func removeFilm(filmArray: inout [Film], title: String) {
            filmArray.removeAll { $0.title == title }
        }
}

let filmLordOfRings = Film(title: "Lord of ring💍", releaseYear: 2001, genre: .action, revenue: 3000000)

filmLordOfRings.description()

print("\n------------------\n")
/*
 2. შექმენით კლასი Person, რომელსაც აქვს შემდეგი თვისებები:
 name — პიროვნების სახელი
 birthYear — დაბადების წელი.
 მეთოდი getAge რომელიც დაიანგარიშებს და დააბრუნებს ამ პიროვნების ასაკს მოცემულ წელს.
 */

class Person {
    let name: String
    let birthYear: Int
    
    init(name: String, birthYear: Int) {
        self.name = name
        self.birthYear = birthYear
    }
    
    func getAge() -> Int {
        let currentYear = Calendar.current.component(.year, from: Date())
        return currentYear - birthYear
    }
}

let irakli = Person(name: "Irakli", birthYear: 2000)
print("ასაკი:", irakli.getAge())

print("\n------------------\n")
// 3. Film კლასში შექმენით ფუნქცია removeFilm რომელიც პარამეტრად მიიღებს ფილმების მასივს და დასახელებას, ფუნქციამ უნდა წაშალოს მასივში თუ მოიძებნა მსგავსი დასახელების ფილმი.

var filmArray: [Film] = [
    Film(title: "Interstelar 👩‍🚀", releaseYear: 2011, genre: .drama, revenue: 25220000),
    Film(title: "The godfather 👨", releaseYear: 1972, genre: .drama, revenue: 2350000),
    Film(title: "Fight Club 🤫", releaseYear: 1999, genre: .thriller, revenue: 50000000),
    Film(title: "Gladiator ⚔️", releaseYear: 2000, genre: .drama, revenue: 55000000),
    Film(title: "Transformers 🤖", releaseYear: 2007, genre: .action, revenue: 505000000)
]

Film.removeFilm(filmArray: &filmArray, title: "Gladiator ⚔️")

for film in filmArray {
    film.description()
    print("\n")
}

print("------------------\n")
// 4. შექმენით კლასი Actor, რომელიც არიას Person კლასის მემკვიდრე კლასი Actor-ს უნდა ჰქონდეს actedFilms  მსახიობის მიერ ნათამაშები ფილმების სია და მეთოდი რომელიც მსახიობის მიერ ნათამაშებ ფილმებს დაამატებს სიაში.

final class Actor: Person {
    var actedFilms: [Film] = []
    
     init(actedFilms: [Film] = [], name: String, birthYear: Int) {
        self.actedFilms = actedFilms
        super.init(name: name, birthYear: birthYear)
    }
    
    func addFilmsToActor(film: Film) {
        actedFilms.append(film)
    }
}

let filmDumbAndDumber = Film(title: "Dumb and Dumber 🤪", releaseYear: 2004, genre: .comedy, revenue: 2384888)
let filmTheMask = Film(title: "The Mask 👺", releaseYear: 2006, genre: .comedy, revenue: 4500000)

let actorJim = Actor(name: "Jim Cary", birthYear: 1962)

actorJim.addFilmsToActor(film: filmDumbAndDumber)
actorJim.addFilmsToActor(film: filmTheMask)

print("List of \(actorJim.name) movies:")
actorJim.actedFilms.map { print($0.description()) }

print("\n------------------\n")
// 5. შექმენი Director კლასი, რომელიც ასევე Person-ის მემკვიდრეა და ექნება directedFilms რეჟისორის მიერ გადაღებული ფილმების სია და totalRevenue რეჟისორის ჯამური შემოსავალი. დაამატე მეთოდი რომელიც რეჟისორის მიერ გადაღებულ ფილმებს დაამატებს და დაითვლის თითოეული ფილმისთვის ჯამურ შემოსავალს.

class Director: Person {
    var directedFilms: [Film] = []
    var totalRevenue: Int = 0
    
    init( directedFilms: [Film] = [], name: String, birthYear: Int) {
        self.directedFilms = directedFilms
        super.init(name: name, birthYear: birthYear)
    }
    
    func addFilmsToDirector(film: Film) {
            directedFilms.append(film)
            totalRevenue += film.revenue
    }
}

let directorNolan = Director(name: "Christopher Nolan", birthYear: 1970)
let directorTarantino = Director(name: "Quentin Tarantino", birthYear: 1963)

directorNolan.addFilmsToDirector(film: Film(title: "Interstelar", releaseYear: 2014, genre: .drama, revenue: 500000000))
directorNolan.addFilmsToDirector(film: Film(title: "Inception", releaseYear: 2010, genre: .action, revenue: 200000000))

directorTarantino.addFilmsToDirector(film: Film(title: "Pulp Fiction", releaseYear: 1994, genre: .thriller, revenue: 250000))
directorTarantino.addFilmsToDirector(film: Film(title: "Kill Bill", releaseYear: 2003, genre: .action, revenue: 650000))

print("---------Christopher Nolan---------")
let nolanMovies = directorNolan.directedFilms.map { $0.title }
let nolanFilmList = nolanMovies.joined(separator: ", ")

print("\(directorNolan.name) აქვს გადაღბული: \(nolanFilmList) \nმისი მთლიანი შემოსავალი შეადგენს: \(directorNolan.totalRevenue)$")

print("\n---------Quentin Tarantino---------")
let tarantinoMovies = directorTarantino.directedFilms.map { $0.title }
let tarantinoFilmList = tarantinoMovies.joined(separator: ", ")
print("\(directorTarantino.name) აქვს გადაღბული \(tarantinoFilmList) \nმისი მთლიანი შემოსავალი შეადგენს: \(directorTarantino.totalRevenue)$")

print("\n------------------\n")
// 6. შექმენით 5 ფილმის და 5 მსახიობის ობიექტები და Dictionary, რომელშიც key იქნება მსახიობის სახელი, ხოლო მნიშვნელობებად მიიღებს იმ ფილმების სიას, რომლებშიც მონაწილეობს ეს მსახიობი.

let filmForestGump: Film = Film(title: "Forest Gump", releaseYear: 1994, genre: .drama, revenue: 35000000)
let filmMatrix: Film = Film(title: "Matrix", releaseYear: 1999, genre: .action, revenue: 65000000)
let filmDune: Film = Film(title: "Dune", releaseYear: 2024, genre: .action, revenue: 85000000)
let filmJoker: Film = Film(title: "Joker", releaseYear: 2019, genre: .drama, revenue: 95000000)
let filmOppenheimer: Film = Film(title: "Oppenheimer", releaseYear: 2023, genre: .drama, revenue: 75000000)

let randomFilmsList: [Film] = [filmForestGump, filmMatrix, filmDune, filmJoker, filmOppenheimer]

let actorTomHanks: Actor = Actor(name: "Tom Hanks", birthYear: 1956)
let actorKeanuReeves: Actor = Actor(name: "Keanu Reeves", birthYear: 1964)
let actorTimotheeChalamet: Actor = Actor(name: "Temothee Chalamet", birthYear: 1995)
let actorJoaquinPhoenix: Actor = Actor(name: "Joaquin Phoenix", birthYear: 1974)
let actorCillianMurphy: Actor = Actor(name: "Cillian Murphy", birthYear: 1976)

actorTomHanks.addFilmsToActor(film: filmForestGump)
actorKeanuReeves.addFilmsToActor(film: filmMatrix)
actorTimotheeChalamet.addFilmsToActor(film: filmDune)
actorJoaquinPhoenix.addFilmsToActor(film: filmJoker)
actorCillianMurphy.addFilmsToActor(film: filmOppenheimer)

let randomActorsList: [Actor] = [actorTomHanks, actorKeanuReeves, actorTimotheeChalamet, actorJoaquinPhoenix, actorCillianMurphy]

let actorsFilmsDictionary = randomActorsList.reduce(into: [String: [String]]()) { result, actor in
    result[actor.name] = actor.actedFilms.map { $0.title }
}

print(actorsFilmsDictionary)

print("\n------------------\n")
// 7. გამოიყენეთ map, იმისთვის რომ დაბეჭდოთ ყველა ფილმის სათაურების სია ამავე ფილმების მასივიდან

randomFilmsList.map{ print( "Film:", $0.title ) }

print("\n------------------\n")
// 8. reduce ფუნქციის გამოყენებით დაიანგარიშეთ ამ ყველა ფილმების გამოშვების საშუალო წელი.

let averageYear = randomFilmsList.reduce(0) { ($0 + $1.releaseYear) } / randomFilmsList.count

print("Average release year:", averageYear)

print("\n------------------\n")
/* 
9. შექმენით კლასი SuperHero, რომელიც შეიცავს შემდეგ ველებს:
name სუპერ გმირის სახელი
superPower  სუპერ ძალა
level - PowerLevel enum-ის ტიპის,
და allies ამავე ტიპის მოკავშირეების ჩამონათვალი,
დაამატეთ ინიციალიზაციის და დეინიციალიზაციის მეთოდები
*/

final class SuperHero {
    let name: String
    let superPower: String
    let level: PowerLevel
    var allies: [SuperHero] = []
    
    
    init(name: String, superPower: String, level: PowerLevel, allies: [SuperHero] = []) {
        self.name = name
        self.superPower = superPower
        self.level = level
        self.allies = allies
    }
    
    deinit {
        print("Deinit")
    }
    
    static func uniquePowers(heroes: [SuperHero]) -> Set<String> {
        var superPowerList: [String] = []
        heroes.map{ superPowerList.append( $0.superPower ) }
        let uniqueSuperPowerList = Set(superPowerList)
        return uniqueSuperPowerList
    }
    
    func addAlly(hero: SuperHero) {
        allies.append(hero)
        hero.allies.append(self)
    }
}
// 10. შექმენით Enum PowerLevel, რომელიც მოიცავს შემდეგ დონეებს: weak, average, strong, super და დაამატეთ აღწერის მეთოდი რომელიც დააბრუნებს level-ს ტექსტური ფორმით.

enum PowerLevel {
    case weak
    case average
    case strong
    case `super`
    
    func descriptio() {
        switch self {
        case .weak:
            "weak"
        case .average:
            "average"
        case .strong:
            "strong"
        case .super:
            "super"
        }
    }
}

// 11. uniquePowers ყველა გმირისათვის და დააბრუნებს  უნიკალური ძალების სიას

let superman = SuperHero(name: "Superman 🦸🏻", superPower: "flying", level: .strong)
let ironman = SuperHero(name: "Ironman 🤖", superPower: "flying", level: .super)
let hulk = SuperHero(name: "Hulk 🟢", superPower: "super size", level: .average)
let thor = SuperHero(name: "Thor 🔨", superPower: "strength", level: .strong)
let antman = SuperHero(name: "Antman 🐜", superPower: "super size", level: .weak)

let superHeroes: [SuperHero] = [superman, ironman, hulk, thor, antman]

let uniquePowers: Set<String> = SuperHero.uniquePowers(heroes: superHeroes)

uniquePowers.map{ print( $0 ) }

print("\n------------------\n")
// 12.  მეთოდი addAlly დაამატებს მოკავშირეების სიას, შექმენით 2 SuperHero ობიექტი და გახადეთ ისინი მოკავშირეები.

let deadpool = SuperHero(name: "Dead pool ☠️", superPower: "immortal", level: .super)
let wolverine = SuperHero(name: "Wolverine 🐺", superPower: "claws", level: .average)

deadpool.addAlly(hero: wolverine)

let deadPoolAllyList = deadpool.allies.map { $0.name }
let deadPoolAllies = deadPoolAllyList.joined(separator: ", ")
print("\(deadpool.name)'s allies: \(deadPoolAllies)")

let wolverineAllyList = wolverine.allies.map { $0.name }
let wolverineAllies = wolverineAllyList.joined(separator: ", ")
print("\(wolverine.name)'s allies: \(wolverineAllies)")
