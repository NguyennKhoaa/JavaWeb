/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ass.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author Khoa Nguyễn
 */
public class DBUtils {
    public static Connection getConnection() throws NamingException, SQLException{
        Connection conn = null;
        Context context = new InitialContext();
        Context end = (Context) context.lookup("java:comp/env");
        DataSource ds = (DataSource) end.lookup("DataSource");
        conn = ds.getConnection();
        return conn;
    }
    public static void main(String[] args) {
        try{
            if(getConnection()==null){
            System.out.println("ko có");
        }else{
            System.out.println("có");
        }
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
