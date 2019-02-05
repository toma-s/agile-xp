package com.prototype.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.sql.Timestamp;

@Entity
@Table(name="messages")
public class Message {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name = "message_sender")
    private String sender;

    @Column(name = "message_text")
    private String text;

    @Column(name= "mesage_timestamp")
    private Timestamp timestamp;

    public Message() {}

    public Message(String sender, String text, Timestamp timestamp) {
        this.sender = sender;
        this.text = text;
        this.timestamp = timestamp;
    }

    public long getId() {
        return this.id;
    }

    public String getSender() {
        return this.sender;
    }

    public String getText() {
        return this.text;
    }

    public Timestamp getTimestamp() {
        return this.timestamp;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    @Override
    public String toString() {
        return "Message [" +
                "id = " + this.id + ", " +
                "sender = " + this.sender + ", " +
                "text = " + this.text + ", " +
                "timestamp = " + this.timestamp +
                "]";
    }

}
