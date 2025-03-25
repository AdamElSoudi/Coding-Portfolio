# Algorithms and Data Structures Lab 1: Multiply Algorithms

## Project Overview
In this lab, the task is to implement two algorithms in the `Multiplier.java` class. The algorithms will process a list of numbers and compute sums based on specific multiplication rules. The two methods to be implemented are `multiplySome` and `multiplyAll`.

### Tasks:
1. **multiplySome**:
   - In this method, the first and last elements of a list are multiplied, then the second and second-to-last, and so on. The results of these multiplications are then summed into a variable `sum`.
   - For example, for the list `{ 0, 1, 2, 3, 4, 5 }`, the following operations occur:
     - `0 * 5 = 0`
     - `1 * 4 = 4`
     - `2 * 3 = 6`
   - The sum for the list will be `0 + 4 + 6 = 10`.

2. **multiplyAll**:
   - In this method, every element in the list multiplies with all other elements, and the results are summed into a variable `sum`.
   - For example, for the list `{ 0, 1, 2, 3 }`, the following operations occur:
     - `0 * 1 = 0`
     - `0 * 2 = 0`
     - `0 * 3 = 0`
     - `1 * 2 = 2`
     - `1 * 3 = 3`
     - `2 * 3 = 6`
   - The sum for the list will be `0 + 0 + 0 + 2 + 3 + 6 = 11`.

### Key Details:
- The primary goal of this assignment is to create algorithms that work according to the description, and not necessarily the most optimized solution. The focus is on understanding algorithmic concepts and correct implementation.
- It will test the algorithms using `AlgoMultiplySmallSize.java`, which calls the algorithms with smaller data structures to ensure they work correctly. The file also contains comments describing the expected output for different list sizes.

### Implementation Instructions:
- Download the `algo_multiply.zip` file, which contains various classes. You only need to work with the `Multiplier.java` class.
- In the methods `multiplySome` and `multiplyAll`, there are comments indicating where you need to write your code.
- Use the other provided classes to check if your algorithms are implemented correctly.

### Technologies Used:
- **Java**: The assignment is implemented using Java, and I modify and work within the `Multiplier.java` class.

### Example of Expected Output:
- For `multiplySome` with `{ 0, 1, 2, 3, 4, 5 }`, the result should be `10`.
- For `multiplyAll` with `{ 0, 1, 2, 3 }`, the result should be `11`.

### Goal:
The main objective is to understand and implement basic algorithms that follow specific multiplication rules, reinforcing the concepts of algorithms and data structures in Java.
