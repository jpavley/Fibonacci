import Foundation

//: # Fibonacci Playground
//: Demos of different ways to calculate Fibonacci numbers and how efficent they might be.
//:
//: A Fibonacci number is part of a sequence that starts with [1,1] and continues such that the next number is the sum of previous two: [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, ...]
//:
//: The Fibonacci numbers is one of our favorite sets. It's a sequence of numbers that been discovered multiple times, probably first in Ancient India, and introduced to Europeans by an Italian mathematician who gave the sequence its name in 1202 C.E. Fibonacci numbers are found all over mathematics, computer science, the natural world--most beautifully in the arrangement of a pine cone's scales.
//:
//: Fibonacci numbers are easy but expensive to calculate (if we skip over the first two). Here are the first 10:
//:
//:      +----|----|----|----|----|----|----|----|----|----+
//:      | F0 | F1 | F2 | F3 | F4 | F5 | F6 | F7 | F8 | F9 |
//:      |----|----|----|----|----|----|----|----|----|----|
//:      |  0 |  1 |  1 |  2 |  3 |  5 |  8 | 13 | 21 | 34 |
//:      +----|----|----|----|----|----|----|----|----|----+
//:
//: Do you see the pattern?  After first two, the next Fibonacci number is the sum of the previous two!
//:
//: Writing a computer program to calculate any given Fibonacci number is pretty easy but could create many calculations. If you want to find the 20th Fibonacci number you have to, at least calculate the preceding 19. Another problem for computers is that Fibonacci numbers grow big fast (exponentially).
//:
//: Given the characteristics of calculating Fibonacci numbers its a good idea to figure out the least expensive method (algorithm) to do so. But it's important to understand what "expensive" means in your context: The amount of calculations? The time it takes to calculate? The amount of memory it takes to calculate? the amount of memory it takes to represent them? You computer environment has limits and calculating Fibonacci numbers will quickly help you slam into them. This is why Fibonacci numbers are fun to play with.
//:
//: For much more info check out this Wikipedia article on [Fibonacci Numbers](https://en.wikipedia.org/wiki/Fibonacci_number)

//: ## Fibonacci class
//: Read over the plass and then jump to the bottom to see how to use it to calculate your favorite Fibonacci number.

/// A class that will help us explore differnt algorthms and measure their efficency at calculating Fibonacci numbers.
class Fibonacci {

    /// Enunumeration of different methods for calculating Fibonacci numbers. Used to choose a particular method "on demand" in the calc(::) function.
    ///
    /// - shuffle: Old school use of temp variable to "shuffle" calcuated values in side a loop. Old school because this was how we did it before modern compilers supported recursive functions.
    /// - recursive: Modern use of a function that calls itself to repeatedly calcuate a value. Great way to impress your coder friends.
    /// - memoized: Improves the efficiency of the recursive method by storing calcuations for look up as needed. Redeems recursion a bit.
    /// - bottomsup: Here we chuck out recursion in favor of just remembering the previously calucated values. Think of it as shuffle with memoization.
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

let fib = Fibonacci()
var analysis = [String:Double]()

let searchIndex: Int = 10

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


