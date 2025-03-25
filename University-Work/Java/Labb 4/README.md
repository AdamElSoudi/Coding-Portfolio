# Lab4 - Swedish to English Translation Quiz

This Java program is a simple **Swedish to English translation quiz** where users translate words and receive feedback on their answers.

## Features
- **Word Bank:** Contains 10 Swedish words and their correct English translations.
- **Case-Insensitive Checking:** User input is compared to the correct answer regardless of case.
- **Partial Credit:** If a user's answer is more than **50% correct**, they receive an "Almost correct!" message.
- **Exit Option:** Users can type **'Q'** to quit at any time, displaying their final score.

## How It Works
1. The user is prompted with a Swedish word and must type the English translation.
2. The program checks the answer:
   - **Correct answers** increase the score.
   - **Incorrect answers** display the correct word.
   - **Partial matches** receive an "Almost correct!" message.
3. If the user enters **'Q'**, the game ends and displays their total score.

## Files
- **`Lab4Code.java`**: Contains the main quiz logic.
- **`Lab4.java`**: Runs the program by calling `Lab4Code`.

---
**Note:** The program could be improved by expanding the word bank and refining the similarity check.

---
