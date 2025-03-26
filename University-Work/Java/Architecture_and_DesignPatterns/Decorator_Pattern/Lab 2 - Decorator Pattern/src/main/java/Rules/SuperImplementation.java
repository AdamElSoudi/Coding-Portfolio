package Rules;

import files.IMessageSaver;

public class SuperImplementation extends AbstractMessage{

    public SuperImplementation(IMessageSaver message) throws Exception {
        super(message);
    }

    public String saveMessage (String message) throws Exception {
    String messagelength = String.valueOf(message.length());


    return super.saveMessage(messagelength);
}
}
