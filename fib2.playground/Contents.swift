import Foundation

/// Demos of different ways to calculate Fibonacci numbers
/// and how efficent they might be.
///
/// A Fibonacci number is part of a sequence that starts with
/// [1,1] and continues such that the next number is the sum of
/// previous two: [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, ...]
class Fibonacci {
    
    enum CalcStyle {
        case shuffle, recursive, memoized, bottomsup
    }
    
    var previousValues = [Int]()
    
    /// Calcuates a fibonacci number using one of three methods
    ///
    /// - Parameters:
    ///   - nth: which fibonacci number to calculate
    ///   - style: Which algorthm to use: recursive, memoized, bottomsup
    /// - Returns: A tuple that includes the fibonacci number calcuated and how many seconds the method spent
    func calc(nth: Int, style: CalcStyle) -> (fibNumber: Int, timing: Double) {
        var foundValue = 0
        var timing = 0.0
        previousValues = [Int](repeating: 0, count: nth + 1)
        
        let startTime = Date()
        
        switch style {
            
        case .shuffle:
            foundValue = shuffle(nth)
        case .recursive:
            foundValue = recursive(nth)
        case .memoized:
            foundValue = memoized(nth)
        case .bottomsup:
            foundValue = bottomsup(nth)
        }
        
        let endTime = Date()
        timing = endTime.timeIntervalSince(startTime)
        
        return (foundValue, timing)
    }
    
    /// Calcuates a fibonacci number via shuffling values with a `temp` varliable
    ///
    /// - Parameter position: position: which fibonacci number to calculate
    /// - Returns: the fibonacci number calucated
    func shuffle(_ position: Int) -> Int {
        
        if position <= 1 {
            return position
        }
        
        var a = 1
        var b = 1
        
        for _ in 2..<position {
            let temp = a
            a += b
            b = temp
        }
        
        return a
    }
    
    /// Calcuates a fibonacci number via naive recursion
    ///
    /// - Parameter position: which fibonacci number to calculate
    /// - Returns: the fibonacci number calucated
    func recursive(_ position: Int) -> Int {
        var value = 0

        
        if position == 1 || position == 2 {
            
            value = 1
        } else {
            
            value = recursive(position - 1) + recursive(position - 2)
        }
        
        return value
    }
    
    
    /// Calcuates a fibonacci number via memoized recursion
    ///
    /// - Parameter position: which fibonacci number to calculate
    /// - Returns: the fibonacci number calucated
    func memoized(_ position: Int) -> Int {
        var value = 0
        
        if previousValues[position] != 0 {
            return previousValues[position]
        } else {
            if position == 1 || position == 2 {
                
                value = 1
            } else {
                
                value = memoized(position - 1) + memoized(position - 2)
            }
        }
        previousValues[position] = value
        return value
    }
    
    /// Calcuates a fibonacci number via bottoms up algorithm
    ///
    /// - Parameter position: which fibonacci number to calculate
    /// - Returns: the fibonacci number calucated
    func bottomsup(_ position: Int) -> Int {
        
        if position == 1 || position == 2 {
            
            return 1
            
        } else {
            
            previousValues[1] = 1
            previousValues[2] = 1
            
            for i in 3...position {
                
                previousValues[i] = previousValues[i-1] + previousValues[i-2]
            }
            
            return previousValues[position]
        }
    }
}

let searchIndex = 20
let fib = Fibonacci()
var analysis = [String:Double]()

var (fibNumber, timing) = fib.calc(nth: searchIndex, style: .shuffle)
print("Shuffle() found that the \(searchIndex)th fibonacci number is \(fibNumber) ")
analysis["shuffle"] = timing


(fibNumber, timing) = fib.calc(nth: searchIndex, style: .recursive)
print("Recursive() found that the \(searchIndex)th fibonacci number is \(fibNumber) ")
analysis["recursive"] = timing

// fib(10) = fib(9) + fib(8)
// fib(9)  = fib(8) + fib(7)
// fib(8)  = fib(7) + fib(6)
// fib(7)  = fib(6) + fib(5)
// fib(6)  = fib(5) + fib(4)
// fib(5)  = fib(4) + fib(3)
// fib(4)  = fib(3) + fib(2)
// fib(3)  = fib(2) + fib(1)
// fib(2)  = 1
// fib(1)  = 1
// fib(2)  = 1
// fib(3)  = 1  + 1  = 2
// fib(4)  = 2  + 1  = 3
// fib(5)  = 3  + 2  = 5
// fib(6)  = 5  + 3  = 8
// fib(7)  = 8  + 5  = 13
// fib(8)  = 13 + 8  = 21
// fib(9)  = 21 + 13 = 34
// fib(10) = 34 + 21 = 55

(fibNumber, timing) = fib.calc(nth: searchIndex, style: .memoized)
print("Memoized() found that the \(searchIndex)th fibonacci number is \(fibNumber) ")
analysis["memoized"] = timing


(fibNumber, timing) = fib.calc(nth: searchIndex, style: .bottomsup)
print("ButtomsUp() found that the \(searchIndex)th fibonacci number is \(fibNumber) ")
analysis["bottomsup"] = timing

print("\(fib.previousValues)")

let analysisSorted = analysis.sorted(by: {$0.value < $1.value} )
for item in analysisSorted {
    print("\(String(format: "%.10f", item.value)) \(item.key)")
}


