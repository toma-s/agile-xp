package com.agilexp.model;

import javax.persistence.*;

@Entity
@Table(name="solutions")
public class Solution {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    public Solution() {}

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "Solution{" +
                "id=" + id +
                '}';
    }
}
