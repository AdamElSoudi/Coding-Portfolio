/*
 I klassen Program finns metoden Main som skapar en instans av UI för att kunna anropa metoden DrawUI som skriver ut starthälsningen till spelet, tar emot svaret om man vill spela och returnerar strängen med svaret till Main. I Main skapas också en instans av klassen GuessNumber för att anropa metoden PlayGame och skickar med svaret från UI som en parameter.

Vill man kan man här också lägga in en slututskrift som talar om att nu är spelet avslutat och tacka spelaren.
 */


using System;
using System.Collections;

namespace GuessTheNumber2
{
	public class Program
	{
		public static void Main(String[] args)
		{
			GuessNumber guessNumber = new GuessNumber();
			UI ui = new UI();

			guessNumber.PlayGame(ui.DrawUI());
		}
	}
}