package algo.multiply;

import java.util.List;

/**
 * Handles multiplication of Integers.
 */
public class Multiplier {
	
	/**
	 * Construct a Multiplier.
	 */
	public Multiplier() {	}
	
	/**
	 * Multiplies the first element from the beginning with the first element from 
	 * the end, the second element from the beginning with the second element from 
	 * the end etc and returns the sum of all multiplications. 
	 * 
	 * @param numberList a List containing Integers
	 * @return the sum
	 */
	public long multiplySome(List<Integer> numberList) {
		
		long sum = 0;

		//TODO: Add implementation
		for (int i = 0; i < numberList.size()/2; i++){
			sum += (long) numberList.get(i) * (numberList.get(numberList.size() -1-i));
		}
		return sum;		
	}	
	/**
	 * Multiplies all elements in the List with all the other elements 
	 * and returns the sum of all multiplications.  
	 * 
	 * @param numberList a List containing Integers
	 * @return the sum
	 */
	public long multiplyAll(List<Integer> numberList) {
		long sum = 0;

		//TODO: Add implementation
		for (int i = 0; i < numberList.size(); i++){
			for (int j = i+1; j < numberList.size(); j++){
				sum += (long) numberList.get(i) * numberList.get(j);
			}
		}

		return sum;
	}
}