import Foundation

var input = """
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
"""

let passwords = input
    .split(whereSeparator: \.isNewline);


func NumberOfCharacters(_ password: String, _ symbol: Character) -> Int {
    var counter = 0
    for letter in password {
        if letter == symbol {
            counter += 1
        }
    }
    
    return counter
}

func IsValid(_ password: String, _ symbol: Character, _ firstIndex: Int, _ secondIndex: Int) -> Bool {
    let firstLetterIndex = password.index(password.startIndex, offsetBy: firstIndex - 1)
    let secondLetterIndex = password.index(password.startIndex, offsetBy: secondIndex - 1)
    
    
    print(password, firstIndex, password[firstLetterIndex])
    print(password, secondIndex, password[secondLetterIndex])
    
    if password[firstLetterIndex] == symbol && password[secondLetterIndex] == symbol {
        return false
    } else if password[firstLetterIndex] != symbol && password[secondLetterIndex] != symbol {
        return false
    }
    
    return true
}

var validPasswords = 0
for entry in passwords {
    let inputParts = entry.split(separator: " ")
    
    let minMax = inputParts[0].split(separator: "-").map{Int($0)!}
    let min = minMax[0]
    let max = minMax[1]
    
    let letter = inputParts[1].dropLast()
    let password = inputParts[2]
    
    let valid = IsValid(String(password), Character(String(letter)), min, max)
    if valid {
        print(password)
        
        validPasswords += 1
    }
}

print(validPasswords)

