package observer;

public interface ISubject {
    void register(IObserver observer);
    void unregister(IObserver observer);
    void notifyObs(String name, String message) throws Exception;
}
