package algo.numbersequence;

/**
 * Invokes algorithms with small values to help you establish that
 * your algorithm implementations are correct.
 */
public class AlgoNumberSequence {
	/**
	 * Program entry point.
	 *
	 * @param args not used.
	 */
	public static void main(String[] args) {
		long[] n = { -5, 0, 1, 2, 3, 4, 5, 10, 13 };
		long[] number = { 0, 0, 1, 2, 2, 3, 5, 32, 101 };
		NumberSequence numberSequence = null;
		
		/*
		 * Testing NumberSequenceIterative
		 */
		numberSequence = new NumberSequenceIterative();
		
		System.out.println("Testing NumberSequenceIterative");
		
		for(int i = 0; i < n.length; i ++) {
			long calculatedNumber = numberSequence.calculate(n[i]);
			System.out.println("Number in sequence for n=" + n[i] + ": " + calculatedNumber + ". Correct: " + (calculatedNumber == number[i]));
		}
		
		/*
		 * Testing NumberSequenceRecursive
		 */
		numberSequence = new NumberSequenceRecursive();
		
		System.out.println("Testing NumberSequenceRecursive");
		
		for(int i = 0; i < n.length; i ++) {
			long calculatedNumber = numberSequence.calculate(n[i]);
			System.out.println("Number in sequence for n=" + n[i] + ": " + calculatedNumber + ". Correct: " + (calculatedNumber == number[i]));
		}
	}
}