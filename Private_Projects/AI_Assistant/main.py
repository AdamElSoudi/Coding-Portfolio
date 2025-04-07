from flask import Flask, request, jsonify, render_template
from dotenv import load_dotenv
import openai
import os
import json

# Load environment variables
load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")

app = Flask(__name__, static_folder="stylesheets")

# Load README context
with open("project_readmes.json", "r", encoding="utf-8") as f:
    READMES = json.load(f)

# Load code context
with open("project_code.json", "r", encoding="utf-8") as f:
    CODE = json.load(f)

# Merge contexts
PROJECTS = {}
for key in set(READMES.keys()).union(CODE.keys()):
    PROJECTS[key] = ""
    if key in READMES:
        PROJECTS[key] += READMES[key] + "\n\n"
    if key in CODE:
        PROJECTS[key] += CODE[key]

print("[DEBUG] Keys loaded into PROJECTS:", list(PROJECTS.keys()))
print("[DEBUG] Is 'Python_Project' loaded?", "Python_Project" in PROJECTS)
print(f"Loaded {len(READMES)} README projects and {len(CODE)} code projects.")
print(f"Merged total projects: {len(PROJECTS)}")

# GPT-based project detection
def detect_project_gpt(question: str, project_titles: list):
    try:
        prompt = (
            "Based on the following list of portfolio projects:\n"
            + "\n".join(project_titles) +
            "\n\nWhich project is the user referring to in this question:\n"
            f"'{question}'\n\n"
            "Respond ONLY with the exact matching project title from the list. If none match, reply 'None'."
        )

        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": prompt}],
            max_tokens=50,
            temperature=0.2
        )

        match = response.choices[0].message["content"].strip()
        return match if match in PROJECTS else ""
    except Exception as e:
        print(f"[ERROR] GPT project detection failed: {e}")
        return ""

# Optional fallback mapping (can be removed if you fully switch to GPT)
def detect_project(question: str):
    mapping = {
        # Java Projects:
        "Integer Statistics Calculator": "Into_Java_Lab3",
        "Swedish to English Vocabulary Quiz": "Into_Java_Lab4",
        "Interactive Movie Database Interface": "Into_Java_Lab5",
        "Multiply Algorithms": "Algo_Lab1",
        "Number Sequence Generator": "Algo_Lab3",
        "TreeMap Data Management": "Algo_Lab4",
        "Sorting Algorithm Comparison": "Algo_Lab5",
        "Weather Data Analysis": "Algo_Project",
        "Text Inserter with Decorator Pattern": "Decorator_Pattern",
        "Observer Pattern Implementation": "Observer_Pattern",
        "Wild Patterns Chat Application": "Wild_Patterns",
        "University Activity Sharing App": "Evenemang_App",
        "MarsTravel - Interplanetary Booking System": "Software_Dev_Project",

        # DotNet Projects:
        "Guess The Number 1": "GuessTheNumber1",
        "Guess The Number 2": "GuessTheNumber2",
        "Secure Sick Leave System": "IT-Security_Project",
        "Environment Crime Report System": "EnvironmentCrime",
        "Final Software Project": "Software_Project",

        #SQL Projects:
        "Monster Collector: SQL Database Project": "DB1_Project",
        "Simple Movie Database": "DB2_lab_1",
        "Users, Friends, and Hobbies Database": "DB2_lab_2",
        "Users & Orders Database": "DB2_lab_3",
        "Employees & Projects Database": "DB2_lab_4",
        "Accounts & Transactions Database": "DB2_lab_5",
        "Webshop Orders & Inventory Database": "DB2_lab_6",

        #Linux Projects:
        "Debian Package Management": "linUM1_lab9",

        #Python Projects:
        "Electricity Price Analyzer": "Python_Project",

        # Web-Dev Projects:
        "Calorie-Calculator": "Cal_Calc",
        "Stryktipset": "Stryktipset",

        # Swift Projects:
        "The Process": "The Process",

        # AI Projects:
        "AI Projects Assistant": "AI-Assistant",
        "yourself": "AI-Assistant"
    }

    question_lower = question.lower()
    for keyword, project_key in mapping.items():
        if keyword.lower() in question_lower:
            return project_key
    return ""

@app.route("/")
def index():
    return render_template("chat.html")


FALLBACK_CONTEXTS = {
    "java": "Adam's Java projects include Integer Statistics Calculator, Swedish to English Vocabulary Quiz, Interactive Movie Database Interface, Multiply Algorithms, Number Sequence Generator, TreeMap Data Management, Sorting Algorithm Comparison, Weather Data Analysis, Text Inserter with Decorator Pattern, Observer Pattern Implementation, Wild Patterns Chat Application, University Activity Sharing App, and MarsTravel - Interplanetary Booking System",

    "dotnet": "Adam's .NET projects involve C# applications Guess The Number 1, Guess The Number 2, Secure Sick Leave System, Environment Crime Report System, and Final Software Project",

    "sql": "Adam's SQL-based database labs cover relational modeling, indexing, views, stored procedures, and transaction handling. Adam's SQL based projects are Monster Collector: SQL Database Project, Simple Movie Database, Users, Friends, and Hobbies Database, Users & Orders Database, Employees & Projects Database, Accounts & Transactions Database, Webshop Orders & Inventory Database", 

    "linux": "Adam's Linux projects includes the Debian Package Management project",

    "python": "Adam's Python projects includes the Electricity Price Analyzer project",
    
    "web-dev": "Adam's Web Development projects include Calorie-Calculator and Stryktipset",

    "swift": "Adam's Swift/iOS projects include The Process",

    "ai": "You are Adam's AI project"
}

GITHUB_LINKS = {
    "Project_ID": "Git link",
    # Java
        # Introduction_Programming_with_Java
    "Into_Java_Lab3": "https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Java/Introduction_Programming_with_Java/Labb%203",
    "Into_Java_Lab4":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Java/Introduction_Programming_with_Java/Labb%204",
    "Into_Java_Lab5":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Java/Introduction_Programming_with_Java/Labb%205",

        # Algorithms_DataStructures
        "Algo_Lab1":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Java/Algorithms_DataStructures/Lab%201",
        "Algo_Lab3":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Java/Algorithms_DataStructures/Lab3",
        "Algo_Lab4":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Java/Algorithms_DataStructures/Lab%204",
        "Algo_Lab5":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Java/Algorithms_DataStructures/Lab%205",
        "Algo_Project":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Java/Algorithms_DataStructures/Project",

        # App-Development_and_Mobility
        "Evenemang_App":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Java/App-Development_and_Mobility",

        # Architecture_and_DesignPatterns
        "Decorator_Pattern":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Java/Architecture_and_DesignPatterns/Decorator_Pattern",
        "Observer_Pattern":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Java/Architecture_and_DesignPatterns/Observer_Pattern",
        "Wild_Patterns":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Java/Architecture_and_DesignPatterns/Wild_Patterns",

        # Software_Development_Methods_Project
        "Software_Dev_Project":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Java/Software_Development_Methods_Project",

    # DotNet
    "EnvironmentCrime":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/DotNet_Development/EnvironmentCrime%20",
    "GuessTheNumber1":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/DotNet_Development/GuessTheNumber1",
    "GuessTheNumber2":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/DotNet_Development/GuessTheNumber2",
    "IT-Security_Project":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/DotNet_Development/IT-Security_Project",
    "Software_Project":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/DotNet_Development/Software_Project",

    # Databases
    "DB1_Project":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Databases/Databases_1/Project",
    "DB2_lab_1":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_1",
    "DB2_lab_2":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_2",
    "DB2_lab_3":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_3",
    "DB2_lab_4":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_4",
    "DB2_lab_5":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_5",
    "DB2_lab_6":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_6",

    # Linux
    "linUM1_lab9":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Linux",

    # Python
    "Python_Project":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Python",

    # Web Dev
    "Cal_Calc":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Web_Development/WebApplication_Development/Calorie-Calculator",
    "Stryktipset":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/University-Work/Web_Development/WebApplication_Development/Stryktipset",

    # Swift
    "The Process":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/Private_Projects/Gym_App_iOS",

    # AI
    "AI-Assistant":"https://github.com/AdamElSoudi/Coding-Portfolio/tree/main/Private_Projects/AI_Assistant"
}


@app.route("/ask", methods=["POST"])
def ask():
    data = request.get_json()
    question = data.get("question", "")

    # Try GPT detection first
    project_key = detect_project_gpt(question, list(PROJECTS.keys()))

    # If GPT fails to match, use fallback
    if not project_key:
        project_key = detect_project(question)

    readme_context = READMES.get(project_key, "") if project_key else ""
    code_context = CODE.get(project_key, "") if project_key else ""
    
    # If there is no real context and no fallback, block hallucinated answers
    if not readme_context and not code_context and not fallback_key:
        return jsonify({
            "answer": (
                        "I couldn't find a related project based on your question. "
                        "Please try asking about a specific project by name or describe its topic more clearly."
        )
    })


    fallback_key = ""
    if not project_key:
        for key in FALLBACK_CONTEXTS:
            if key in question.lower():
                fallback_key = key
                break


    # Limit token size to avoid overflow
    MAX_CONTEXT_LENGTH = 12000
    def truncate_context(text, max_chars=MAX_CONTEXT_LENGTH):
        return text[:max_chars]

    combined_context = ""
    if readme_context:
        combined_context += f"# README Summary\n{readme_context}\n\n"
    if code_context:
        combined_context += f"# Code Context\n{code_context}"
    elif fallback_key:
        combined_context += FALLBACK_CONTEXTS.get(fallback_key, "")

    # Append GitHub link
    link_note = ""
    if project_key and project_key in GITHUB_LINKS:
        github_link = GITHUB_LINKS[project_key]
        link_note = (
            f'\n\nIf you want to view the code for this project, you can find it here: '
            f'<a href="{github_link}" target="_blank" rel="noopener noreferrer">{github_link}</a>'
        )



    combined_context = truncate_context(combined_context)

    try:
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "system", "content": "You are a highly intelligent AI assistant created by Adam El Soudi. Your primary role is to help users explore and understand the projects in Adam’s portfolio, but you can also answer general questions about yourself, your purpose, and who built you. Always be professional, helpful, and detailed in your responses."},
                {"role": "user", "content": f"Project context:\n{combined_context}"},
                {"role": "user", "content": question + link_note}
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
