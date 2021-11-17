package com.techblog.entities;

import java.sql.Timestamp;

public class Reply {

    private int reply_id;
    private int r_post_id;
    private int r_comment_id;
    private int r_user_id;
    private String r_comment;
    private Timestamp rDate; 

    public Reply(int r_post_id, int r_comment_id, int r_user_id, String r_comment) {
        this.r_post_id = r_post_id;
        this.r_comment_id = r_comment_id;
        this.r_user_id = r_user_id;
        this.r_comment = r_comment;
    }

    public Reply(int reply_id, int r_post_id, int r_comment_id, int r_user_id, String r_comment, Timestamp rDate) {
        this.reply_id = reply_id;
        this.r_post_id = r_post_id;
        this.r_comment_id = r_comment_id;
        this.r_user_id = r_user_id;
        this.r_comment = r_comment;
        this.rDate = rDate;
    }

    public int getReply_id() {
        return reply_id;
    }

    public void setReply_id(int reply_id) {
        this.reply_id = reply_id;
    }

    public int getR_post_id() {
        return r_post_id;
    }

    public void setR_post_id(int r_post_id) {
        this.r_post_id = r_post_id;
    }

    public int getR_comment_id() {
        return r_comment_id;
    }

    public void setR_comment_id(int r_comment_id) {
        this.r_comment_id = r_comment_id;
    }

    public int getR_user_id() {
        return r_user_id;
    }

    public void setR_user_id(int r_user_id) {
        this.r_user_id = r_user_id;
    }

    public String getR_comment() {
        return r_comment;
    }

    public void setR_comment(String r_comment) {
        this.r_comment = r_comment;
    }

    public Timestamp getrDate() {
        return rDate;
    }

    public void setrDate(Timestamp rDate) {
        this.rDate = rDate;
    }
    
    
    
}
