package state;

import java.util.ArrayList;
import java.util.List;


public class State {
    private int inPollution, inTime, inLuck, inRisk, inFail;
    
    private int outRainingCalc;
    
    private List<Integer> outDigramCalc;

    public int getOutRainingCalc() {
        return outRainingCalc;
    }

    public void setOutRainingCalc(int outRainingCalc) {
        this.outRainingCalc = outRainingCalc;
    }

    public List<Integer> getOutRainDigramCalc() {
        if(outDigramCalc == null) {
            return new ArrayList<Integer>();
        }
        return outDigramCalc;
    }

    public void setOutRainDigramCalc(List<Integer> outDigramCalc) {
        this.outDigramCalc = outDigramCalc;
    }

    public int getInPollution() {
        return inPollution;
    }

    public void setInPollution(int inPollution) {
        this.inPollution = inPollution;
    }

    public int getInTime() {
        return inTime;
    }

    public void setInTime(int inTime) {
        this.inTime = inTime;
    }

    public int getInLuck() {
        return inLuck;
    }

    public void setInLuck(int inLuck) {
        this.inLuck = inLuck;
    }

    public int getInRisk() {
        return inRisk;
    }

    public void setInRisk(int inRisk) {
        this.inRisk = inRisk;
    }

    public int getInFail() {
        return inFail;
    }

    public void setInFail(int inFail) {
        this.inFail = inFail;
    }
    
    
}
