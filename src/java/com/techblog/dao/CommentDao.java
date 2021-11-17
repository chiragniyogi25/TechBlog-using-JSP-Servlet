package com.techblog.dao;

import com.techblog.entities.Comment;
import com.techblog.entities.Reply;
import java.sql.*;
import java.util.*;

public class CommentDao {

    Connection conn;
    public CommentDao(Connection conn) {
        this.conn = conn;
    }
    
    //inserting cokment
    public boolean insertComment(int post_id,int u_id,String comment){
        boolean f = false;
        String q = "Insert into comment(user_id,comments,post_id) Values(?,?,?)";
        try{
            PreparedStatement pstmt = this.conn.prepareStatement(q);
            pstmt.setInt(1,u_id);
            pstmt.setString(2,comment);
            pstmt.setInt(3,post_id);
            pstmt.executeUpdate();
            f=true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
    
    //getting all comments
    public List<Comment> getComment(int post_id){
        List<Comment> comment_list =  new ArrayList<>();
        String q = "Select * from comment where post_id=?";
        try{
            PreparedStatement pstmt = this.conn.prepareStatement(q);
            pstmt.setInt(1,post_id);
            ResultSet set = pstmt.executeQuery();
            while(set.next()){
                int comment_id = set.getInt("comment_id");
                int user_id = set.getInt("user_id");
                String comment = set.getString("comments");
                Timestamp c_date= set.getTimestamp("cdate");
                Comment c = new Comment(comment_id, user_id, comment, post_id, c_date);
                comment_list.add(c);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return comment_list;
    }
    ///________REPLY_______ 
 //insert reply 
    public boolean insertReply(int post_id,int com_id,int u_id,String comment){
        boolean f = false;
        String q = "Insert into reply(r_post_id,r_comm_id,r_uid,r_comment) Values(?,?,?,?)";
        try{
            PreparedStatement pstmt = this.conn.prepareStatement(q);
            pstmt.setInt(1,post_id);
            pstmt.setInt(2,com_id);
            pstmt.setInt(3,u_id);
            pstmt.setString(4,comment);
            pstmt.executeUpdate();
            f=true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    //getting all replies
    public List<Reply> getReplyComment(int comment_id){
        List<Reply> reply_list =  new ArrayList<>();
        String q = "Select * from reply where r_comm_id=?";
        try{
            PreparedStatement pstmt = this.conn.prepareStatement(q);
            pstmt.setInt(1,comment_id);
            ResultSet set = pstmt.executeQuery();
            while(set.next()){
                int reply_id = set.getInt("r_id");
                int r_post_id = set.getInt("r_post_id");
                int r_comm_id = set.getInt("r_comm_id");
                int r_user_id = set.getInt("r_uid");
                String comment = set.getString("r_comment");
                Timestamp r_date= set.getTimestamp("date");
                Reply r = new Reply(reply_id, r_post_id, r_comm_id, r_user_id, comment, r_date);
                reply_list.add(r);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return reply_list;
    }
    //counting number of comments
    public int totalComment(int pid){
        int count =0;
        String q1 = " Select count(*) from comment where post_id=?";
        String q2 = " Select count(*) from reply where r_post_id=?";
        try {
            PreparedStatement pstmt = this.conn.prepareStatement(q1);
            pstmt.setInt(1,pid);
            ResultSet set = pstmt.executeQuery();
            if(set.next()){
                count=set.getInt(1);
            }
            PreparedStatement pstmt1 = this.conn.prepareStatement(q2);
            pstmt1.setInt(1,pid);
            set = pstmt1.executeQuery();
            if(set.next()){
                count=set.getInt(1)+count;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int getCommentCount(){
        int count =0;
        String q1 = " Select count(*) from comment";
        try {
            Statement s = this.conn.createStatement();
            ResultSet set = s.executeQuery(q1);
            if(set.next()){
                count=set.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    public int getReplyCount(int pid){
        int count =0;
        String q = " Select count(*) from reply where r_post_id=?";
        try {
            PreparedStatement pstmt = this.conn.prepareStatement(q);
            pstmt.setInt(1,pid);
            ResultSet set = pstmt.executeQuery();
            if(set.next()){
                count=set.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
}


