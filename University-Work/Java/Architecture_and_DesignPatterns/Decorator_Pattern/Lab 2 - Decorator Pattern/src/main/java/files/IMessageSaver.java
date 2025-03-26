package files;

/**
 * Gives the possibility to saves messages in some place.
 * 
 * @author marre
 */
public interface IMessageSaver {
    /**
     * Takes in a string and saves it at root location of the running application. 
     * 
     * @param message to be saved in the file.
     * @return Name of the saved file.
     * @throws Exception if something went wrong with the save.
     */
    String saveMessage(String message) throws Exception;  
}
