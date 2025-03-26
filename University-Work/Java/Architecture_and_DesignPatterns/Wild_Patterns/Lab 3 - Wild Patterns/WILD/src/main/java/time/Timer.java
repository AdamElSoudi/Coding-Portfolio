package time;

import java.text.SimpleDateFormat;
import java.util.Date;

/*
*
* Takes the time for the message
* */
public class Timer {

    public void tiden(String timer) {
        SimpleDateFormat format = new SimpleDateFormat("'Date:' yyyy-MM-dd 'Time:' HH:mm:ss z");
        Date date = new Date(System.currentTimeMillis());
        timer = format.format(date) + ". " + timer;
        System.out.println(timer);
    }
}
