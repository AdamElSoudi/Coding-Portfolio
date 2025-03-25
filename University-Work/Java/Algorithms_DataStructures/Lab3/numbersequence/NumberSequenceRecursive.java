package algo.numbersequence;
/**
 * Calculate numbers in the number sequence starting with { 0, 1, 2 }
 * where additional numbers are calculated using the formula:
 * n = (n - 1) + (n - 3) resulting in the sequence
 * { 0, 1, 2, 2, 3, 5, 7, 10, 15, 22, 32, 47, 69, 101 } etc.
 * using a recursive algorithm.
 */
public class NumberSequenceRecursive implements NumberSequence {

	@Override
	public long calculate(long n) {
		// TODO Implement a recursive solution.
		long funk = 0;
		long funk2 = 0;
		long x = 0;

		if(n <= 0) {
			n = 0;
		}
		else if(n == 1){
			n = 1;
		}
		else if(n == 2){
			n = 2;
		}
		else if (n > 2) {

			x = n - 1;
			funk = calculate(x);
			x = n-3;
			funk2 = calculate(x);
			long sum = funk + funk2;
			return sum;
		}

		return n;
	}
}