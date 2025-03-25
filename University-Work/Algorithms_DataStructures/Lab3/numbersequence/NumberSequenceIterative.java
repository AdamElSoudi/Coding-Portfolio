package algo.numbersequence;

import java.util.ArrayList;

/**
 * Calculate numbers in the number sequence starting with { 0, 1, 2 }
 * where additional numbers are calculated using the formula:
 * n = (n - 1) + (n - 3) resulting in the sequence
 * { 0, 0, 1, 2, 2, 3, 5, 7, 10, 15, 22, 32, 47, 69, 101 } etc. using
 * an iterative algorithm.
 */
public class NumberSequenceIterative implements NumberSequence {

	@Override
	public long calculate(long n) {
		// TODO Implement an iterative solution.

		if (n <= 0) {
			n = 0;
			return n;
		}

		int[] num = new int[(int) (3 + n)];
		num[0] = 0;
		num[1] = 1;
		num[2] = 2;


			for (int i = 3; i <= n; i++){
				num[i] = num[i - 1] + num[i - 3];
			}

		return num[(int) n];
	}
}
