import Foundation

let input = """
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
"""

let rows = input.split(whereSeparator: \.isNewline)

var currentCol = 0
var rowLenght = rows[0].count
let treeSymbol = "#"

var currentRow = rows[0]

var treesEncountered = 0

func CreateCurrentRow(_ row: Substring, _ n: Int) -> Substring {
    var result = ""
    for _ in 0..<n{
       result += row
    }
    
    return Substring(result)
}


for (i, row) in rows.enumerated() {
    if i == 0 {
        continue
    }
    currentCol += 3
    
    if currentCol >= rowLenght {
        rowLenght = currentRow.count * 2
    }
    
    currentRow = CreateCurrentRow(row, rowLenght / row.count)
    let currentIndex = currentRow.index(currentRow.startIndex, offsetBy: currentCol)
    let symbol = currentRow[currentIndex]
    
    if String(symbol) == treeSymbol {
       treesEncountered += 1
    }
}


print(treesEncountered)
