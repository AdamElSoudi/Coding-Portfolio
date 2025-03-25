/*
 Score är klassen som endast fungerar som behållare för datat gällande spelarens namn och antal gissningar. Så den innehåller en konstruktor som inte gör något och Properties för de två fälten.
 */

using System;
namespace GuessTheNumber2
{
	public class Score
	{

		private string name;
		private int guess;

		public Score()
		{

		}

		public string Name
		{
			get { return name; }
			set { name = value; }
		}

		public int Guess
		{
			get { return guess; }
			set { guess = value; }
		}

		public Score(String name, int guess)
		{
			Name = name;
			Guess = guess;
		}

	}
}

