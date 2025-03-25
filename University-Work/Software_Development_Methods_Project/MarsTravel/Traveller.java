package MarsTravel;

/**
 * Class for storing information given in TravellerInformation scene.
 */
public class Traveller {
    private static String firstName = "";
    private static String lastName = "";
    private static String email = "";
    private static String personalNumber = "";
    private static String address = "";
    private static String chronicPainText = "";
    private static String medicineText = "";

    private static int healthy = 0;
    private static int chronicPain = 0;
    private static int medicine = 0;
    private static int healthInsurance = 0;

    private static String creditCard;

    public static String getFirstName() {
        return firstName;
    }
    public static void setFirstName(String firstName) {
        Traveller.firstName = firstName;
    }

    public static String getLastName() {
        return lastName;
    }
    public static void setLastName(String lastName) {
        Traveller.lastName = lastName;
    }

    public static String getEmail() {
        return email;
    }
    public static void setEmail(String email) {
        Traveller.email = email;
    }

    public static String getPersonalNumber() {
        return personalNumber;
    }
    public static void setPersonalNumber(String personalNumber) {
        Traveller.personalNumber = personalNumber;
    }

    public static String getAddress() {
        return address;
    }
    public static void setAddress(String address) {
        Traveller.address = address;
    }

    public static String getChronicPainText() {
        return chronicPainText;
    }
    public static void setChronicPainText(String chronicPainText) {
        Traveller.chronicPainText = chronicPainText;
    }

    public static String getMedicineText() {
        return medicineText;
    }
    public static void setMedicineText(String medicineText) {
        Traveller.medicineText = medicineText;
    }

    public static int getHealthy() {
        return healthy;
    }
    public static void setHealthy(int healthy) {
        Traveller.healthy = healthy;
    }

    public static int getChronicPain() {
        return chronicPain;
    }
    public static void setChronicPain(int chronicPain) {
        Traveller.chronicPain = chronicPain;
    }

    public static int getMedicine() {
        return medicine;
    }
    public static void setMedicine(int medicine) {
        Traveller.medicine = medicine;
    }

    public static int getHealthInsurance() {
        return healthInsurance;
    }
    public static void setHealthInsurance(int healthInsurance) {
        Traveller.healthInsurance = healthInsurance;
    }

    public static String getCreditCard() {
        return creditCard;
    }
    public static void setCreditCard(String creditCard) {
            Traveller.creditCard = creditCard;
    }

    /**
     * Checks if all the information has been filled in.
     * @return true or false depending on if any of the information is filled in or not
     */
    public static boolean completed() {
        if (firstName.length() == 0 || lastName.length() == 0 || email.length() == 0 ||
                personalNumber.length() == 0 || address.length() == 0 ||
                healthy == 0 || chronicPain == 0 || medicine == 0) {
            return false;
        }
        else return true;
    }

    /**
     * Saves to database information about traveller.
     */
    public static void saveToDB(){

        String travellerInformationQuery =
                "call save_traveller('" + personalNumber +  "', '" + firstName + "', '" + lastName +
                        "', '" + address + "', '" + email + "', " + healthy + ", " + chronicPain + ", '" +
                        chronicPainText + "', " + medicine + ", '" + medicineText + "', " + healthInsurance + ");";
        DatabaseConnect.databaseConnect(travellerInformationQuery);
    }

    /**
     * Saves to database information about creditcard connected to traveller.
     */
    public static void saveToDB2(){
        int creditcard = Integer.parseInt(getCreditCard());
        String creditCardQuery = "call save_creditcart(" + creditcard +");";
        DatabaseConnect.databaseConnect(creditCardQuery);
    }

    /**
     * Resets Traveller for starting a new booking
     */
    public static void resetTraveller() {
        firstName = "";
        lastName = "";
        email = "";
        personalNumber = "";
        address = "";
        chronicPainText = "";
        medicineText = "";

        healthy = 0;
        chronicPain = 0;
        medicine = 0;
        healthInsurance = 0;

        creditCard = "";
    }
}
