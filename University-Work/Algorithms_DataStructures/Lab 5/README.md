# Algorithms and Data Structures Lab 5: Implementing Sorting Algorithms

## Project Overview
In this lab, I was required to implement four different sorting algorithms and analyze their performance. The algorithms to be implemented are:

1. **InsertionSort.java**
2. **DrakeSort.java**
3. **JavaAPISort.java**

The **QuickSort.java** class is already implemented, so no changes are needed to this file. For **JavaAPISort**, I was required to use Java's built-in sorting APIs rather than implementing my own sorting algorithm.

### Sorting Algorithms:

1. **InsertionSort**:
   - This algorithm sorts the array by iterating through it and moving elements into the correct position.
   - **Algorithm Steps**:
     - Start from `array[1]` to `array[length - 1]`.
     - Compare the current element with the previous ones.
     - If the current element is smaller than the previous one, move the larger element one step to the right.
     - Continue until the current element is not smaller than the previous one, and place the current element in the correct position.

2. **DrakeSort**:
   - This algorithm works by creating an array with a size equal to the difference between the maximum and minimum values in the collection plus one.
   - **Algorithm Steps**:
     - Find the largest and smallest numbers in the collection.
     - Create an array with a size of `(largest - smallest + 1)`.
     - Iterate over the collection, incrementing the count at the corresponding index in the array.
     - Create a new collection based on the sorted values using the counts.

3. **JavaAPISort**:
   - This is a simple implementation where you use Java's built-in sorting methods (`Arrays.sort` or similar) to sort the collection.

### Testing:
After implementing the sorting algorithms, you can test them using the `AlgoSorting.java` file. This file contains comments to guide you through the expected behavior and output of each algorithm.

### Empirical Data:
You will also need to analyze the empirical data for each algorithm to determine their time complexity:

#### InsertionSort Performance:
| n       | Time (ms) |
|---------|-----------|
| 80,000  | 845       |
| 160,000 | 3,463     |
| 240,000 | 7,511     |
| 320,000 | 13,394    |
| 400,000 | 21,467    |

#### DrakeSort Performance:
| n          | Time (ms) |
|------------|-----------|
| 40,000,000 | 273       |
| 80,000,000 | 475       |
| 120,000,000| 527       |
| 160,000,000| 784       |
| 200,000,000| 892       |

#### QuickSort Performance:
| n          | Time (ms) |
|------------|-----------|
| 40,000,000 | 3,035     |
| 80,000,000 | 6,321     |
| 120,000,000| 9,099     |
| 160,000,000| 12,950    |
| 200,000,000| 15,457    |

#### JavaAPISort Performance:
| n          | Time (ms) |
|------------|-----------|
| 8,000,000  | 2,033     |
| 16,000,000 | 3,600     |
| 24,000,000 | 8,122     |
| 32,000,000 | 10,088    |
| 40,000,000 | 17,423    |

### Analysis:
- Based on the empirical data, analyze the time complexity of each sorting algorithm:
  - **InsertionSort**: Analyze how the time grows with increasing `n`.
  - **DrakeSort**: Investigate how the time complexity compares to the size of the dataset.
  - **QuickSort**: Look at its performance compared to the others.
  - **JavaAPISort**: Consider how Java's built-in sorting methods compare.

- For **InsertionSort** and **DrakeSort**, discuss whether the empirical results match the expected theoretical time complexity. 

### Submission:
- Submit the following files:
  - `InsertionSort.java`
  - `DrakeSort.java`
  - `JavaAPISort.java`
  - `AlgoSorting.java` (for testing)
  - A PDF file with your analysis and answers to the questions regarding the time complexity of each algorithm.

### Evaluation Criteria:
Your submission will be evaluated based on the following:
- Correct implementation of each sorting algorithm.
- Efficiency and performance of the algorithms as observed from the empirical data.
- Clear reasoning behind the time complexity analysis.
- Well-structured and readable code.
- Answers to the questions about time complexity are well-motivated and reasonable based on the empirical data.
