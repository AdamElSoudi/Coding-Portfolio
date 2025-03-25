import java.util.*;

public class Lab3 {


//Skriv ett program som med hjälp av kommandofönstret tar in ett antal heltal för
// att sedan skriva ut medelvärdet och hur många av de angivna talen som endast angetts
// en gång. Programmet ska även kunna hantera felaktig input.


    public static ArrayList<Integer> ints = new ArrayList<Integer>();

    public static void main (String[] args) {
        //numberOfInputs();
        inputs(numberOfInputs());
        // you need to add some kind of error handeling so you dont get error if the user enters 0 inputs
        System.out.println("The average value of your entered inputs is: " + meanValue(ints));
        System.out.println("You have entered: " + uniqueIntegers(ints) + " unique integer(s)");
    }
    // Ask how many integers the user wants to enter
    public static int numberOfInputs(){
        int quantities;
        while(true) {
            try {
                System.out.println("How many integers would you like to enter: ");
                Scanner input = new Scanner(System.in);
                quantities = input.nextInt();
                return quantities;

            } catch (InputMismatchException e) {
                System.out.println("Please enter an integer!");
            }
        }
    }
    // Handles the given input
    // Can be improved by telling the user when an incorrect value has been entered
    public static void inputs(int quantities){
        Scanner input = new Scanner(System.in);

        for(int i = 0; i < quantities; i++){
            try{
                System.out.println("Enter your integer: ");
                int entered_integer = input.nextInt();
                ints.add(entered_integer);

            }
            catch (InputMismatchException e){
                System.out.println("Please enter an integer!");
                input.nextLine();
                i --;
            }
        }
    }
    public static int meanValue(ArrayList<Integer> ints){
        int sum = 0;
        for (int i = 0; i < ints.size(); i++){
            sum += ints.get(i);
        }
        return (sum / ints.size());
    }
    public static int uniqueIntegers(ArrayList<Integer> ints){
        // The total amount of entered ints - the repeated gives the number of unique ints
        int length = ints.size();
        int repeated = 0;
        ArrayList<Integer> repeated_integers = new ArrayList<Integer>();

        for (int i = 0; i < ints.size(); i++){
            for (int j = (i + 1); j < ints.size(); j++){
                if (ints.get(i).equals(ints.get(j))){
                    repeated += 1;
                    // To check whether it is the first time an integer is found repeated
                    boolean already_found = false;
                    for (int k = 0; k < repeated_integers.size(); k++){
                        if (ints.get(i).equals(repeated_integers.get(k))){
                            already_found = true;
                            break;
                        }
                    }
                    // First time
                    if (already_found == false){
                        repeated += 1;
                    }
                    repeated_integers.add(ints.get(j));
                    ints.remove(j);
                    j--;

                }
            }
        }
        // Amount of unique integers
        return (length - repeated);
    }
}



