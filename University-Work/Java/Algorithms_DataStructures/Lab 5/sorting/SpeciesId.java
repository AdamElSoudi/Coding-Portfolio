package algo.sorting;

/**
 * Connecting two id classification system where one uses only digits and the other a mix of letters and digits.
 */
public class SpeciesId {
    private final String vId;
    private final int oId;
    /**
     * Create a SpeciesId.
     *
     * @param vId id in the v-system
     * @param oId id in the o-system
     */
    public SpeciesId(String vId, int oId) {
        this.vId = vId;
        this.oId = oId;
    }
    /**
     * Get vId.
     *
     * @return vId
     */
    public String getVId() {
        return vId;
    }
    /**
     * Get the oId.
     *
     * @return oId
     */
    public int getOId() {
        return oId;
    }
}