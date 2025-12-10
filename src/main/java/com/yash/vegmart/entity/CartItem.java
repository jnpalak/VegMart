package com.yash.vegmart.entity;

import java.io.Serializable;

public class CartItem implements Serializable {

    private int vegetableId;
    private String name;
    private String image;
    private double price;
    private int quantity;
    private int stock;
    public CartItem() {}

    public CartItem(int vegetableId, String name, String image, double price, int quantity, int stock) {
        this.vegetableId = vegetableId;
        this.name = name;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
        this.stock = stock;
    }
    public int getVegetableId()
    {
        return vegetableId;
    }
    public void setVegetableId(int vegetableId) {
        this.vegetableId = vegetableId;
    }
    public String getName()
    {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price)
    {
        this.price = price;
    }
    public int getStock() {
        return stock;
    }
    public void setStock(int stock) {
        this.stock = stock;
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        if(quantity < 1) return;
        if(quantity >stock)
        {
            this.quantity=stock;
        }else {
            this.quantity = quantity;
        }
    }
    public double getTotalPrice() {
        return price * quantity;

    }

}

