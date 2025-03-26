package communication;

import factory.IChat;
import factory.ICommunicator;
import io.socket.client.IO;
import io.socket.client.Socket;
import observer.IObserver;

import java.net.URISyntaxException;

/**
 * The communicator handles the network traffic between all chat clients.
 * Messages are sent and received via the WebSocket.
 * 
 * @author Martin Goblirsch
 */
public class WebSocketCommunicator implements ICommunicator {

    private final String WEB_SOCKET_ADDRESS = "http://laboration5.herokuapp.com/";
    private Socket IOSocket;
    private IChat _chat = null;

    public WebSocketCommunicator(IChat chat) {
        this._chat = chat;
    }

    /**
     * Send the chat message to all clients.
     *
     * @param sender Name of the sender.
     * @param message Text message to send.
     * @throws java.lang.Exception
     */
    public void sendChat(String sender, String message) throws Exception {

        try {
            this.IOSocket.emit("message", sender + ": " + message);
        } catch (Exception e) {
            throw e;
        }
    }

    /**
     * Start to listen for messages from other clients.
     */
    public void startListen() {
        try {
            this.listenForMessages();
        } catch (Exception e) {
            _chat.error(e);
        }
    }
    
    public void stopListen() throws Exception {
        //_chat.unregister(this);
        IOSocket.disconnect();
        IOSocket.close();
    }

    /**
     * Listen for messages from other clients.
     */
    private void listenForMessages() throws Exception {
        try {
            IOSocket = IO.socket(WEB_SOCKET_ADDRESS);

            IOSocket.on("message", (final Object... args) -> {
                _chat.receiveMessage(args[0].toString());
            });
            IOSocket.connect();

        } catch (URISyntaxException e) {
            throw e;
        }
    }


    @Override
    public void update(String name, String message) throws Exception {
        sendChat(name, message);
    }
}

