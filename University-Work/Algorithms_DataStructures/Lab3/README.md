# Algorithms and Data Structures Lab 3: Number Sequence Algorithms

## Project Overview
In this lab, I implement two algorithms in Java for generating a number sequence. The algorithms will calculate the next number in the sequence by summing the previous number and the number three places before it. The sequence always starts with `{ 0, 1, 2 }`, and for any `n < 0`, the result is `0`.

### Algorithms to Implement:
1. **NumberSequenceIterative.java**:
   - This implementation calculates the sequence iteratively using a loop.
   
2. **NumberSequenceRecursive.java**:
   - This implementation calculates the sequence recursively by calling the method itself.

### Sequence Definition:
The sequence is defined such that:
- For all `n < 0`, the result is `0`.
- The first three values are always `{ 0, 1, 2 }`.
- For `n >= 3`, the value at `n` is computed as the sum of the values at `n-1` and `n-3`.

For example, for `n = 6`, the sequence will be:
- `n(-1) = 0` (for all `n < 0`)
- `n(0) = 0` (start of the sequence)
- `n(1) = 1` (start of the sequence)
- `n(2) = 2` (start of the sequence)
- `n(3) = 2` (n(3) = n(2) + n(0) = 2 + 0)
- `n(4) = 3` (n(4) = n(3) + n(1) = 2 + 1)
- `n(5) = 5` (n(5) = n(4) + n(2) = 3 + 2)
- `n(6) = 7` (n(6) = n(5) + n(3) = 5 + 2)

### Task:
You are required to implement the number sequence algorithm in both iterative and recursive forms and ensure they work correctly with the help of `AlgoNumberSequence.java`.

### Empirical Results:
The following are the times measured for running the two algorithms with varying values of `n`:

- **NumberSequenceIterative**:
  - `n = 1,000,000,000`: 1,265 ms
  - `n = 1,250,000,000`: 1,443 ms
  - `n = 1,500,000,000`: 1,741 ms
  - `n = 1,750,000,000`: 2,198 ms
  - `n = 2,000,000,000`: 2,425 ms

- **NumberSequenceRecursive**:
  - `n = 40`: 14 ms
  - `n = 45`: 68 ms
  - `n = 50`: 505 ms
  - `n = 55`: 2,903 ms
  - `n = 60`: 24,070 ms

### Analysis:
- **Time Complexity**:
  Based on the empirical results, analyze the time complexity of each algorithm:
  - For **NumberSequenceIterative**, how does the time grow as `n` increases?
  - For **NumberSequenceRecursive**, what is the relationship between the input size `n` and the number of recursive calls? Consider drawing a diagram to illustrate the number of method calls.

- **Reasoning**:
  Is the time complexity for each algorithm reasonable based on your implementation? Discuss your reasoning and how the time grows with increasing `n`.

### Submission:
- Submit the following files:
  - `NumberSequenceIterative.java`
  - `NumberSequenceRecursive.java`
  - A PDF containing answers to the analysis questions.

### Evaluation Criteria:
Your submission will be evaluated based on the following:
- The task is submitted on time.
- Both algorithms function correctly.
- The implementation of the algorithms is reasonable based on the task description.
- The code is clear, well-structured, and easy to follow.
- All questions are answered, and the answers are well-supported and reasonable based on your implementation and the empirical data.
