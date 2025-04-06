# AI Project Assistant

## Project Overview  
The AI Project Assistant is a private development project designed to support users in understanding the different software projects showcased on my portfolio website. It simulates an interactive assistant capable of answering natural language questions about specific projects.

By leveraging OpenAI's GPT-3.5-turbo model and a set of project descriptions, this assistant can provide helpful explanations, summaries, and clarifications to portfolio visitors in a professional and intuitive way.

---

## Learning Goals  
- Explore how natural language interfaces can be integrated into a personal website  
- Apply the OpenAI API in a real-world Flask-based application  
- Enhance accessibility and engagement for portfolio content  
- Design a modular and maintainable AI-based support tool  

---

## Background  
As part of my personal coding portfolio, I wanted to build an intelligent assistant that can answer questions about each project I’ve developed. Instead of relying on static descriptions, this assistant uses the content of actual README files — embedded as context — and delivers context-aware responses via a simple chat interface.

The project also allowed me to experiment with integrating AI into real-time user interfaces and further my understanding of how to structure a conversational backend for educational or professional purposes.

---

## Project Details

### Objective:  
Create a lightweight, web-based assistant that can intelligently answer questions about portfolio projects using OpenAI’s language model and predefined project context.

### Functionality:
- User types a question (e.g. *“What does the Electricity Price Analyzer do?”*)  
- A matching function identifies which project the question refers to  
- The assistant loads that project’s README content as context  
- A structured prompt is sent to OpenAI's API  
- The assistant formats and returns the answer as markdown-rendered text  

---

## Project Highlights

- Uses a curated `project_readmes.json` file to provide detailed context  
- Supports over 30 projects across Java, SQL, Python, .NET, Web Dev, and more  
- Optimized prompt engineering for clarity and helpfulness  
- Implements markdown rendering on the frontend for improved readability  
- Contains a keyword-to-project matching system to identify relevant context  
- Packaged with a clean and responsive user interface  

---
