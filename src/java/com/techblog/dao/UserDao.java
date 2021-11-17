//for interacting with the dartabase
package com.techblog.dao;
import com.techblog.entities.User;
import java.sql.*;
public class UserDao {
    private Connection con;
    //it is compulsory to have the valid connection if the user object needs to be created 
    public UserDao(Connection con) {
        this.con = con;
    }
    //method to insert user data to database
    ///the user data comes from class of User.java which is the entity class of our database
    public boolean saveUser(User user){
        boolean f = false;        
        try{
            //user--->database    
            String query = "insert into user(name,email,password,gender,about,profile) values (?,?,?,?,?,?)";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setString(1,user.getName());//setting the values from the class entity
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());
            pstmt.setString(6, user.getProfile());
            pstmt.executeUpdate();
            f=true;
            
        }catch(Exception e){            
            e.printStackTrace();
        }
        return f;//return true if the query is successfully updated
    }
    
    //get user by useremail and userpassword
    public User getUserByEmailAndPassword(String email,String password){
        User user = null;
        try{
            String query = "select * from user where email =? and password=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            
            ResultSet set = pstmt.executeQuery();
            if(set.next()){
                user = new User();
                
                //data from db
                String name = set.getString("name");//getting the value from the column
                //set to user object
                user.setName(name);
                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }
                    
        }catch(Exception e){
            e.printStackTrace();
        }
        return user;
    }
    
    public boolean updateUser(User user){
        boolean f= false;
        try{
            String query = "update user set name=?,email=?,password=?,gender=?,about=?,profile=? where id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1,user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());
            pstmt.setString(6, user.getProfile());
            pstmt.setInt(7, user.getId());
            
            pstmt.executeUpdate();
            f=true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
    public User getUserByUserId(int userId){
        User user=null;
        String q ="Select * from user where id=?";
        
        try {
            PreparedStatement pstmt = this.con.prepareStatement(q);
            pstmt.setInt(1, userId);
            ResultSet set = pstmt.executeQuery();
            if(set.next()){
                user = new User();
                
                //data from db
                String name = set.getString("name");//getting the value from the column
                //set to user object
                user.setName(name);
                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return user;
    }
}
