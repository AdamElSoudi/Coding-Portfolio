/*
Denna klass innehåller tre fält för att kunna skriva och läsa från textfiler:

fStream av typen FileStream

sWriter av typen StreamWriter

sReader av typen StreamReader

Metoderna är:

Konstruktorn HighScore som inte gör något.

SaveScore skriver ner innehållet från List<Score> i en textfil och om allt gick bra returneras true annars returneras false. Tänk på att nya spel ska sparas i slutet av textfilen som finns, så inga gamla spel skrivs över.

PrintScore kontrollerar om textfilen existerar och i så fall hämtas innehållet och sparas om till Score-objekt som sparas till en List<Score> som returneras.

Om du vill kan du sortera listan här innan den skickas vidare.
 */

using System;
using System.Collections;
using System.IO;
using static System.Formats.Asn1.AsnWriter;

namespace GuessTheNumber2
{
	public class HighScore
	{
		private FileStream fStream;
        private StreamWriter sWriter;
        private StreamReader sReader;

		public HighScore()
		{
			this.fStream = fStream;
			this.sWriter = sWriter;
			this.sReader = sReader;
		}

		public bool SaveScore(List<Score> allScores)
		{
			//Here a file called "Leaderboard" is being created and then filled with the players name and their score through a foreach-loop.

			sWriter = new StreamWriter("Leaderboard.txt", append: true);

            foreach (Score score in allScores)
			{
                sWriter.WriteLine($"{score.Name}: {score.Guess}");
			}
			sWriter.Close();
			return true;
        }


        public List<Score> PrintScore()
		{
			//This method check that the file with all the players and their scores exists and then writes them out

			List<Score> leaderboardFile = new List<Score>();

            sReader = new StreamReader("Leaderboard.txt");

            string notEmpty = sReader.ReadLine();


            //Here the result is added to the new file

            while(notEmpty != null)
            {
                string[] nameOrScore = notEmpty.Split(":");
                Score leaderboardPrint = new Score();
                leaderboardPrint.Name = nameOrScore[0];
                leaderboardPrint.Guess = Convert.ToInt32(nameOrScore[1]);
                leaderboardFile.Add(leaderboardPrint);
                notEmpty = sReader.ReadLine();
            }

            //Here the list is sorted by the guesses and only prints the leaderboard

            leaderboardFile = leaderboardFile.OrderBy(g => g.Guess).ToList();
            sReader.Close();

            //This part returns the list
            return leaderboardFile;
        }
    }
}