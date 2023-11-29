import Foundation

func Test(external firstName: String, secondName: String, age : Int = 20) -> String {
    "\(firstName.capitalized) \(secondName.capitalized)"
}

let result = Test(external: "svetlin", secondName: "Mladenov")

