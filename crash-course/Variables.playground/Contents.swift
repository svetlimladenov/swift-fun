import Foundation

let test = 1

// arrays are by value
var arr = [
    "test",
    "test2"
]

var copy = arr

copy.append("baz")

print(copy)
print(arr)

let oldArray = NSMutableArray(array: ["Foo", "bar"])

func testMutable(array :NSMutableArray, text: String) {
    array.add(text)
}

testMutable(array: oldArray, text: "opata")

print(oldArray)


func testRegularArray(array: [String]) {
//    array[0] = 1
}

testRegularArray(array: arr)

print(arr)
