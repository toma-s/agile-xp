package com.agilexp.repository;

import java.util.List;
import org.springframework.data.repository.CrudRepository;
import com.agilexp.model.Message;

public interface MessageRepository extends CrudRepository<Message, Long> {
    List<Message> findBySender(String sender);
}
