# Fibonacci
The Fibonacci numbers are one our favorite sets. It's a sequence of numbers that been discovered multiple times, probably first in Ancient India, and introduced to Europeans by an Italian mathematician who gave the sequence its name in 1202. Fibonacci numbers are found all over mathematics, computer science, the natural world--most beautifully in the arrangement of a pine cone's scales.

![Pine Cone](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Pinus_coulteri_MHNT_Cone.jpg/471px-Pinus_coulteri_MHNT_Cone.jpg)

Fibonacci numbers are easy but expensive to calculate (if we skip over the first two). Here are the first 10:

| F0 | F1 | F2 | F3 | F4 | F5 | F6 | F7 | F8 | F9 |
|----|----|----|----|----|----|----|----|----|----|
|  0 |  1 |  1 |  2 |  3 |  5 |  8 | 13 | 21 | 34 |

Do you see the pattern?  After first two, the next Fibonacci number is the sum of the previous two!

Writing a computer program to calculate any given Fibonacci number is pretty easy but could create many calculations. If you want to find the 20th Fibonacci number you have to, at least calculate the preceeding 19. Another problem for computers is that Fibonacci numbers grow big fast (expoentially).

Given the characteristics of calculating Fibonacci numbers its a good idea to figure out the least expensive method (algorthm) to do so. But it's important to understand what "expensive" means in your context: The amopunt of calcuations? The time it takes to calcuate? The amount of memory it takes to calcuate? the amount of memory it takes to represent them? You computer envrionment has limits and calculating Fibonacci numbers will quickly help you slam into them.
