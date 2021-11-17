package com.techblog.entities;
//if a user makes in login page we will use this message entity
public class Message {
    private String content;
    private String type;//succes msg or error msg
    private String cssClass;

    public Message(String content) {
        this.content = content;
    }

    public Message(String content, String type, String cssClass) {
        this.content = content;
        this.type = type;
        this.cssClass = cssClass;
    }
    //getters and setters

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCssClass() {
        return cssClass;
    }

    public void setCssClass(String cssClass) {
        this.cssClass = cssClass;
    }
    
}
