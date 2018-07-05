# Fibonacci
The Fibonacci numbers are one our favorite sets. It's a sequence of numbers that been discovered multiple times, probably first in Ancient India, and introduced to Europeans by an Italian mathematician who gave the sequence its name in 1202. Fibonacci numbers are found all over mathematics, computer science, the natural world--most beautifully in the arrangement of a pine cone's scales.

![Pine Cone](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Pinus_coulteri_MHNT_Cone.jpg/471px-Pinus_coulteri_MHNT_Cone.jpg)

Fibonacci numbers are easy but expensive to calculate (if we skip over the first two). Here are the first 10:

| F0 | F1 | F2 | F3 | F4 | F5 | F6 | F7 | F8 | F9 |
|----|----|----|----|----|----|----|----|----|----|
|  0 |  1 |  1 |  2 |  3 |  5 |  8 | 13 | 21 | 34 |

Do you see the pattern?  After first two, the next Fibonacci number is the sum of the previous two!

Writing a computer program to calculate any given Fibonacci number is pretty easy but could create many calculations. If you want to find the 20th Fibonacci number you have to, at least calculate the preceding 19. Another problem for computers is that Fibonacci numbers grow big fast (exponentially).

Given the characteristics of calculating Fibonacci numbers its a good idea to figure out the least expensive method (algorithm) to do so. But it's important to understand what "expensive" means in your context: The amount of calculations? The time it takes to calculate? The amount of memory it takes to calculate? the amount of memory it takes to represent them? You computer environment has limits and calculating Fibonacci numbers will quickly help you slam into them. This is why Fibonacci numbers are fun to play with.

## Fib2.playground

I created a Swift Playground to discover the best way to calculate Fibonacci numbers in Xcode and macOS. Spoiler Alert! None of these are the "best way". The actual best way is not to calculate Fibonacci numbers at all, just copy them from somewhere else and paste them into an array for easy look up! This is called caching or pre-calculation and since Fibonacci numbers are eternal you have have to worry about updates. But what you learn by playing with Fibonacci numbers can be used in other cases so this playground is not a total waste of time.

The playground is fully documented and just requires Xcode 10 and Swift 4.1 to run.
