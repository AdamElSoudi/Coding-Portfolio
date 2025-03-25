using System;

/*
 Den här klassens ansvar är att skriva ut i konsolen en välkomsthälsning, hur highscore-listan ser ut och frågar om man vill spela spelet.

Fälten är:

scoreList av typen HighScore för att vi ska kunna anropa den klassen för att skriva ut listan

printList av typen List<Score> ska hålla i det som hämtas från textfilen.

Metoderna är:

Konstruktorn UI som instansierar scoreList- och printList-objekten

DrawUI som skriver ut en hälsning (se exempel nedan) och sedan anropar HighScore för att hämta listan från textfilen. Innan vi skriver ut innehållet måste vi förstås kontrollera om listan är tom eller inte. Skulle det inte finnas en textfil så måste vi skriva ut att ingen har spelat tidigare men att användaren har chansen att bli först.  Om det finns ett innehåll så ska den skrivas ut med det bästa resultatet först (om du vill sortera listan här eller i HighScore-klassen väljer du själv). Sedan ställs frågan om man vill spela och svaret returneras.
 */



namespace GuessTheNumber2
{
	public class UI
	{

		private HighScore scoreList = new HighScore();
		private List<Score> printList = new List<Score>();

        public UI()
		{
        }

		public String DrawUI()
		{
			Console.WriteLine("Welcome to Guess The Number!");
            Console.WriteLine("To start playing press Y");

            Console.WriteLine("");
            Console.WriteLine("Leaderboard:");

            if (scoreList.PrintScore().Count == 0)
            {
                Console.WriteLine("You are the first one to play!");
            }
            else
            {
                foreach (Score player in scoreList.PrintScore())
                {
                    Console.WriteLine($"Name: {player.Name} - Guesses: {player.Guess}");
                }
            }

            String startEverything;
			startEverything = Console.ReadLine();

			return startEverything;
		}
	}
}

