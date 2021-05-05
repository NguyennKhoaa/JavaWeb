/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ass.dtos;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author Khoa Nguyễn
 */
public class OrdersDTO implements Serializable{
    private int OrderID;
    private String userID;
    private Date dateBuy;
    private float totalPrice;

    public OrdersDTO(int OrderID, String userID, Date dateBuy, float totalPrice) {
        this.OrderID = OrderID;
        this.userID = userID;
        this.dateBuy = dateBuy;
        this.totalPrice = totalPrice;
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public Date getDateBuy() {
        return dateBuy;
    }

    public void setDateBuy(Date dateBuy) {
        this.dateBuy = dateBuy;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }
    
}
