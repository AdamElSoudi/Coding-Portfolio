package com.example.lab3;

import java.io.Serializable;

/**
 * The Post class represents a single post object with all its properties.
 * The class implements the Serializable interface to allow for passing post objects between activities through intents.
 *
 * @author Adam El Soudi
 * @version 1.0
 * @since 14/03/23
 */

public class Post implements Serializable {
    private int id;
    private String title;
    private String address;
    private String time;
    private String price;
    private String description;
    private String association;
    private byte[] image;
    private String date;

    public Post(String title, String address, String time, String price, String description, String association, byte[] image, String date) {
        this.title = title;
        this.address = address;
        this.time = time;
        this.price = price;
        this.description = description;
        this.association = association;
        this.image = image;
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAssociation() {
        return association;
    }

    public void setAssociation(String association) {
        this.association = association;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
