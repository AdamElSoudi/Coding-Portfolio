import json
import os

# Optional: Keep this for local regeneration if needed later
def load_folder(folder_path, extensions=(".py", ".md", ".txt")):
    content = ""
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if not file.endswith(extensions):
                continue  # Skip non-code/text files
            file_path = os.path.join(root, file)

            try:
                with open(file_path, "r", encoding="utf-8") as f:
                    content += f"\n\n===== {file} =====\n"
                    content += f.read()
            except Exception as e:
                content += f"\n\n[Error reading {file_path}]: {e}\n"
    return content

# Load project context from pre-generated JSON file
json_path = os.path.join(os.path.dirname(__file__), "project_readmes.json")

with open(json_path, "r", encoding="utf-8") as f:
    PROJECTS = json.load(f)
