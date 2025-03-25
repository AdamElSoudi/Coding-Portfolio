package algo.numbersequence;

/**
 * Calculate numbers in the number sequence starting with { 0, 1, 2 }
 * where additional numbers are calculated using the formula: 
 * n = (n - 1) + (n - 3) resulting in the sequence
 * { 0, 1, 2, 2, 3, 5, 7, 10, 15, 22, 32, 47, 69, 101 } etc.
 */
public interface NumberSequence {
	/**
	 * Calculate the n:th number in the number sequence starting with 
	 * { 0, 1, 2 } where additional numbers are calculated using the formula:
	 * n = (n - 1) + (n - 3) resulting in the sequence
	 * { 0, 1, 2, 2, 3, 5, 7, 10, 15, 22, 32, 47, 69, 101 } etc.
	 * So if n = 1 the method will return 1, if n = 5 it will return 5,
	 * if n = 8 it will return 15 etc.
	 * 
	 * @param n the order in the number series.
	 * @return the n:th number in the number sequence or 0 for n < 0.
	 */
	long calculate(long n);	
}