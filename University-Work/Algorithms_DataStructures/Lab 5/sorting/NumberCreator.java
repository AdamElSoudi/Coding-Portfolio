package algo.sorting;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * Simple class to help construct a List with Integer values repeating the number pattern 0 to 9.
 */
public class NumberCreator {
	/**
	 * Create a List of integers. If values are not randomized they will repeat the number patterns
	 * lowerBound - uppBound incremented by one for each new number.
	 *
	 * @param n amount of integers
	 * @param lowerBound lowest possible value (inclusive)
	 * @param upperBound highest possible value (inclusive)
	 * @param random true if values should be randomized and false if they should have a repeated pattern
	 * @return list of integers
	 */
	public static List<Integer> createNumberList(int n, int lowerBound, int upperBound, boolean random) {
		List<Integer> numberList = new ArrayList<>(n);

		if(random) {
			Random rand = new Random();
			for(int i = 0; i < n; i ++) {
				numberList.add(rand.nextInt(upperBound - lowerBound + 1) + lowerBound);
			}
		}
		else {
			for(int i = 0, j = lowerBound; i < n; i ++) {
				numberList.add(j++);
				if(j > upperBound) {
					j = lowerBound;
				}
			}
		}
		return numberList;
	}
	/**
	 * Create a List of integers. If values are not randomized they will repeat the number patterns
	 * lowerBound - uppBound incremented by one for each new number.
	 *
	 * @param n amount of integers
	 * @param lowerBound lowest possible value (inclusive)
	 * @param upperBound highest possible value (inclusive)
	 * @param random true if values should be randomized and false if they should have a repeated pattern
	 * @return array of integers
	 */
	public static int[] createNumberArray(int n, int lowerBound, int upperBound, boolean random) {
		int[] numberList = new int[n];

		if(random) {
			Random rand = new Random();
			for(int i = 0; i < n; i ++) {
				numberList[i] = rand.nextInt(upperBound - lowerBound + 1) + lowerBound;
			}
		}
		else {
			for(int i = 0, j = lowerBound; i < n; i ++) {
				numberList[i] = j++;
				if(j > upperBound) {
					j = lowerBound;
				}
			}
		}
		return numberList;
	}
}