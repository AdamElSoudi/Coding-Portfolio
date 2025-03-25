package algo.sorting;

import java.util.*;

/**
 * Sort a List of SpeciesId. The list will be sorted according to oId descending. If species have the
 * same oId they will be sorted according to vId ascending.
 */
public class JavaAPISort {

	/**
	 * Sort a List of SpeciesId. The list will be sorted according to oId descending. If species have the
	 * same oId they will be sorted according to vId ascending.
	 * @param s the original list
	 * @return sorted list
	 */
	public List<SpeciesId> sort(List<SpeciesId> s) {
		//TODO: Add implementation
		s.sort(Comparator.comparing(SpeciesId::getOId).reversed().thenComparing(SpeciesId::getVId));

		return s;
	}
}