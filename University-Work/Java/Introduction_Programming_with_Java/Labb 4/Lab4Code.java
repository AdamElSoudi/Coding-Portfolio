import java.util.ArrayList;
import java.util.Scanner;


public class Lab4Code {
    public static void main() {


        Scanner answer = new Scanner(System.in);

        // points are how many questions that are answered correctly and total is the number of questions answered.
        int points = 0;
        int total = 0;


        System.out.println("If you want to stop press Q");

        ArrayList<String> words = new ArrayList<String>();
        words.add("fotboll");
        words.add("bord");
        words.add("skor");
        words.add("dörr");
        words.add("hus");
        words.add("bokstav");
        words.add("kudde");
        words.add("spel");
        words.add("fönster");
        words.add("mat");

        //This array list is called english and has all the correct translations/answers
        ArrayList<String> english = new ArrayList<String>();
        english.add("football");
        english.add("table");
        english.add("shoes");
        english.add("door");
        english.add("house");
        english.add("letter");
        english.add("pillow");
        english.add("game");
        english.add("window");
        english.add("food");


        //Here the program the user can give one answer per question and uses a forloop while i is less
        //than the amount of words in the array list words which is 10. It picks the word from each index
        // position and the users answer is saved in a1. 1 gets added to total for each question.
        System.out.println("** Translate the word to english **");
        System.out.println("");
        for (int i = 0; i < words.size(); i++) {
            System.out.print(words.get(i) + ": ");
            String userInput = answer.nextLine();
            total++;

            //Here the users answer is compared to the correct answer and is not case sensitive. Points
            //increases by one if they are the same.
            if (userInput.toUpperCase().equals(english.get(i).toUpperCase())) {
                System.out.println("Correct!");
                points++;
            }

            //If the user types the letter Q then the game ends and points at that time and the number
            //of questions asked at that point are shown. I subtracted total by one because the Q is
            //counted as an answer.
            if (userInput.equals("Q") || (userInput.equals("q"))) {
                total--;
                System.out.println(points + " point(s)" + " out of " + total + " questions");
                System.out.println("");
                break;
            }

            counter(userInput, english.get(i), points, total);

        }
    }

    //This is a new method called counter. I created 2 new variables, k and choice.



    public static void counter(String userInput, String correctAnswer, int points, int total) {


        int matchingLetters = 0;
        String choice;

        //userInput is the same as a1 and if it is longer that correctAnswer which is the value
        //in my array list english then my variable choice becomes the correct answer. Otherwise
        //choice becomes the userInput. I did this because when checking if the characters
        //at each index position match, if the userInput had less index positions it would cause
        //an error in the forloop where i < correctAnswer.length and if I instead had i < userInput.length
        //there would be the same error but when the userInput had more index positions than correctAnswer.
        if (userInput.length() >= correctAnswer.length())
            choice = correctAnswer;
        else choice = userInput;

        for (int i = 0; i < choice.length(); i++) {


            //For everytime the char from both userInput and correctAnswer match, 1 gets added to the
            //variable matchingLetters.
            if (userInput.charAt(i) == (correctAnswer.charAt(i)))
                matchingLetters++;

        }

        //Here I made it so that if k is bigger than correctAnswer.length divided by 2 it would
        //say "Almost correct", because its more that 50% correct, as well as give the correct answer.
        //I also made it so k isn't completely equal to the answer. If that isn't true then it
        //just says "incorrect"
        if (matchingLetters > (correctAnswer.length() / 2) && matchingLetters != correctAnswer.length())
            System.out.println("Almost correct! The correct answer was " + correctAnswer);
        else if (matchingLetters < correctAnswer.length()) {
            System.out.println("Incorrect!");
        }

        //Here it gives the points which have increased by one each time the answer was correct
        //and out of total which is for each question which they answered which depends of if they
        //pressed Q at any point in the game.
        System.out.println(points + " point(s)" + " out of " + total + " questions");

    }
}


