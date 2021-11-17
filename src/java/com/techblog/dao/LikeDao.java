package com.techblog.dao;

import java.sql.*;

public class LikeDao {
    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }
    
    //Inserting Like
    public boolean insertLike(int pid,int uid){
        boolean f=false;
        try{
            String q = "Insert into liked(pid,uid) values (?,?)";
            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1, pid);
            p.setInt(2, uid);
            p.executeUpdate();
            f=true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
    //counting the number of like on the post
    public int countLikeOnPost(int pid){
        int count=0;
        try {            
            String q = "Select count(*) from liked where pid=?";
            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1, pid);
            ResultSet set = p.executeQuery();
            if(set.next()){
                count = set.getInt(1);//selecting the first column
//                count = set.getInt("count(*)");//selecting the data by using column name
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    //checking whether a user has already liked a post
    public boolean isLikedByUser(int pid,int uid){
        boolean f= false;
        String q = "Select * from liked where pid=? AND uid=?";
        try{
           PreparedStatement p =  this.con.prepareStatement(q);
           p.setInt(1, pid);
           p.setInt(2, uid);
           ResultSet set = p.executeQuery();
           if(set.next()){
               f=true;
           }
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
    //if post already liked by user dislike
    public boolean deleteLike(int pid,int uid){
        boolean f= false;
        String q ="Delete from liked where pid=? and uid=?";
        try{
            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1,pid);
            p.setInt(2,uid);
            p.executeUpdate();
            f=true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
}
