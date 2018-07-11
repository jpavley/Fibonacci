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

/// A class that will help us explore differnt algorthms and measure their efficency at calculating Fibonacci numbers. Remember you can option-click on a name and get it's documentation in a popup!
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
    
    
    /// An array to store all the previous Fibonacci number's calcuated. Storage for the methods that use memoization.
    var previousValues = [Int]()
    
    /// Calcuates a Fibonacci number using one of four methods and reports how long it took.
    ///
    /// - Parameters:
    ///   - nth: which Fibonacci number to calculate.
    ///   - style: Which algorthm to use: recursive, memoized, bottomsup.
    /// - Returns: A tuple that includes the fibonacci number calcuated and how many seconds the method spent.
    func calc(nth: Int, style: CalcStyle) -> (fibNumber: Int, timing: Double) {
        
        /// The result of all this calculation.
        var foundValue = 0
        
        /// How long it took to do the calculating.
        var timing = 0.0
        
        previousValues = [Int](repeating: 0, count: nth + 1) // Make the previous values Array just large enough to store all the numbers from 0th upto and including the nth. All the elements are initialized to 0 as signal that we have not calcuated a value for each index as of yet.
        
        /// Punch the clock! Remember when we started!
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
        
        
        /// Punch the clock again! Remember when we got a value back!
        let endTime = Date()
        
        timing = endTime.timeIntervalSince(startTime) // In iOS a TimeInterval is the number of seconds, with the percision of a Double.
        
        return (foundValue, timing) // return both the nth Fibonacci number and the duration of calcuation!
    }
    
    /// Calcuates a Fibonacci number via shuffling values with a `temp` varliable.
    ///
    /// - Parameter position: which Fibonacci number to calculate.
    /// - Returns: the fibonacci number calucated.
    func shuffle(_ position: Int) -> Int {
        
        
        if position <= 1 { // We know that the 0th and 1st Fibonacci numbers are 1.
            return position
        }
        
        /// Currently calcuated Fibonacci number.
        var a = 1
        
        /// Previously calcuated Fibonacci number.
        var b = 1
        
        /// Varible to temporarily hold the current calcuated Fibonacci number so that it can be passed on to `b` after `a` is updated with a new Fibonacci number.
        var temp = 0
        
        for _ in 2..<position { // Loop from the 2nd position to the desired postion (the nth).
            temp = a  // Store the current value of most recently calcuated Fibonacci number in `temp`.
            a += b    // Add the previous Fibonacci number to the most recent value. F = (F-1) + (F-2).
            b = temp  // Store the value of the old `current Fibonacci number` in `b` so we can add it to a future `a`.
        }
        
        return a // When the loop is done we have the Fibonacci number that was asked for!
    }
    
    /// Calcuates a Fibonacci number via naive recursion.
    ///
    /// Recursion starts from the end and works backwards.
    ///
    /// Cost: O(n) space, O(n) time
    ///
    /// - Parameter position: which Fibonacci number to calculate.
    /// - Returns: the Fibonacci number calucated.
    func recursive(_ position: Int) -> Int {
        
        /// A variable to store the calcuated Fibonacci numbers.
        var value = 0

        if position <= 2 { // We know that the 0th, 1st, and 2nd Fibonacci numbers are 1.
            
            value = 1
        } else {
            
            value = recursive(position - 1) + recursive(position - 2) // Call this function again and again until we get the value asked for! See below for how this recursion works!
        }
        
        return value // When all the recursion is done the result is the nth Fibonacci number.
    }
    
    
    /// Calcuates a Fibonacci number via memoized recursion.
    ///
    /// Memonization keeps a record of results so no values are calcuated more than once.
    ///
    /// Cost: O(1) space, O(1) time
    ///
    /// - Parameter position: which Fibonacci number to calculate
    /// - Returns: the Fibonacci number calucated
    func memoized(_ position: Int) -> Int {
        
        /// A variable to store the calcuated Fibonacci numbers.
        var value = 0
        
        if previousValues[position] != 0 {  // Remember that `0` is a signal that means a Fibonacci number has not been calcuated for this position (index).
            
            return previousValues[position] // If we have any other value besides '0' we can return it and declare that we are done!
            
        } else { // The Fibonacci number for this position in the Array has not been calculated yet...
            
            if position <= 2 { // We know that the 0th, 1st, and 2nd Fibonacci numbers are 1.
                
                value = 1
            } else {
                
                value = memoized(position - 1) + memoized(position - 2) // Call this function again and again until we get the value asked for! It the same method (algorthm) as the recursive(:) function above! Rember that F = (F-1) + (F-2).
            }
        }
        
        previousValues[position] = value // Save the calcuated Fibonacci number for this position so we don't have to calcuated it again--this is the secret of memoization!
        
        return value // When all the recursion is done the result is the nth Fibonacci number.
    }
    
    /// Calcuates a Fibonacci number via a memoized bottoms-up algorithm.
    ///
    /// Bottoms up starts from the beginning and works forwards. Memonization keeps a record of results so no values are calcuated more than once.
    ///
    /// Cost: O(1) space, O(1) time.
    ///
    /// - Parameter position: which Fibonacci number to calculate.
    /// - Returns: the Fibonacci number calucated.
    func bottomsup(_ position: Int) -> Int {
        
        if position <= 2 { // We know that the 0th, 1st, and 2nd Fibonacci numbers are 1.
            
            return 1 // No need to memoize the ressult, just return 1. This way is the fastist!
            
        } else {
            
            previousValues[1] = 1 // The 1st Fibonacci number is 1.
            previousValues[2] = 1 // The 2nd Fibonacci number is 2.
            
            for i in 3...position { // Loop from the 3nd position to the desired postion (the nth).
                
                previousValues[i] = previousValues[i-1] + previousValues[i-2] // Store the result of calcuating this Fibonacci number from the previous two: F = (F-1) + (F-2).
            }
            
            return previousValues[position] // And we're done. No recursion here!
        }
    }
}

//: ## Using the Fibonacci Class

//: To calucate Fibonacci numbers we need to create an instance of the `Fibonacci Class`.
let fib = Fibonacci()

//: And we need a place to store the timing results so we can compare them. A great way to do this is to use a Dictionary with the name of the method the key and the duration of the calcuation as the value. This way we can look up results by how they were created and sort the results by how long they took.
var analysis = [String:Double]()

//: Calcuating Fibonacci numnbers can be expensive in terms of time and computer resources (like memory). We use a variable to make sure each instance is using the same value to search for. `25` ia good value to use. Below `25` and the different methods of calcuation are almost equally fast. Higher than `25` and your computer might spend minuets or hours calcuating or more likely run out of memory.
let searchIndex: Int = 25

//: Now we're ready to calcuate our first Fibonacci number! Let's try the `shuffle` method first. We'll print the result and add how long it took to the `analysis` Dictonary.
var (fibNumber, timing) = fib.calc(nth: searchIndex, style: .shuffle)
print("Shuffle() found that the \(searchIndex)th fibonacci number is \(fibNumber)")
analysis["shuffle"] = timing

//: How does `shuffle` work? Let's follow it step by step for the 3rd Fibonacci number.
//:
//: First time around the loop (we start by calcuating the 2nd Fibonacci number)
//: - `a` starts with the value of 1
//: - `b` starts with the value of 1
//: - `temp` is set equal to `a` so `temp` now equals 1
//: - `a` is set equal to the sum of `a` + `b` so `a` now equals 2
//: - `b` is set equal to `temp` so `b` now equals 1
//:
//: Second time around the loop (calcuating the 3rd Fibonacci number)
//: - `a` starts with the value of 2
//: - `b` starts with the value of 1
//: - `temp` is set equal to `a` so `temp` now equals 2
//: - `a` is set equal to the sum of `a` + `b` so `a` now equals 3
//: - `b` is set equal to `temp` so `b` now equals 2
//:
//: By now you can see that the value of `a` shuffles through `temp` to become the value of `b` at the end of the each turn though the loop. The value of `a` is always updated inside each turn of the loop to be the current Fibonacci number: F = (F-1) + (F-2). Shuffle is one of the slower methods of calculating Fibonacci numbers, T(n) = O(n), but only uses a fixed about of space, S(n) = O(1).



(fibNumber, timing) = fib.calc(nth: searchIndex, style: .recursive)
print("Recursive() found that the \(searchIndex)th fibonacci number is \(fibNumber)")
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
print("Memoized() found that the \(searchIndex)th fibonacci number is \(fibNumber)")
analysis["memoized"] = timing


(fibNumber, timing) = fib.calc(nth: searchIndex, style: .bottomsup)
print("ButtomsUp() found that the \(searchIndex)th fibonacci number is \(fibNumber)")
analysis["bottomsup"] = timing

print("previousValues \(fib.previousValues)")

let analysisSorted = analysis.sorted(by: {$0.value < $1.value} )
for item in analysisSorted {
    print("\(String(format: "%.10f", item.value)) \(item.key)")
}


