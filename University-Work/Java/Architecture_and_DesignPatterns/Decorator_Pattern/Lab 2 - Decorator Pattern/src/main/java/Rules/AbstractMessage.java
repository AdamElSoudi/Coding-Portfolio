package Rules;

import files.IMessageSaver;

public abstract class AbstractMessage implements IMessageSaver {

private IMessageSaver message;

    public AbstractMessage(IMessageSaver message) throws Exception {
        this.message = message;
    }

    @Override
    public String saveMessage(String message) throws Exception {
        return this.message.saveMessage(message);
    }
}
