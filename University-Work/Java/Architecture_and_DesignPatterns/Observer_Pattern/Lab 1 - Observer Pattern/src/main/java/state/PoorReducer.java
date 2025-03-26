
package state;

import java.util.ArrayList;

import java.util.List;


public class PoorReducer implements IReducer<State>{
    @Override
    public State reduce(State oldState, String action, int value) {
        if(action.equalsIgnoreCase("pollution")) {
            oldState.setInPollution(value);
        } else if(action.equalsIgnoreCase("time")) {
            oldState.setInTime(value);
        } else if(action.equalsIgnoreCase("luck")) {
            oldState.setInLuck(value);
        } else if(action.equalsIgnoreCase("risk")) {
            oldState.setInRisk(value);
        } else if(action.equalsIgnoreCase("fail")) {
            oldState.setInFail(value);
        }
        
        int rainValue = ( oldState.getInPollution() * Math.max(oldState.getInLuck(), 1) / Math.max(oldState.getInRisk(), 1) + oldState.getInTime() - oldState.getInFail() - 54 );
        
        oldState.setOutRainingCalc(rainValue);
        List<Integer> rainList = new ArrayList<>();
        for (int i = 1; i <= 12; i++) {
            rainList.add(10+i+rainValue);
        }
        
        oldState.setOutRainDigramCalc(rainList);
        
        return oldState; //we are poor and lazy :D
    }
}
