package factory;

import communication.UDPChatCommunicator;
import communication.WebSocketCommunicator;
import controllers.MainWindowController;

public class CommunicatorFactory implements IFactory{
    public ICommunicator createComm(String type, MainWindowController CHAT) {
    if (type.equals("UDP")) {
        return new UDPChatCommunicator(CHAT);
    }
    else if(type.equals("WebSocket")) {
        return new WebSocketCommunicator(CHAT);
    }
        return null;
    }
}
