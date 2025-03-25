package algo.sorting;

/**
 * Sort an array containing integers in ascending order
 * using the insertion sort algorithm.
 */
public class InsertionSort implements Sort {

	@Override
	public int[] sort(int[] unsorted) {

		int n = unsorted.length;
		for (int i = 1; i < n; ++i) {
			int key = unsorted[i];
			int j = i - 1;

			while (j >= 0 && unsorted[j] > key) {
				unsorted[j + 1] = unsorted[j];
				j = j - 1;
			}
			unsorted[j + 1] = key;
		}
		return unsorted;
	}
}