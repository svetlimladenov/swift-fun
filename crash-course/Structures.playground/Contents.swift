import Foundation

enum Gender {
    case Male
    case Female
}

struct Person {
    var name: String
    var age: Int
    var gender: Gender
}

let me = Person(name: "Svetlin", age: 24, gender: Gender.Male)

var ivan = me // Structs are value types, so everything is copied

ivan.age = 15
ivan.name = "Ivan"

print(ivan.name, ivan.gender)
print(me.name, me.gender)

class Dog {
    var name: String
    var age: Int
    private var owner: Person
    
    // Unlike structures, class instances don’t receive a default memberwise initializer.
    init(name: String) {
        self.name = name
        self.age = 15
        self.owner = Person(name: "test", age: 1, gender: Gender.Female)
    }
    
    init(name: String, age: Int, owner: Person) {
        self.name = name
        self.age = age
        self.owner = owner
    }
    
    public func sayHello() {
        print("Hello, my name is \(self.name), my owner is \(self.owner.name)")
    }
    
    public func getOwner() -> Person {
        return self.owner
    }
}

let sharo = Dog(name: "sharo", age: 15, owner: me)
let pesho = Dog(name: "pesho")

print(pesho.getOwner().name)


enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north // Cannot assign to value: 'self' is immutable, thats why we set mutating
    }
}

var currentDirection = CompassPoint.west // enums are also the same
var copyDirection = currentDirection
print("Current dir \(currentDirection)")
currentDirection.turnNorth()
print("Current dir \(currentDirection)")
print("Copy dir \(copyDirection)")

enum Planet: Int, CaseIterable {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    
    func sayHello() {
        print("hello from \(self)")
    }
}

var myPlanet = Planet.earth
myPlanet = .mars // since the type is already known we can drop Planets

func matchPlanet(planet: Planet) {
    switch planet {
    case .earth:
        print("Hello humans")
    case .mars:
        print("Elon ?")
    case .mercury:
        print("too hot")
    case .jupiter:
        print("thank you big bro")
    default:
        print("Invalid planet")
    }
}

matchPlanet(planet: myPlanet)
matchPlanet(planet: .jupiter)

for planet in Planet.allCases {
    planet.sayHello()
}


enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 2134, 1234, 15)

func printBarcode(barcode: Barcode) {
    switch barcode {
    case .upc(let numberSystem, let manufacturer, let product, let check):
        print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
    case .qrCode(let productCode):
        print("QR code: \(productCode).")
    }
}

printBarcode(barcode: productBarcode)
printBarcode(barcode: .qrCode("qr"))


enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

let tab = ASCIIControlCharacter.tab

let earth = Planet.earth.rawValue

let mars = Planet(rawValue: 4)
mars?.sayHello()
