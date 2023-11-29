import Foundation

let add : (Int, Int) -> Int = { (lhs: Int, rhs: Int) -> Int in
  return lhs + rhs
}

add(1, 2)


func addative(_ step: Int) -> () -> Int {
    var sum = step
    
    let a : () -> Int = { () -> Int in
        sum += step
        return sum
    }
    
    return a
}

let add5 = addative(5)
add5()
add5()
add5()
add5()

func customAdd(
    _ lhs: Int,
    _ rhs: Int,
    using fn: (Int, Int) -> Int
) -> Int {
   return fn(lhs, rhs)
}

customAdd(10, 20, using: { (lhs: Int, rhs:  Int) -> Int in
    return lhs + rhs
})

// trailing closure syntax, only if the closure is in the last argument, weird ?
customAdd(10, 40) {(lhs: Int, rhs: Int) -> Int in
    return lhs + rhs
}

// this can work as well, but the compliler might be slowed down because of it
customAdd(10, 412) { (lhs, rhs) in
    return lhs + rhs
}

customAdd(10, 50) {
    return $0 + $1
}

customAdd(10, 12, using: add)


let ages = [10, 30, 20, 50]

print(ages)
let sorted = ages.sorted(by: {(lhs: Int, rhs: Int) -> Bool in
    lhs < rhs
})

print(sorted)

let sortedAgain = ages.sorted(by: {return $0 > $1})

print(sortedAgain)

let sortedBuildIn = ages.sorted(by: <)
print(sortedBuildIn)
