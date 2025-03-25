package observers;

import java.util.Observer;

public interface ISubject {

    void register(IObserver obj);
    void unregister(IObserver obj);
    void notifyObservers();
}
