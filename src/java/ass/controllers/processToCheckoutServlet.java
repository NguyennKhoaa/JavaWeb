/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ass.controllers;

import ass.cart.CartObject;
import ass.daos.OrdersDAO;
import ass.daos.OrdersDetailDAO;
import ass.daos.ProductDAO;
import ass.dtos.ProductDTO;
import ass.dtos.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Khoa Nguyễn
 */
@WebServlet(name = "processToCheckoutServlet", urlPatterns = {"/processToCheckoutServlet"})
public class processToCheckoutServlet extends HttpServlet {

    private final String SUCCESS_PAGE = "success.jsp";
    private final String OUT_OF_STOCK = "viewCart.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        float totalPrice = Float.parseFloat(request.getParameter("totalPrice"));
        HttpSession session = request.getSession();
        String url = OUT_OF_STOCK;
        try {
            String userID = ((UserDTO) session.getAttribute("LOGIN_USER")).getUserID();
            OrdersDAO ordersDAO = new OrdersDAO();
            java.util.Date today = new java.util.Date();
            Date createDate = new Date(today.getTime());
            CartObject cart = (CartObject) session.getAttribute("CART");           
            if (!cart.getCartProduct().isEmpty()) {
                if (ordersDAO.insertOrder(userID, createDate, totalPrice)) {
                    OrdersDetailDAO ordersDetailDAO = new OrdersDetailDAO();
                    Iterator<Map.Entry<String, ProductDTO>> it = cart.getCartProduct().entrySet().iterator();
                    ProductDAO dao = new ProductDAO();
                    boolean outOfStock = false;
                    List<String> listProduct = new ArrayList<>();
                    List<String> listProductRemove = new ArrayList<>();
                    while (it.hasNext()) {
                        Map.Entry<String, ProductDTO> map = it.next();
                        int quantityDB = dao.getQuantityProductByID(map.getKey());
                        if (quantityDB < map.getValue().getQuantity()) {
                            if (quantityDB == 0) {
                                listProduct.add(map.getKey() + " is Out Of stock.(Removed)");
                                listProductRemove.add(map.getKey());
                            } else {
                                listProduct.add(map.getKey() + ". This product just only contain: " + quantityDB + ".(updated)");
                                cart.getCartProduct().get(map.getKey()).setQuantity(quantityDB);
                            }
                            outOfStock = true;
                        }
                    }
                    
                    
                    Iterator<Map.Entry<String, ProductDTO>> it2 = cart.getCartProduct().entrySet().iterator();
                    if (!outOfStock) {
                        while (it2.hasNext()) {
                            Map.Entry<String, ProductDTO> map = it2.next();
                            ordersDetailDAO.insertOrderDetail(ordersDAO.getLastRecord(), map.getKey(),
                                    map.getValue().getQuantity(), map.getValue().getPrice());
                            int quantityDB = dao.getQuantityProductByID(map.getKey());
                            dao.updateQuantityAfterCheckout(map.getKey(), quantityDB - map.getValue().getQuantity());
                        }
                        url = SUCCESS_PAGE;
                        cart.getCartProduct().clear();
                    } else {
                        ordersDAO.deleteOrder(ordersDAO.getLastRecord());
                        for (String string : listProductRemove) {
                            cart.getCartProduct().remove(string);
                        }
                        String productOutOfStock = "";
                        for (String string : listProduct) {
                            productOutOfStock += string + " , ";
                        }
                        request.setAttribute("OUT_OF_STOCK_CHECK_OUT", "OUT OF STOCK at " + productOutOfStock);
                        if (cart.getCartProduct().isEmpty()) {
                            cart.setCartProduct(null);
                        }
                    }
                    session.setAttribute("CART", cart);
                }
            }

        } catch (SQLException ex) {
            log("SQLEx at CheckoutServlet: " + ex.getMessage());
        } catch (NamingException ex) {
            log("NamingEx at CheckoutServlet: " + ex.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
