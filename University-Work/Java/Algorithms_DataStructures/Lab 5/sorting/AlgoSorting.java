package algo.sorting;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * AlgoSortingSmallSize invokes sorting algorithms with small sized data structures.
 */
public class AlgoSorting {
    /**
     * Program entry point. Invokes sorting algorithms with small sized
     * data structures.
     *
     * @param args not used.
     */
    public static void main(String[] args) {
        Sort sortingAlgorithm = null;
        int[] dataStructure;
        int[] key;
        int[] sortedDataStructure;
        int[] numberOfElements;

        /*
         * Testing Insertion sort on different number of elements and checks
         * if the result is correct.
         */
        numberOfElements = new int[]{4000, 8000, 12000, 16000, 20000};
        sortingAlgorithm = new InsertionSort();

        for (int numberOfElement : numberOfElements) {
            dataStructure = NumberCreator.createNumberArray(numberOfElement, -20, 20, true);
            key = Arrays.copyOf(dataStructure, dataStructure.length);
            sortedDataStructure = sortingAlgorithm.sort(dataStructure);
            Arrays.sort(key);

            System.out.println("Sorting " + numberOfElement + " elements using Insertion sort. Correct: " + Arrays.equals(key, sortedDataStructure));
        }

        /*
         * Testing Drake sort on different number of elements and checks
         * if the result is correct.
         */
        numberOfElements = new int[]{4000, 8000, 12000, 16000, 20000};
        sortingAlgorithm = new DrakeSort();

        for (int numberOfElement : numberOfElements) {
            dataStructure = NumberCreator.createNumberArray(numberOfElement, -20, 20, true);
            key = Arrays.copyOf(dataStructure, dataStructure.length);
            sortedDataStructure = sortingAlgorithm.sort(dataStructure);
            Arrays.sort(key);

            System.out.println("Sorting " + numberOfElement + " elements using Drake sort. Correct: " + Arrays.equals(key, sortedDataStructure));
        }

        /*
         * Testing Quick sort on different number of elements and checks
         * if the result is correct.
         */
        numberOfElements = new int[]{4000, 8000, 12000, 16000, 20000};
        sortingAlgorithm = new QuickSort();

        for (int numberOfElement : numberOfElements) {
            dataStructure = NumberCreator.createNumberArray(numberOfElement, -20, 20, true);
            key = Arrays.copyOf(dataStructure, dataStructure.length);
            sortedDataStructure = sortingAlgorithm.sort(dataStructure);
            Arrays.sort(key);

            System.out.println("Sorting " + numberOfElement + " elements using Quick sort. Correct: " + Arrays.equals(key, sortedDataStructure));
        }

        /*
         * Testing sorting of objects and checks if the result is correct.
         */
        JavaAPISort javaAPISort = new JavaAPISort();
        List<SpeciesId> sorted = new ArrayList<>(10);
        sorted.add(new SpeciesId("CAB312", 9986));
        sorted.add(new SpeciesId("BCA231", 8689));
        sorted.add(new SpeciesId("DFG723", 8689));
        sorted.add(new SpeciesId("GBH657", 7986));
        sorted.add(new SpeciesId("UNE231", 7986));
        sorted.add(new SpeciesId("XAA887", 7986));
        sorted.add(new SpeciesId("YTV825", 6586));
        sorted.add(new SpeciesId("NJI582", 3286));
        sorted.add(new SpeciesId("ABC123", 2986));
        sorted.add(new SpeciesId("BAC213", 2986));

        List<SpeciesId> unsorted = new ArrayList<>(sorted);
        Collections.shuffle(unsorted);

        unsorted = javaAPISort.sort(unsorted);

        System.out.println("Sorting 10 Species ID:objects using JavaAPI sort. Correct: " + unsorted.equals(sorted));
    }
}