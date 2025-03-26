package Rules;

import files.IMessageSaver;

import java.util.Base64;

public class RubberLanguage extends AbstractMessage{

    public RubberLanguage(IMessageSaver message) throws Exception {
        super(message);
    }

    public String saveMessage(String message) throws Exception {

        String vowels = "aeyuoåäöi";
        String outString = "";
        int length = message.length();
        for (int i = 0; i < length; i++) {
            if (vowels.contains(message.toLowerCase().charAt(i) + "")) {
                char c = message.charAt(i);
                outString += c + "o" + c;
            }
            else {
                outString += message.charAt(i);
            }
        }
        return super.saveMessage(outString);
    }
}

