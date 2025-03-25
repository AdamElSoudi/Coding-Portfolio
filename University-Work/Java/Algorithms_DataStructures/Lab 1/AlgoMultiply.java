package algo.multiply;

import java.util.*;

/**
 * Invokes algorithms with small sized data structures to help you establish that 
 * your algorithm implementations are correct before testing them with large size 
 * data structures.
 */
public class AlgoMultiply {
	/**
	 * Program entry point. Invokes algorithms with different size 
	 * and type of data structure.
	 * @param args not used.
	 */
	public static void main(String[] args) {
		Multiplier test = new Multiplier();
		List<Integer> dataStructure;
		int[] numberOfElements, correctSums;
		long sum;

		/*
		 * Testing the method multiplyAll with different number of elements
		 * using the data structure ArrayList. If the algorithm is implemented
		 * correctly it should produce the following results:
		 * 4 000 elements -> Sum: 161 943 000
		 * 8 000 elements -> Sum: 647 886 000
		 * 12 000 elements -> Sum: 1 457 829 000
		 */
		numberOfElements = new int[] { 4000, 8000, 12000 };
		correctSums = new int[] { 161943000, 647886000, 1457829000 };

		for(int i = 0; i < numberOfElements.length; i ++) {
			dataStructure = new ArrayList<>(NumberCreator.createNumberList(numberOfElements[i], 0, 9, false));
			sum = test.multiplyAll(dataStructure);
			System.out.println("MultiplyAll with " + numberOfElements[i] + " elements in ArrayList. Sum: " + sum + " Correct: " + (sum == correctSums[i]));
		}

		/*
		 * Testing the method multiplyAll with different number of elements
		 * using the data structure LinkedList. If the algorithm is implemented
		 * correctly it should produce the following results:
		 * 100 elements -> Sum: 99 825
		 * 150 elements -> Sum: 225 675
		 * 200 elements -> Sum: 402 150
		 */
		numberOfElements = new int[] { 100, 150, 200 };
		correctSums = new int[] { 99825, 225675, 402150 };

		for(int i = 0; i < numberOfElements.length; i ++) {
			dataStructure = new LinkedList<>(NumberCreator.createNumberList(numberOfElements[i], 0, 9, false));
			sum = test.multiplyAll(dataStructure);
			System.out.println("MultiplyAll with " + numberOfElements[i] + " elements in LinkedList. Sum: " + sum + " Correct: " + (sum == correctSums[i]));
		}

		/*
		 * Testing the method multiplySome with different number of elements
		 * using the data structure ArrayList. If the algorithm is implemented
		 * correctly it should produce the following results:
		 * 10 000 000 elements -> Sum: 60 000 000
		 * 15 000 000 elements -> Sum: 90 000 000
		 * 20 000 000 elements -> Sum: 120 000 000
		 */
		numberOfElements = new int[] { 10000000, 15000000, 20000000 };
		correctSums = new int[] { 60000000, 90000000, 120000000 };

		for(int i = 0; i < numberOfElements.length; i ++) {
			dataStructure = new ArrayList<>(NumberCreator.createNumberList(numberOfElements[i], 0, 9, false));
			sum = test.multiplySome(dataStructure);
			System.out.println("MultiplySome with " + numberOfElements[i] + " elements in ArrayList. Sum: " + sum + " Correct: " + (sum == correctSums[i]));
		}

		/*
		 * Testing the method multiplySome with different number of elements
		 * using the data structure LinkedList. If the algorithm is implemented
		 * correctly it should produce the following results:
		 * 5 000 elements -> Sum: 30 000
		 * 10 000 elements -> Sum: 60 000
		 * 15 000 elements -> Sum: 90 000
		 */
		numberOfElements = new int[] { 5000, 10000, 15000 };
		correctSums = new int[] { 30000, 60000, 90000 };

		for(int i = 0; i < numberOfElements.length; i ++) {
			dataStructure = new LinkedList<>(NumberCreator.createNumberList(numberOfElements[i], 0, 9, false));
			sum = test.multiplySome(dataStructure);
			System.out.println("MultiplySome with " + numberOfElements[i] + " elements in LinkedList. Sum: " + sum + " Correct: " + (sum == correctSums[i]));
		}
	}
}