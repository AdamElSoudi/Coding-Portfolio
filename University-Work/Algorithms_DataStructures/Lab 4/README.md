# Algorithms and Data Structures Lab 4: Using TreeMap

## Project Overview
In this lab, the task was implementing methods in the `TreeMapHandler` class to manage and retrieve data from a `TreeMap`. The lab involves working with a collection of key-value pairs stored in a `TreeMap` and implementing several methods that interact with the map.

### Methods to Implement:
1. **createTreeMap**:
   - This method should create a `TreeMap` and populate it with the keys and values from an array of `Entry` objects provided as a parameter. 
   - If there are multiple objects with the same key, the first value should be inserted, and subsequent occurrences of the same key should not replace the existing value.

2. **retrieve (with keys as a parameter)**:
   - This method should retrieve values associated with the provided keys and store them in a new `Map` with the same keys.
   - Try to optimize this method by checking for sequences of keys so that you can retrieve a subtree instead of retrieving each node individually.

3. **retrieve (with start and end keys as parameters)**:
   - This method should retrieve a subtree of keys and values between the two provided keys, inclusive of the start and end keys.

4. **retrieveAllKeys**:
   - This method should retrieve all the keys in the `TreeMap`.

5. **retrieveAllValues**:
   - This method should retrieve all the values in the `TreeMap`.

### Testing:
Once you have implemented the methods, you can test them for correctness using the `AlgoTreeMap.java` file. This file contains comments explaining what each method is supposed to do and the expected output for various inputs.

### Submission:
- Submit the following files:
  - `TreeMapHandler.java` (your implementation file)
  - `AlgoTreeMap.java` (the provided file for testing)

### Evaluation Criteria:
Your submission will be evaluated based on the following:
- Correct implementation of all the methods.
- Efficient and well-optimized code, especially for the `retrieve` methods.
- Proper use of the `TreeMap` and handling of edge cases (e.g., duplicate keys, invalid keys).
- The code is well-structured, clear, and easy to understand.
- The methods function correctly when tested with the provided test file.
