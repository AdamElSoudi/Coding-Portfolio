package communication;

import factory.IChat;
import factory.ICommunicator;
import observer.IObserver;
import observer.ISubject;

import java.io.IOException;
import java.net.*;

/**
 * The communicator handles the network traffic between all chat clients.
 * Messages are sent and received via the UDP protocol which may lead to
 * messages being lost.
 *
 * @author Thomas Ejnefjäll
 * @author Martin Goblirsch
 */
public class UDPChatCommunicator implements Runnable, ICommunicator {

    private final int DATAGRAM_LENGTH = 100;
    private final int PORT = 6789;
    private final String MULTICAST_ADDRESS = "228.28.28.28";
    private InetSocketAddress _group;
    private NetworkInterface _netIf;
    private IChat _chat = null;
    private MulticastSocket _socket = null;

    /**
     * Create a chat communicator that communicates over UDP.
     *
     * @param chat The UI that want to receive incoming messages.
     */
    public UDPChatCommunicator(IChat chat) {
        this._chat = chat;
        /*
         * force java to use IPv4 so we do not get a problem when using IPv4 multicast
         * address
         */
        System.setProperty("java.net.preferIPv4Stack", "true");
    }

    /**
     * Send the chat message to all clients.
     *
     * @param sender  Name of the sender.
     * @param message Text message to send.
     * @throws IOException If there is an IO error.
     */
    public void sendChat(String sender, String message) throws Exception {

        try (DatagramSocket socket = new DatagramSocket()) {
            String toSend = sender + ": " + message;
            byte[] b = toSend.getBytes();

            DatagramPacket datagram = new DatagramPacket(b, b.length, InetAddress.getByName(MULTICAST_ADDRESS), PORT);

            socket.send(datagram);
            socket.disconnect();
            socket.close();
        } catch (Exception e) {
            throw e;
        }
    }

    /**
     * Start to listen for messages from other clients.
     */
    public void startListen() {
        new Thread(this).start();
    }

    /**
     * Listen for messages from other clients.
     *
     * @throws Exception If there is an IO error.
     */
    private void listenForMessages() throws Exception {
        byte[] b = new byte[DATAGRAM_LENGTH];
        DatagramPacket datagram = new DatagramPacket(b, b.length);

        if(_socket == null) {
            _group = new InetSocketAddress(InetAddress.getByName(MULTICAST_ADDRESS), PORT);
            _netIf = NetworkInterface.getByName("bge0");
            _socket = new MulticastSocket(PORT);
        }

        _socket.joinGroup(_group, _netIf);

        while (true) {
            _socket.receive(datagram);
            String message = new String(datagram.getData());
            message = message.substring(0, datagram.getLength());
            _chat.receiveMessage(message);
            datagram.setLength(b.length);
        }

    }

    /**
     * Stop listen, we leave the group..
     * @throws Exception
     */
    public void stopListen() throws Exception {
        //_chat.unregister(this);
        _socket.leaveGroup(_group, _netIf);
    }

    @Override
    public void run() {
        try {
            this.listenForMessages();
        } catch (Exception e) {
            _chat.error(e);
        }
    }


    @Override
    public void update(String name, String message) throws Exception {
        sendChat(name, message);
    }
}
