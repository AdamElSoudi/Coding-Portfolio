# Final Project: Weather Data Analysis

## Project Overview

In this project, I was tasked with analyzing temperature data from the Visby Airport weather station for the period 1946-01-01 to 2020-12-31. I had to load, structure, and analyze the data using appropriate data structures and algorithms.

The provided data files are:

- **smhi-opendata.csv**: Contains temperature data from the weather station.
- **legend-smhi-opendata.txt**: Describes the structure and format of the data in the CSV file.
- **algo_weatherdata.zip**: Contains several classes for an unfinished program that will analyze the weather data. You are required to finish the implementation in the `WeatherDataHandler.java` class.

### Requirements:
1. **Choose a suitable data structure** for storing the weather data.
2. **Implement algorithms** in `WeatherDataHandler.java` to analyze the data efficiently.
3. Focus on **low time complexity**, aiming for an efficient solution with preferably linear time complexity (O(n)).
4. **Ensure robustness**, such that the program does not crash when querying dates that do not exist in the data.
5. **Create a modular solution**, organizing the code into classes and methods to make future development easier.

## Tasks:

1. **Data Structure Selection:**
   - Choose an appropriate data structure to store the weather data. You should consider options such as:
     - **List**: Good for simple, ordered collections but might not be efficient for searching.
     - **Tree**: Suitable for ordered data and efficient searching but may involve more complexity in implementation.
     - **Hashed Structure (HashMap, HashSet)**: Ideal for fast lookups, especially if querying based on a specific key like date or temperature value.

2. **Implementation of Algorithms:**
   - Complete the unfinished methods in `WeatherDataHandler.java` as described by the comments in the file.
   - Consider the choice between **iterative** or **recursive** solutions.
   - Explore possible design techniques such as:
     - **Greedy Algorithms**: Choosing the best option at each step.
     - **Divide and Conquer**: Breaking down the problem into smaller subproblems.
     - **Dynamic Programming**: Using previously computed results to solve overlapping subproblems efficiently.

3. **Performance Considerations:**
   - Ensure your algorithms have an efficient time complexity. The total number of data points in the file is approximately 533,000, so the time complexity should be close to O(n) or O(n log n) for most operations.

## Report

In the report, you should answer the following questions:

1. **Which data structure did you choose and why?**
   - Explain your choice of data structure (e.g., List, Tree, HashMap).
   - Discuss how the choice of data structure affects the efficiency of your algorithms.
   - How would the time complexity change if you had chosen a different data structure?

2. **How did you implement your algorithms and why?**
   - Did you use an iterative or recursive approach?
   - Explain the design techniques you used, such as greedy, divide and conquer, or dynamic programming.
   
3. **What is the time complexity of your algorithms?**
   - Estimate the time complexity of your algorithms in terms of the total number of data points (n = 533,000).
   - Provide reasoning for your time complexity analysis.

### Submission:
- Submit the following files:
  - `WeatherDataHandler.java` with the completed implementation.
  - Any additional classes or methods you created.
  - Your report answering the questions above.

### Evaluation Criteria:
- Correct implementation of data structure and algorithms.
- Efficiency and performance of the solution.
- Well-reasoned analysis of the chosen data structures and algorithms.
- Clean, modular, and readable code.
