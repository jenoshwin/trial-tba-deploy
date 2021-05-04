/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
public class TBACheckoutServlet extends HttpServlet {

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
                if (session.getAttribute("role") == null) {
                    response.sendRedirect("login.jsp");
                } else {
                    PreparedStatement sq1 = null;
                    ResultSet books = null;
                    ResultSet quantity = null;
                    ResultSet ogStock = null;
                    try {
                        String userID = (String) session.getAttribute("userID");
                        String fname = request.getParameter("firstName");
                        String lname = request.getParameter("lastName");
                        String email = request.getParameter("email");
                        String phone = request.getParameter("mobile");
                        String address = request.getParameter("address");
                        String payment = request.getParameter("modePayment");
                        String delivery = request.getParameter("modeDelivery");
                        String total = request.getParameter("totalPrice");
                        String[] orders = request.getParameterValues("orderID");

                        
                        if (orders == null) {
                            request.setAttribute("msg", "Please select books for checkout.");
                            RequestDispatcher rd = request.getRequestDispatcher("Cart");
                            rd.forward(request, response);
                        } else {

                            //Creating a checkout Row and ID
                            LocalDateTime newDate = LocalDateTime.now();
                            DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("MM-dd-yyyy HH:mm:ss");
                            String dateCheckout = newDate.format(myFormatObj);
                            String addCheckout = "INSERT INTO checkoutinfo (userID_FK, total_price, address, payment_method, delivery_method, order_time) VALUES (?, ?, ?, ?, ?, ?)";
                            sq1 = conn.prepareStatement(addCheckout);
                            sq1.setString(1, userID);
                            sq1.setString(2, total);
                            sq1.setString(3, address);
                            sq1.setString(4, payment);
                            sq1.setString(5, delivery);
                            sq1.setString(6, dateCheckout);
                            sq1.executeUpdate();

                            //Retrieving the CheckoutID
                            String getRow = "SELECT checkoutID FROM checkoutinfo WHERE userID_FK = ? ORDER BY checkoutID DESC FETCH FIRST 1 ROWS ONLY";
                            sq1 = conn.prepareStatement(getRow);
                            sq1.setString(1, userID);
                            books = sq1.executeQuery();
                            String id = null;
                            while (books.next()) {
                                id = books.getString("checkoutID");
                            }

                            //Connecting the CheckoutID on the Orderinfo
                            for (String order : orders) {
                                String updateOrder = "UPDATE orderinfo SET checkoutID_FK = ?, bookCheckout = ? WHERE orderID = ?";
                                sq1 = conn.prepareStatement(updateOrder);
                                sq1.setString(1, id);
                                sq1.setString(2, "true");
                                sq1.setString(3, order);
                                sq1.executeUpdate();

                                //UPDATEING THE DATABASE
                                //Get the quantity of the order
                                String updateStock = null;
                                String selectQuantity = "SELECT quantity FROM orderinfo WHERE orderID = ?";
                                sq1 = conn.prepareStatement(selectQuantity);
                                sq1.setString(1, order);
                                quantity = sq1.executeQuery();

                                //Get the quantity of the stock
                                String selectStock = "SELECT bookinfo.stock AS stock, bookinfo.bookID AS bookID FROM bookinfo INNER JOIN orderinfo ON bookinfo.bookID = orderinfo.bookID_FK WHERE orderinfo.orderID = ?";
                                sq1 = conn.prepareStatement(selectStock);
                                sq1.setString(1, order);
                                ogStock = sq1.executeQuery();

                                while (quantity.next() && ogStock.next()) {
                                    int quan = Integer.parseInt(quantity.getString("quantity"));
                                    int stock = Integer.parseInt(ogStock.getString("stock"));
                                    String bookID = ogStock.getString("bookID");
                                    int newStock = stock - quan;

                                    if (newStock > 0) {
                                        updateStock = "UPDATE bookinfo SET stock = ? WHERE bookID = ?";
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

                            String getBooks = "SELECT orderinfo.quantity, bookinfo.bookname, bookinfo.author FROM bookinfo INNER JOIN orderinfo ON bookinfo.bookID = orderinfo.bookID_FK INNER JOIN checkoutinfo ON checkoutinfo.checkoutID = orderinfo.checkoutID_FK WHERE checkoutinfo.checkoutID = ?";
                            sq1 = conn.prepareStatement(getBooks);
                            sq1.setString(1, id);
                            books = sq1.executeQuery();

                            request.setAttribute("checkoutID", id);
                            request.setAttribute("fname", fname);
                            request.setAttribute("lname", lname);
                            request.setAttribute("email", email);
                            request.setAttribute("phone", phone);
                            request.setAttribute("address", address);
                            request.setAttribute("payment", payment);
                            request.setAttribute("delivery", delivery);
                            request.setAttribute("total", total);
                            request.setAttribute("data", books);
                            RequestDispatcher rd = request.getRequestDispatcher("success.jsp");
                            rd.forward(request, response);
                        }
                    } finally {
                        ogStock.close();
                        quantity.close();
                        books.close();
                        sq1.close();
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
            Logger.getLogger(TBACheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(TBACheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
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
