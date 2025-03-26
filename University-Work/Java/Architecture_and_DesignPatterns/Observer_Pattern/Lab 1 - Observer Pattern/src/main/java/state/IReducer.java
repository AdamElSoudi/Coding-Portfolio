
package state;


public interface IReducer<S> {
    public S reduce(State oldState, String action, int value);
}
