package Util;

import java.util.regex.Pattern;

public class Constant {
    //TODO replace it with your DB credentials
    public static String DBUserName = "";
    public static String DBPassword = "";
 //   public static String FileName = "/Users/trevorasbery/eclipse-workspace2/tasbery_csci201assignment2/src/main/webapp/restaurant_data.json";
    public static String FileName = "/restaurant_data.json";

    static public Pattern namePattern = Pattern.compile("^[ A-Za-z]+$");
    static public Pattern emailPattern = Pattern.compile("^[a-zA-Z0-9_+&*-]+(?:\\."
            + "[a-zA-Z0-9_+&*-]+)*@"
            + "(?:[a-zA-Z0-9-]+\\.)+[a-z"
            + "A-Z]{2,7}$");

}