package com.agilexp.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.agilexp.model.Message;
import com.agilexp.repository.MessageRepository;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class MessageController {
    @Autowired
    MessageRepository repository;

    @GetMapping("/messages")
    public List<Message> getAllMessages() {
        System.out.println("Get all messages...");

        List<Message> messages = new ArrayList<>();
        repository.findAll().forEach(messages::add);

        return messages;
    }

    @PostMapping(value = "/messages/create")
    public Message postMessage(@RequestBody Message message) {
        Date date = new Date();
        Message _message = repository.save(new Message(message.getSender(), message.getText(), new Timestamp(date.getTime())));
        return _message;
    }

    @DeleteMapping("/messages/{id}")
    public ResponseEntity<String> deleteMessage(@PathVariable("id") long id) {
        System.out.println("Delete Message with ID = " + id + "...");

        repository.deleteById(id);

        return new ResponseEntity<>("Message has been deleted!", HttpStatus.OK);
    }

    @DeleteMapping("/messages/delete")
    public ResponseEntity<String> deleteAllMessages() {
        System.out.println("Delete All Messages...");

        repository.deleteAll();

        return new ResponseEntity<>("All messages have been deleted!", HttpStatus.OK);
    }

    @GetMapping(value = "messages/sender/{sender}")
    public List<Message> findBySender(@PathVariable String sender) {

        List<Message> messages = repository.findBySender(sender);
        return messages;
    }

    @PutMapping("/messages/{id}")
    public ResponseEntity<Message> updateCustomer(@PathVariable("id") long id, @RequestBody Message message) {
        System.out.println("Update Message with ID = " + id + "...");

        Optional<Message> messageData = repository.findById(id);

        if (messageData.isPresent()) {
            Date date = new Date();
            Message _message = messageData.get();
            _message.setSender(message.getSender());
            _message.setText(message.getText());
            _message.setTimestamp(new Timestamp(date.getTime()));
            return new ResponseEntity<>(repository.save(_message), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}