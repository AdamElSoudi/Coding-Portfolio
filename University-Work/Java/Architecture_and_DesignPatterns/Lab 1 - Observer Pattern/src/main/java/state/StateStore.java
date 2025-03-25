package state;

import observers.IObserver;
import observers.ISubject;

import java.util.ArrayList;
import java.util.List;
import java.util.Observer;

/**
 * StateStore class holds the currect state of the application. 
 * It can also be used to initiate a change to state.
 */
public class StateStore implements ISubject {

    private static StateStore instance;

    private State currentState;
    private IReducer<State> reducer;
    private List<IObserver> observers;


    /**
     * Constructor is private since Singleton pattern is in play.
     */
    @SuppressWarnings("unchecked")
    private StateStore() {
        currentState = new State();
        reducer = new PoorReducer();
        observers = new ArrayList<>();
    }

    @Override
    public void register(IObserver obj) {
        observers.add(obj);
    }

    @Override
    public void unregister(IObserver obj) {
        observers.remove(obj);
    }

    @Override
    public void notifyObservers() {
        for(int i = 0; i<observers.size(); i++){
            observers.get(i).update();
        }
    }

    /**
     * updateInValues is the method responsible to iniate a recalculation of the state of the application.
     * 
     * @param action - What state variable to update.
     * @param value - new value for the variable thats updating.
     */
    public void updateInValues(String action, int value) {
        currentState = reducer.reduce(currentState, action, value);

        //TODO: We might need to notify all interested partys that our state has changed!
        notifyObservers();
    }
    
    /**
     * Retrive the current state of application.
     * 
     * @return State - current state of the application
     */
    public State getState() {
        return currentState;
    }

    /**
     * Gives back the and only instance of this class.
     * 
     * @return StateStore - this.
     */
    public static synchronized StateStore getInstance() {
        if (instance == null) {
            instance = new StateStore();
        }

        return instance;
    }
}
