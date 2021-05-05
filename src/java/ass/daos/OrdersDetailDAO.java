/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ass.daos;

import ass.utils.DBUtils;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author Khoa Nguyễn
 */
public class OrdersDetailDAO implements Serializable{
    public boolean insertOrderDetail(int orderID,String productID,int quantity, float price) throws NamingException, SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblOrderDetails(orderID, productID, price, quantity) "
                        + "VALUES(?, ?, ?, ?)";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, orderID);
                stm.setString(2,productID);
                stm.setInt(3, quantity);
                stm.setFloat(4, price);
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
