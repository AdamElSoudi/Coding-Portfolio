package files;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Random;

/**
 * Saves massages to a text file at root location of the application.
 * 
 * @author marre
 */
final public class SaveMessageToFile implements IMessageSaver {

    @Override
    public String saveMessage(String message) throws Exception {
        Path path = getPath();
        Files.write(path, message.getBytes());

        return path.toString();
    }

    private Path getPath() {
        return Paths.get("message-" + generateRandomString(8) + "-.txt");
    }

    private String generateRandomString(int length) {
        int leftLimit = 97; // letter 'a'
        int rightLimit = 122; // letter 'z'

        Random random = new Random();
        StringBuilder buffer = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            int randomLimitedInt = leftLimit + (int) (random.nextFloat() * (rightLimit - leftLimit + 1));
            buffer.append((char) randomLimitedInt);
        }
        return buffer.toString();

    }

}
