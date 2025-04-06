import os
import json

BASE_DIR = "/Users/adamelsoudi/Coding-Portfolio"

readmes = {    
    # Java
        # Introduction_Programming_with_Java
          "Into_Java_Lab3": os.path.join(
              BASE_DIR, "University-Work/Java/Introduction_Programming_with_Java/Labb 3/README.md"
          ),

          "Into_Java_Lab4": os.path.join(
              BASE_DIR, "University-Work/Java/Introduction_Programming_with_Java/Labb 4/README.md"
          ),

          "Into_Java_Lab5": os.path.join(
              BASE_DIR, "University-Work/Java/Introduction_Programming_with_Java/Labb 5/README.md"
          ),

        # Algorithms_DataStructures
          "Algo_Lab1": os.path.join(
              BASE_DIR, "University-Work/Java/Algorithms_DataStructures/Lab 1/README.md"
          ),

          "Algo_Lab3": os.path.join(
              BASE_DIR, "University-Work/Java/Algorithms_DataStructures/Lab3/README.md"
          ),

          "Algo_Lab4": os.path.join(
              BASE_DIR, "University-Work/Java/Algorithms_DataStructures/Lab 4/README.md"
          ),

          "Algo_Lab5": os.path.join(
              BASE_DIR, "University-Work/Java/Algorithms_DataStructures/Lab 5/README.md"
          ),

          "Algo_Project": os.path.join(
              BASE_DIR, "University-Work/Java/Algorithms_DataStructures/Project/README.md"
          ),

        # App-Development_and_Mobility
          "Evenemang_App": os.path.join(
              BASE_DIR, "University-Work/Java/App-Development_and_Mobility/README.md"
          ),

        # Architecture_and_DesignPatterns
          "Decorator_Pattern": os.path.join(
              BASE_DIR, "University-Work/Java/Architecture_and_DesignPatterns/Decorator_Pattern/README.md"
          ),

          "Observer_Pattern": os.path.join(
              BASE_DIR, "University-Work/Java/Architecture_and_DesignPatterns/Observer_Pattern/README.md"
          ),

          "Wild_Patterns": os.path.join(
              BASE_DIR, "University-Work/Java/Architecture_and_DesignPatterns/Wild_Patterns/README.md"
          ),
              
        # Software_Development_Methods_Project
          "Software_Dev_Project": os.path.join(
              BASE_DIR, "University-Work/Java/Software_Development_Methods_Project/README.md"
          ),


    # DotNet
        "EnvironmentCrime": os.path.join(
            BASE_DIR, "University-Work/DotNet_Development/EnvironmentCrime/README.md"
        ),

        "GuessTheNumber1": os.path.join(
            BASE_DIR, "University-Work/DotNet_Development/GuessTheNumber1/README.md"
        ),

        "GuessTheNumber2": os.path.join(
            BASE_DIR, "University-Work/DotNet_Development/GuessTheNumber2/README.md"
        ),

        "IT-Security_Project": os.path.join(
            BASE_DIR, "University-Work/DotNet_Development/IT-Security_Project/README.md"
        ),

        "Software_Project": os.path.join(
            BASE_DIR, "University-Work/DotNet_Development/Software_Project/README.md"
        ),


    # Databases
        "DB1_Project": os.path.join(
            BASE_DIR, "University-Work/Databases/Databases_1/Project/README.md"
        ),

        "DB2_lab_1": os.path.join(
            BASE_DIR, "University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_1/README.md"
        ),

        "DB2_lab_2": os.path.join(
            BASE_DIR, "University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_2/README.md"
        ),

        "DB2_lab_3": os.path.join(
            BASE_DIR, "University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_3/README.md"
        ),

        "DB2_lab_4": os.path.join(
            BASE_DIR, "University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_4/README.md"
        ),

        "DB2_lab_5": os.path.join(
            BASE_DIR, "University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_5/README.md"
        ),

        "DB2_lab_6": os.path.join(
            BASE_DIR, "University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_6/README.md"
        ),

    # Linux
        "linUM1_lab9": os.path.join(
            BASE_DIR, "University-Work/Linux/README.md"
        ),

    # Python
        "Python_Project": os.path.join(
            BASE_DIR, "University-Work/Python/README.md"
        ),

    # Web Dev
        "Cal_Calc": os.path.join(
            BASE_DIR, "University-Work/Web_Development/WebApplication_Development/Calorie-Calculator/README.md"
        ),

        "Stryktipset": os.path.join(
            BASE_DIR, "University-Work/Web_Development/WebApplication_Development/Stryktipset/README.md"
        ),

    # Swift
      "The Process": os.path.join(
          BASE_DIR, "Private_Projects/Gym_App_iOS/README.md"
      )
}

output = {}

for key, path in readmes.items():
    try:
        with open(path, "r", encoding="utf-8") as f:
            output[key] = f.read()
    except Exception as e:
        output[key] = f"[Error reading {key}]: {e}"

with open("project_readmes.json", "w", encoding="utf-8") as out_file:
    json.dump(output, out_file, indent=2)
