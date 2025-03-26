package factory;

import observer.IObserver;

public interface ICommunicator extends IObserver {

    void sendChat(String sender, String message) throws Exception;
    void startListen();
    void stopListen() throws Exception;
}
