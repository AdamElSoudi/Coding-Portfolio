package algo.treemap;
import java.util.Collection;
import java.util.Map;
import java.util.TreeMap;
/**
 * Handles add and retrieve operations on TreeMaps.
 */
public class TreeMapHandler {
    /**
     * Creates a TreeMap containing the provides entries. If there are more than
     one entry with the same key,
     * the first entry value is added. Following entries with identical keys will
     not replace the previously added value.
     *
     * @param entries entries with key and value
     * @return TreeMap with the provided entries
     */
    public TreeMap<Integer, Integer> createTreeMap(Entry[] entries) {
        TreeMap <Integer, Integer> map = new TreeMap<Integer, Integer>();
        for (Entry entry : entries) {
            if (!map.containsKey(entry.key) )
                map.put(entry.key, entry.value);
        }
        return map;
    }
    /**
     * Retrieves a Map with the entries associated with the provided keys.
     *
     * @param tree the tree map
     * @param keys keys for the entries we want to retrieve
     * @return Map containing the retrieved entries
     */
    public Map<Integer, Integer> retrieve(TreeMap<Integer, Integer> tree, int[]
            keys) {
        TreeMap<Integer, Integer> map = new TreeMap<Integer, Integer>();
        for (int key : keys) {
            if (tree.containsKey(key)) {
                map.put(key, tree.get(key));
            }
        }
        return map;
    }
    /**
     * Retrieves a Map containing the entries between the provided keys (including
     the from and to key).
     * @param tree the TreeMap
     * @param fromKey low endpoint of keys (inclusive)
     * @param toKey high endpoint of keys (inclusive)
     * @return Map containing the entries between the provided keys (including the
    from and to key)
     */
    public Map<Integer, Integer> retrieve(TreeMap<Integer, Integer> tree, int
            fromKey, int toKey) {
        return tree.subMap(fromKey, true, toKey, true);
    }
    /**
     * Retrieves all keys from the tree.
     * @param tree the TreeMap
     * @return Collection with all keys
     */
    public Collection<Integer> retrieveAllKeys(TreeMap<Integer, Integer> tree) {
        return tree.keySet();
    }
    /**
     * Retrieves all values from the tree.
     * @param tree the TreeMap
     * @return Collection with all values
     */
    public Collection<Integer> retrieveAllValues(TreeMap<Integer, Integer> tree) {
        return tree.values();
    }
}
