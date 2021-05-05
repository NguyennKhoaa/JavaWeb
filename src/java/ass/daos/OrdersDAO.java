/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ass.daos;

import ass.utils.DBUtils;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author Khoa Nguyễn
 */
public class OrdersDAO implements Serializable {

    public boolean insertOrder(String userID, Date createDate, float totalPrice) throws NamingException, SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblOrders(userID, date, total) "
                        + "VALUES(?, ?, ?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                stm.setDate(2, createDate);
                stm.setFloat(3, totalPrice);
                //
                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (stm != null) {
                stm.close();
            }
        }
        return false;
    }

    public int getLastRecord() throws NamingException, SQLException{
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT orderID FROM tblOrders ORDER BY orderID DESC";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                if(rs.next()){
                    return rs.getInt("orderID");
                }
            }
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        return -1;
    }
    
    public boolean deleteOrder(int orderID) throws NamingException, SQLException{
        
         Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "DELETE FROM tblOrders WHERE orderID = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, orderID);
                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (stm != null) {
                stm.close();
            }
        }
        return false;
    }
}
