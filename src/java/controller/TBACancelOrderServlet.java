/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author karla
 */
public class TBACancelOrderServlet extends HttpServlet {

    Connection conn;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        try {
            Class.forName(config.getInitParameter("jdbcClassName"));
            String username = config.getInitParameter("dbUserName");
            String password = config.getInitParameter("dbPassword");
            StringBuffer url = new StringBuffer(config.getInitParameter("jdbcDriverURL"))
                    .append("://")
                    .append(config.getInitParameter("dbHostName"))
                    .append(":")
                    .append(config.getInitParameter("dbPort"))
                    .append("/")
                    .append(config.getInitParameter("databaseName"));
            conn = DriverManager.getConnection(url.toString(), username, password);
        } catch (SQLException sqle) {
            System.out.println("SQLException error occured - "
                    + sqle.getMessage());
        } catch (ClassNotFoundException nfe) {
            System.out.println("ClassNotFoundException error occured - "
                    + nfe.getMessage());
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           
            if (conn != null) {
                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
                response.setHeader("Pragma", "no-cache");
                response.setHeader("Expires", "0");
                HttpSession session = request.getSession(false);
                Boolean admin = (Boolean) session.getAttribute("admin");
                if (admin == false) {
                    response.sendRedirect("BookBrowsing.jsp");
                } else {
                    PreparedStatement sq1 = null;
                    ResultSet orders = null;
                    ResultSet ogStock = null;
                    try {
                        String checkoutID = request.getParameter("checkoutID").trim();

                        String cancelOrder = "UPDATE checkoutinfo SET cancel = true WHERE checkoutID = ?";
                        sq1 = conn.prepareStatement(cancelOrder);
                        sq1.setString(1, checkoutID);
                        sq1.executeUpdate();

                        //update stock
                         String updateStock = null;
                        String getOrders = "SELECT bookID_FK, quantity from orderinfo WHERE checkoutID_FK = ?";
                        sq1 = conn.prepareStatement(getOrders);
                        sq1.setString(1, checkoutID);
                        orders = sq1.executeQuery();

                        while (orders.next()) {
                            int quantity = Integer.parseInt(orders.getString("quantity"));
                            String bookID = orders.getString("bookID_FK");

                            String getOgStock = "SELECT stock from bookinfo WHERE bookID= ?";
                            sq1 = conn.prepareStatement(getOgStock);
                            sq1.setString(1, bookID);
                            ogStock = sq1.executeQuery();
                            
                            while (ogStock.next()){
                                int oldStock = Integer.parseInt(ogStock.getString("stock"));
                                int newStock = oldStock + quantity;
                                
                                if (newStock > 0) {
                                    updateStock = "UPDATE bookinfo SET stock = ?, availability = true WHERE bookID = ?";
                                } else {
                                    updateStock = "UPDATE bookinfo SET stock = ?, availability = false WHERE bookID = ?";
                                }
                                //Update the stock
                                sq1 = conn.prepareStatement(updateStock);
                                sq1.setInt(1, newStock);
                                sq1.setString(2, bookID);
                                sq1.executeUpdate();
                            }
                        }

                        response.sendRedirect("Orders");
                    } finally {
                        sq1.close();
                        orders.close();
                        ogStock.close();
                    }
                }
            }
        } catch (SQLException sqle) {
            response.sendRedirect("error.jsp");
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(TBACancelOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(TBACancelOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
