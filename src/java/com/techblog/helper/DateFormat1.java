package com.techblog.helper;

import java.sql.Timestamp;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.Month;

public class DateFormat1 {
    public static String DateToString(Timestamp dateTime){
        String date_str = dateTime.toString();
        String[] date_arr = date_str.split(" ");
        String date_str1 = date_arr[0];
        String time = date_arr[1];
        String[] date = date_str1.split("-");
        String year_str = date[0];
        String month_str = date[1];
        String day_str=date[2];
        int year = Integer.parseInt(year_str);
        int month = Integer.parseInt(month_str);
        int day = Integer.parseInt(day_str);
        LocalDate localDate = LocalDate.of(year,month,day);
        DayOfWeek dayOfWeek = localDate.getDayOfWeek();
        Month month_s = Month.of(month);
        String month1 = month_s.toString();
        String first_month = month1.substring(0,1);
        String rem_month = month1.substring(1);
        first_month = first_month.toUpperCase();
        rem_month  = rem_month.toLowerCase();
        
        String day_name = dayOfWeek.toString();
        String first_dayname = day_name.substring(0,1);
        String rem_dayname = day_name.substring(1);
        first_dayname = first_dayname.toUpperCase();
        rem_dayname  = rem_dayname.toLowerCase();
        
        String date_Time =day_str+"/"+first_month+rem_month+"/"+year_str+", "+first_dayname+rem_dayname;
        return date_Time;
    }
}
