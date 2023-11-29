import Foundation

let input = """
1721
979
366
299
675
1456
"""

let newLineChars = input
    .split(whereSeparator: \.isNewline);


let numbers = newLineChars.map{ Int($0)! }

for (index, num) in numbers.enumerated() {
    for (innerIndex, inner) in numbers.dropFirst(index).enumerated() {
        for innerMost in numbers.dropFirst(index + innerIndex) {
            let sum = num + inner + innerMost
            if sum == 2020 {
                print(num * inner * innerMost)
                break;
            }
        }
    }
}
