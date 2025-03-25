using System.Collections;


    int guessCount = 0;
    int userGuess;
    Boolean done = false;
    ArrayList allGuesses = new ArrayList();

start:
    Random random = new Random();
    int answer = random.Next(1, 101);
    //Console.WriteLine(answer);

    Console.Write("Guess a number between 1 & 100: ");
    userGuess = int.Parse(Console.ReadLine());




    while (done != true)
    {
        if (userGuess == answer)
        {
            Console.WriteLine("Correct!");
            Console.WriteLine("Number of guesses: " + (guessCount + 1));
            Console.WriteLine("Do you want to play again? Press Y, otherwise press N");

            String again = Console.ReadLine();

            if (again == "N" || again == "n")
            {
                allGuesses.Add(guessCount + 1);
                done = true;
                Console.WriteLine("Thank you for playing, here are the number of guesses for each round: ");

                for (int i = 0; i < allGuesses.Count; i++) {
                    Console.WriteLine("Round " + (i+1) + ": " + allGuesses[i] + " guess(es) ");
                }
            
               
            }
            else if (again == "Y" || again == "y")
            {
            allGuesses.Add(guessCount + 1);

            if (guessCount >= 1)
                {
                    guessCount = 0;
                }
                goto start;
            }
        }

        else if (userGuess < answer)
        {
            Console.WriteLine("The answer is greater than your guess, Try again: ");
            userGuess = int.Parse(Console.ReadLine());
            guessCount++;
        }
        else if (userGuess > answer)
        {
            Console.WriteLine("The answer is less than your guess, Try again: ");
            userGuess = int.Parse(Console.ReadLine());
            guessCount++;
        }
    }