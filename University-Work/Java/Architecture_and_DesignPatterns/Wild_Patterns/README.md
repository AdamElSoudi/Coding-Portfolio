# Wild Patterns Chat Application

## Overview

The **Wild Patterns Chat Application** is a Java-based desktop chat client developed as part of a university course on Architecture and Design Patterns. The application aims to simulate a nostalgic chat experience for older users and was designed to demonstrate the use of robust software architecture principles and design patterns.

## Features

- **Dynamic Protocol Switching** – Change between UDP and WebSocket communication at runtime using radio buttons.
- **Decoupled Architecture** – Implements an Observer pattern to separate concerns and improve modularity.
- **Flexible Logging System** – Chat messages and errors are logged to the console with timestamps, with the logging system designed for future extensibility.

## Design Patterns Implemented

| Pattern    | Purpose                                                                  |
|------------|--------------------------------------------------------------------------|
| Strategy   | Dynamically switch between UDP and WebSocket communication protocols     |
| Observer   | Allow components to react to communication events without tight coupling |
| Singleton  | Ensure a single shared logging instance throughout the application       |

## How to Run

1. Clone the repository:
```bash
git clone https://github.com/AdamElSoudi/Coding-Portfolio.git
```

2. Navigate to the project:
```bash
cd Coding-Portfolio/University-Work/Java/Architecture_and_DesignPatterns/Wild_Patterns/Lab\ 3\ -\ Wild\ Patterns/WILD
```
3. Open the project in IntelliJ IDEA or another Java IDE.

4. Run the application **twice** to simulate two chat windows.

5. Use the radio buttons to switch between UDP and WebSocket protocols.

## How It Works

### Strategy Pattern
Used to dynamically switch between `UDPChatCommunicator` and `WebSocketCommunicator`. The `ChatCommunicator` interface allows the controller to change communication logic at runtime.

### Observer Pattern
Custom observer implementation decouples communication logic from the user interface. Communication classes notify observers (like the controller) when messages are received.

### Singleton Pattern
The `Logger` class is implemented as a Singleton, allowing centralized and consistent logging throughout the application.

## SOLID Principles

- **Single Responsibility** – Each class has a distinct and focused responsibility.
- **Open/Closed** – New communication methods or logging outputs can be added without changing existing code.
- **Liskov Substitution** – Communicator classes are interchangeable via the common interface.
- **Interface Segregation** – Interfaces are small and specific to the needs of the implementers.
- **Dependency Inversion** – High-level modules rely on abstractions (interfaces), not concrete implementations.

## Disclaimer

This application was developed for educational purposes only as part of a university assignment. It is not intended for production use.
