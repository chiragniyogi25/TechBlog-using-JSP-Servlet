package com.techblog.helper;
import java.sql.*;
public class ConnectionProvider {
    private static Connection conn;
    public static Connection getConnection(){
        try{
            if(conn==null){
                //Driver Class Load
                Class.forName("com.mysql.jdbc.Driver");

                //create a connection
                String url = "jdbc:mysql://localhost:3306/techblog";
                String username="root";
                String password="12345678";
                conn = DriverManager.getConnection(url,username,password);
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return conn;
    }
}
