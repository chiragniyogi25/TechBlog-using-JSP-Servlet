package com.techblog.entities;

import java.sql.Timestamp;

public class Comment {
    private int comment_id;
    private int user_id;
    private String comment;
    private int post_id;
    private Timestamp cDate;  

    public Comment(int user_id, String comment, int post_id) {
        this.user_id = user_id;
        this.comment = comment;
        this.post_id = post_id;
    }

    public Comment(int comment_id, int user_id, String comment, int post_id, Timestamp cDate) {
        this.comment_id = comment_id;
        this.user_id = user_id;
        this.comment = comment;
        this.post_id = post_id;
        this.cDate = cDate;
    }

    public int getComment_id() {
        return comment_id;
    }

    public void setComment_id(int comment_id) {
        this.comment_id = comment_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getPost_id() {
        return post_id;
    }

    public void setPost_id(int post_id) {
        this.post_id = post_id;
    }

    public Timestamp getcDate() {
        return cDate;
    }

    public void setcDate(Timestamp cDate) {
        this.cDate = cDate;
    }
}
