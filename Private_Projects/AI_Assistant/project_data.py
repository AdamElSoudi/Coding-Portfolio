import json
import os

BASE_DIR = "/Users/adamelsoudi/Coding-Portfolio"

folders = {
    # Java
        # Introduction_Programming_with_Java
          "Into_Java_Lab3": os.path.join(
              BASE_DIR, "University-Work/Java/Introduction_Programming_with_Java/Labb 3"
          ),

          "Into_Java_Lab4": os.path.join(
              BASE_DIR, "University-Work/Java/Introduction_Programming_with_Java/Labb 4"
          ),

          "Into_Java_Lab5": os.path.join(
              BASE_DIR, "University-Work/Java/Introduction_Programming_with_Java/Labb 5"
          ),

        # Algorithms_DataStructures
          "Algo_Lab1": os.path.join(
              BASE_DIR, "University-Work/Java/Algorithms_DataStructures/Lab 1"
          ),

          "Algo_Lab3": os.path.join(
              BASE_DIR, "University-Work/Java/Algorithms_DataStructures/Lab3"
          ),

          "Algo_Lab4": os.path.join(
              BASE_DIR, "University-Work/Java/Algorithms_DataStructures/Lab 4"
          ),

          "Algo_Lab5": os.path.join(
              BASE_DIR, "University-Work/Java/Algorithms_DataStructures/Lab 5"
          ),

          "Algo_Project": os.path.join(
              BASE_DIR, "University-Work/Java/Algorithms_DataStructures/Project"
          ),

        # App-Development_and_Mobility
          "Evenemang_App": os.path.join(
              BASE_DIR, "University-Work/Java/App-Development_and_Mobility"
          ),

        # Architecture_and_DesignPatterns
          "Decorator_Pattern": os.path.join(
              BASE_DIR, "University-Work/Java/Architecture_and_DesignPatterns/Decorator_Pattern"
          ),

          "Observer_Pattern": os.path.join(
              BASE_DIR, "University-Work/Java/Architecture_and_DesignPatterns/Observer_Pattern"
          ),

          "Wild_Patterns": os.path.join(
              BASE_DIR, "University-Work/Java/Architecture_and_DesignPatterns/Wild_Patterns"
          ),
              
        # Software_Development_Methods_Project
          "Software_Dev_Project": os.path.join(
              BASE_DIR, "University-Work/Java/Software_Development_Methods_Project"
          ),


    # DotNet
        "EnvironmentCrime": os.path.join(
            BASE_DIR, "University-Work/DotNet_Development/EnvironmentCrime "
        ),

        "GuessTheNumber1": os.path.join(
            BASE_DIR, "University-Work/DotNet_Development/GuessTheNumber1"
        ),

        "GuessTheNumber2": os.path.join(
            BASE_DIR, "University-Work/DotNet_Development/GuessTheNumber2"
        ),

        "IT-Security_Project": os.path.join(
            BASE_DIR, "University-Work/DotNet_Development/IT-Security_Project"
        ),

        "Software_Project": os.path.join(
            BASE_DIR, "University-Work/DotNet_Development/Software_Project"
        ),


    # Databases
        "DB1_Project": os.path.join(
            BASE_DIR, "University-Work/Databases/Databases_1/Project"
        ),

        "DB2_lab_1": os.path.join(
            BASE_DIR, "University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_1"
        ),

        "DB2_lab_2": os.path.join(
            BASE_DIR, "University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_2"
        ),

        "DB2_lab_3": os.path.join(
            BASE_DIR, "University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_3"
        ),

        "DB2_lab_4": os.path.join(
            BASE_DIR, "University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_4"
        ),

        "DB2_lab_5": os.path.join(
            BASE_DIR, "University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_5"
        ),

        "DB2_lab_6": os.path.join(
            BASE_DIR, "University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_6"
        ),

    # Linux
        "linUM1_lab9": os.path.join(
            BASE_DIR, "University-Work/Linux"
        ),

    # Python
        "Python_Project": os.path.join(
            BASE_DIR, "University-Work/Python"
        ),

    # Web Dev
        "Cal_Calc": os.path.join(
            BASE_DIR, "University-Work/Web_Development/WebApplication_Development/Calorie-Calculator"
        ),

        "Stryktipset": os.path.join(
            BASE_DIR, "University-Work/Web_Development/WebApplication_Development/Stryktipset"
        ),

    # Swift
      "The Process": os.path.join(
          BASE_DIR, "Private_Projects/Gym_App_iOS"
      ),

    # AI
    "AI-Assistant": os.path.join(
        BASE_DIR, "Private_Projects/ai_assistant"
    )
}

def load_code_files(folder, extensions=(".py", ".java", ".sql", ".cs", ".js", ".ipynb")):
    result = ""
    for root, dirs, files in os.walk(folder):
        for file in files:
            if file.endswith(extensions):
                try:
                    with open(os.path.join(root, file), "r", encoding="utf-8") as f:
                        result += f"\n\n===== {file} =====\n"
                        result += f.read()
                except Exception as e:
                    result += f"\n\n[Error reading {file}]: {e}"
    return result

code_data = {key: load_code_files(path) for key, path in folders.items()}

with open("project_code.json", "w", encoding="utf-8") as f:
    json.dump(code_data, f, indent=2)

# Load project context from pre-generated JSON file
json_path = os.path.join(os.path.dirname(__file__), "project_readmes.json")

with open(json_path, "r", encoding="utf-8") as f:
    PROJECTS = json.load(f)
