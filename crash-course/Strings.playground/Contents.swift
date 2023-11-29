import Foundation

var greeting = "Hello, playground"

print(greeting.capitalized)

extension String {
    func deletePreffix(_ prefix : String) -> String {
        if self.hasPrefix(prefix) {
            return String(self.dropFirst(prefix.count))
        }
        
        return self
    }
    
    func deleteSuffix(_ suffix : String) -> String {
        guard self.hasSuffix(suffix) else {
            return self
        }
        
        return String(self.dropLast(suffix.count))
    }
}


var test = "asdfsvetlinasdf"
test = test.deletePreffix("asdf")
test = test.deleteSuffix("asdf")

let myName = "svetlin"

print(myName.capitalized)

