package algo.sorting;

/**
 * Sort an array containing integers in ascending order
 * (arranged from smallest to largest) using the Drake sort algorithm.
 */
public class DrakeSort implements Sort {

	@Override
	public int[] sort(int[] unsorted) {
		//TODO: Add implementation

		if (null == unsorted || unsorted.length < 2) {
			return unsorted; // nothing to sort
		}
		// Find the min and the max number in the unsorted array.
		int max = unsorted[0];
		int min = unsorted[0];

		for (int i = 1; i < unsorted.length; i++) {
			if (min > unsorted[i]) {
				min = unsorted[i];
			} else if (max < unsorted[i]) {
				max = unsorted[i];
			}
		}

		// Finding the size between the min and max number and making it an array
		int[] freq = new int[max - min + 1];

		for (int j : unsorted) {
			freq[j - min] += 1;
		}

		// Create and put in numbers into sorted array
		int[] sorted = new int[unsorted.length];

		for (int i = 0, k = 0; i < freq.length; i++) {

			while (freq[i] > 0) {
				sorted[k++] = min + i; // populate sorted array
				freq[i]--;
			}
		}
		return sorted;
	}
}