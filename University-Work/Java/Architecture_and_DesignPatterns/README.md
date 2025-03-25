# Observer Pattern Implementation - Architecture and Design Patterns

## Overview
This project was completed as part of the **Architecture and Design Patterns** course. The assignment required implementing the **Observer pattern** in a given project **without using Java's built-in observer utilities**. Additionally, the implementation needed to follow either the **push or pull methodology**, which was analyzed and explained as part of the solution.

## Assignment Instructions
The task involved:
1. Implementing the **Observer pattern** into an existing project.
2. Ensuring a proper **separation of concerns** in the code structure.

## Implementation Details
- The **Observer pattern** was manually implemented using **custom interfaces and classes**.
- The **Subject (Observable)** maintains a list of **Observers** and notifies them when state changes.
- Observers **register/unregister** dynamically and receive updates from the Subject.
- The given codebase was **extended** while maintaining the original structure and adhering to **design principles**.

## Key Components
- **Subject (Observable):** Maintains a list of observers and notifies them of changes.
- **Observer:** Receives updates from the subject when changes occur.
- **Concrete Implementations:** Specific classes that extend the observer pattern logic.

## Notes
- **Java's native observer utilities** were **not** used as per the assignment restrictions.
- The design follows **object-oriented principles** to ensure modularity and maintainability.

---

This project serves as a demonstration of **manual Observer pattern implementation** and its application in **design patterns and software architecture**.
