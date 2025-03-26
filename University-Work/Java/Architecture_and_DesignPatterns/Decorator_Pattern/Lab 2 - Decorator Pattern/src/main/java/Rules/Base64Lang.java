package Rules;

import files.IMessageSaver;

import java.util.Base64;

public class Base64Lang extends AbstractMessage {

    public Base64Lang(IMessageSaver message) throws Exception {
        super(message);
    }

    public String saveMessage(String message) throws Exception {
      String outString = Base64.getEncoder().encodeToString(message.getBytes());

        return super.saveMessage(outString);
            }
        }
