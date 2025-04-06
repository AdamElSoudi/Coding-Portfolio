from flask import Flask, request, jsonify, render_template
from dotenv import load_dotenv
import openai
import os
from project_data import PROJECTS  # Loaded from JSON

load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")

app = Flask(__name__, static_folder="stylesheets")

# Optional debug log: print the first few project keys loaded
print(f"Loaded {len(PROJECTS)} projects.")

# Mapping function: detects the project based on user question
def detect_project(question: str):
    mapping = {
        # Java
        "Integer Statistics Calculator": "Into_Java_Lab3",
        "Swedish to English Vocabulary Quiz": "Into_Java_Lab4",
        "Interactive Movie Database Interface": "Into_Java_Lab5",

        # Algorithms & Data Structures
        "Multiply Algorithms": "Algo_Lab1",
        "Number Sequence Generator": "Algo_Lab3",
        "TreeMap Data Management": "Algo_Lab4",
        "Sorting Algorithm Comparison": "Algo_Lab5",
        "Weather Data Analysis": "Algo_Project",
        
        # Architecture & Design Patterns
        "Text Inserter with Decorator Pattern": "Decorator_Pattern",
        "Observer Pattern Implementation": "Observer_Pattern",
        "Wild Patterns Chat Application": "Wild_Patterns",

        # App Development
        "University Activity Sharing App": "Evenemang_App",

        # Software Dev Methods
        "MarsTravel - Interplanetary Booking System": "Software_Dev_Project",

        # DotNet
        ".NET Guess The Number 1": "GuessTheNumber1",
        ".NET Guess The Number 2": "GuessTheNumber2",
        "Secure Sick Leave System": "IT-Security_Project",
        "Environment Crime Report System": "EnvironmentCrime",
        "Final Software Project": "Software_Project",

        # Databases
        "Monster Collector: SQL Database Project": "DB1_Project",
        "Simple Movie Database": "DB2_lab_1",
        "Users, Friends, and Hobbies Database": "DB2_lab_2",
        "Users & Orders Database": "DB2_lab_3",
        "Employees & Projects Database": "DB2_lab_4",
        "Accounts & Transactions Database": "DB2_lab_5",
        "Webshop Orders & Inventory Database": "DB2_lab_6",

        # Linux
        "Debian Package Management": "linUM1_lab9",

        # Python
        "Electricity Price Analyzer": "Python_Project",

        # Web Dev
        "Calorie-Calculator": "Cal_Calc",
        "Stryktipset": "Stryktipset",

        # Swift
        "The Process": "The Process"
    }

    question_lower = question.lower()
    for keyword, project_key in mapping.items():
        if keyword.lower() in question_lower:
            return project_key

    return ""  # Fallback: no project found

@app.route("/")
def index():
    return render_template("chat.html")

@app.route("/ask", methods=["POST"])
def ask():
    data = request.get_json()
    question = data.get("question", "")

    # Detect the relevant project
    project_key = detect_project(question)
    context = PROJECTS.get(project_key, "")

    # Debug log
    print(f"[User Question] {question}")
    print(f"[Matched Project Key] {project_key}")
    print(f"[Context Length] {len(context)} characters")

    # Guard against missing context
    if not context:
        return jsonify({"answer": "I couldn't find a related project. Please ask about a specific one you've seen on the portfolio using it's entire name."})

    try:
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[
                {
                    "role": "system",
                    "content": "You're an highly intellegent AI assistant trained to answer questions about student portfolio projects. Be detailed and helpful. You are assisting the user of the website to understand how certain projects work and what they do. Be professional and answer any questions the user may have about each project."
                },
                {
                    "role": "user",
                    "content": f"Project context:\n{context}"
                },
                {
                    "role": "user",
                    "content": question
                }
            ],
            max_tokens=1000,
            temperature=0.7
        )
        answer = response.choices[0].message["content"]
        return jsonify({"answer": answer})

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True)
