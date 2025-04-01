 # Decorator Pattern – Text Inserter

## Overview

This project was developed as part of the **Architecture and Design Patterns** course. The goal of the lab was to enhance an existing Java desktop application using the **Decorator design pattern**. The application allows users to input a message and save it to a `.txt` file—but now with optional text transformations applied before saving.

## Objective

To prevent sensitive messages from being easily read, the app was extended to include **encoders** that modify the message text. These encoders are applied dynamically using checkboxes in the UI and are implemented using the Decorator pattern, allowing for scalable and modular text modification functionality.

## Features

- **Base Functionality:** Write a message and save it to a file (`Insert to file`).
- **Text Encoders (via checkboxes):**
  - **Base64 Encoding**
  - **Rövarspråket** (a Swedish "Robber’s Language" encoding)
  - **Super Implementation** (custom, creative encoding logic)
- **Dynamic Composition:** Encoders can be combined and stacked in any order using decorators.

## Design Pattern: Decorator

The **Decorator Pattern** allows behavior to be added to individual objects without affecting the behavior of other objects from the same class. In this project, it’s used to dynamically add one or more encoders to the message handler chain before writing to file.

### Example Structure:

- `TextWriter` (interface)  
- `PlainTextWriter` (base implementation)  
- `Base64Decorator`, `RovarspraketDecorator`, `SuperDecorator` (decorators)

Each decorator wraps another `TextWriter` and applies its transformation logic.

## How It Works

1. The user types a message in the input field.
2. The user selects one or more encoders via checkboxes.
3. When `Insert to file` is clicked:
   - A `TextWriter` chain is built using the selected decorators.
   - The message is passed through the chain, with each decorator applying its logic.
   - The final result is saved to a text file.

## Open/Closed Principle (OCP)

This solution aligns with the **Open/Closed Principle**, one of the SOLID design principles:

> **Software entities should be open for extension, but closed for modification.**

- The base writing logic does not need to be changed to add new encoders.
- Each encoder is implemented as a separate decorator class.
- Adding a new encoder simply requires creating a new decorator class that implements the same interface—no changes to existing logic.

## Technologies Used

- Java
- JavaFX (GUI)
- Decorator Design Pattern
- Standard Java I/O
- Base64 encoding from `java.util.Base64`

## Example

- Input: `Hello`
- Base64 Encoder: `SGVsbG8=`
- Rövarspråket Encoder: `HoHelollolo`
- Super Encoder (custom): Depends on your implementation logic.

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/AdamElSoudi/Coding-Portfolio.git
   ```
2. Navigate to the project:
```bash
cd Coding-Portfolio/University-Work/Java/Architecture_and_DesignPatterns/Decorator_Pattern/Lab\ 2\ -\ Decorator\ Pattern
```
3. Open in IntelliJ IDEA or another Java IDE.

4. Run the application.

5. Type a message, select encoders, and click Insert to file.

## Disclaimer
This application was created for educational purposes as part of a university assignment and is not intended for production use.
