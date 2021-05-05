/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ass.dtos;

import java.io.Serializable;

/**
 *
 * @author Khoa Nguyễn
 */
public class ProductDTO implements Serializable{
    private String productID;
    private String productName;
    private String productImg;
    private float price;
    private int quantity;
    private String categoryID;
    

    public ProductDTO() {
    }

    public ProductDTO(String productID, String productName, String productImg, float price, int quantity, String categoryID) {
        this.productID = productID;
        this.productName = productName;
        this.productImg = productImg;
        this.price = price;
        this.quantity = quantity;
        this.categoryID = categoryID;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public String getProductImg() {
        return productImg;
    }

    public void setProductImg(String productImg) {
        this.productImg = productImg;
    }
    
}
