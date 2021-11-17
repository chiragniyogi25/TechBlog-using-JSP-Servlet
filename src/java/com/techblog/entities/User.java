package com.techblog.entities;
//for storing the data in form of user object
import java.sql.Timestamp;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.Month;

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private String gender;
    private Timestamp dateTime;
    private String about;
    private String profile;

    public User(int id, String name, String email, String password, String gender, Timestamp dateTime, String about,String profile) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.dateTime = dateTime;
        this.about = about;
        this.profile=profile;
    }

    public User() {
    }

    public User(String name, String email, String password, String gender, String about,String profile) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.about = about;
        this.profile = profile;
    }
    
    //getters and setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getDateTime() {
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

    public void setDateTime(Timestamp dateTime) {
        this.dateTime = dateTime;
    }

    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }
    
    
            
}
