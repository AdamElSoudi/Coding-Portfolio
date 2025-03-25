/*
 Den här klassen är huvudklassen, det här är själva spelet ligger.

Klassen har tre fält:

runGame av typen boolean som innehåller true om man vill spela och false om man inte vill spela

gameScore av typen Score som håller i uppgifterna om antal gissningar och namnet på spelaren

scoreList av typen HighScore som är den klass där man sparar ner uppgifterna om Score

 
Metoderna som finns är:

Konstruktorn GuessNumber som instansierar gameScore och scoreList.

PlayGame, som tar in en string som parameter som är svaret från användaren om den vill spela eller inte.  Här finns det mesta från del 1-uppgiften. Ordningen i metoden bör vara

Kontrollera vad parametern innehåller genom att anropa WillPlay och få tillbaka en boolean som läggs in i runGame-fältet.
Variabler för talet som ska gissas, användarens gissning och listan för gissningarna
Själva spelet i while-metoden inklusive frågan om man vill spela igen och då nollställa variablerna
Istället för att gissningen sparas i listan ska du nu i slutet skapa ett Score-objekt där du lägger in användarens namn (som du måste fråga efter) och antalet gissningar användaren gjorde. Det objektet ska nu sparas i listan för gissningarna som skapades i början av metoden.

Om man vill sluta spela så ska det sista som sker i metoden vara ett anrop till HighScore för att spara ner listan som innehåller alla spelen (spelarens namn och antal gissningar). Kom ihåg att först kolla om listan med gissningar innehåller något, man kan ju ha sagt nej till spel från första början. Svaret man får tillbaka är en boolean som ska undersökas för att tala om för spelaren att spelet nu är sparat eller att något blev fel med sparningen.

WillPlay, som är en privat hjälpmetod tar emot svaret som parameter och kontroller vad svaret innehållet – om ja så returneras true och om nej eller annat svar så returneras false.
 */

using System;
using System.Collections;

namespace GuessTheNumber2
{
    public class GuessNumber
    {
        private Boolean runGame;
        private Score gameScore;
        private HighScore scoreList;

        public GuessNumber()
        {
            gameScore = new Score();
            scoreList = new HighScore();
        }


        public void PlayGame(String startGame)
        {

        start:
            runGame = WillPlay(startGame);

        
            if (runGame == true)
            {
                String again;

                //Here the game generates a random number between 1-100 and sets up the start of the game.
                Random random = new Random();
                int answer = random.Next(1, 101);
                

                //Here the game asks for the players name och sparar det i gameScore.Name.
                Console.WriteLine("Whats your name?");
                gameScore.Name = Console.ReadLine();

                Console.Write("Guess a number between 1 & 100: ");
                int userGuess = int.Parse(Console.ReadLine());
                int guess = userGuess;
                int guessCount = 0;


                
                while (guess != answer)
                {
                    //Here the program checks to see whether the users guess is less than the correct answer.
                    if (userGuess < answer)
                    {
                        Console.WriteLine("The correct answer is greater than your guess, Try again: ");
                        userGuess = int.Parse(Console.ReadLine());
                        guess = userGuess;
                        guessCount++;
                    }

                    //Here the program checks to see whether the users guess is greater than the correct answer.
                    else if (userGuess > answer)
                    {
                        Console.WriteLine("The correct answer is less than your guess, Try again: ");
                        userGuess = int.Parse(Console.ReadLine());
                        guess = userGuess;
                        guessCount++;
                    }
                }

                //This happens when the players guess is the correct answer.
                if (userGuess == answer)
                {
                    guessCount++;
                    Console.WriteLine("Correct!");
                    Console.WriteLine("Number of guesses: " + (guessCount));
                    Console.WriteLine("Do you want to play again? Press Y, otherwise press N");

                    gameScore.Guess = guessCount;

                    //Here all the guesses made during the game are added to a list called allGuesses.
                    List<Score> allGuesses = new List<Score>();

                    allGuesses.Add(gameScore);

                    again = Console.ReadLine();


                    if (again == "Y" || again == "y")
                    {
                        //If this if-statement is activated, everything is reset so that the player can play the game again.

                      //scoreList.SaveScore(allGuesses);

                        goto start;
                    }

                    //If the players doesnt want to play again and pressed 'N', the following occurs.

                    else if (again == "N" || again == "n")
                    {
                        scoreList.SaveScore(allGuesses);
                        Console.Write("Thanks for playing!");
                    }

                }
            }
            else
            {
                Console.Write("Come back another time");
            }
        }


        //If the player writes 'Y', this method returns true and the game begins.
            private bool WillPlay(String gameStarter)
            {
                if (gameStarter == "Y" || gameStarter == "y")
                {
                    return true;
                }
                else
                    return false;
            }

        }
    }