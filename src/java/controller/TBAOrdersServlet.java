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
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author karla
 */
@WebServlet(name = "TBAOrdersServlet", urlPatterns = {"/Orders"})
public class TBAOrdersServlet extends HttpServlet {

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
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");
            HttpSession session = request.getSession(false);
            Boolean admin = (Boolean) session.getAttribute("admin");
            if (admin == false) {
                response.sendRedirect("BookBrowsing.jsp");
            } else {
                if (conn != null) {
                    PreparedStatement sq1 = null;
                    PreparedStatement sq2 = null;
                    ResultSet orders = null;
                    ResultSet bks = null;
                    ArrayList<ResultSet> books = new ArrayList<>();
                    try {
                        String getOrders = "SELECT DISTINCT checkoutinfo.CHECKOUTID, userinfo.fb_uname, userinfo.firstname, userinfo.lastname, userinfo.address,checkoutinfo.payment_method, checkoutinfo.delivery_method, checkoutinfo.order_time, checkoutinfo.TOTAL_PRICE, checkoutinfo.paid, checkoutinfo.cancel, checkoutinfo.ref_number FROM bookinfo INNER JOIN orderinfo ON bookinfo.bookID = orderinfo.bookID_FK INNER JOIN checkoutinfo ON checkoutinfo.checkoutID = orderinfo.checkoutID_FK INNER JOIN userinfo ON userinfo.userID = orderinfo.userID_FK WHERE orderinfo.bookcheckout = true";
                        sq1 = conn.prepareStatement(getOrders, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                        orders = sq1.executeQuery();
                        while (orders.next()) {
                            String getBooks = "SELECT orderinfo.quantity, bookinfo.bookname, bookinfo.author FROM bookinfo INNER JOIN orderinfo ON bookinfo.bookID = orderinfo.bookID_FK INNER JOIN checkoutinfo ON checkoutinfo.checkoutID = orderinfo.checkoutID_FK WHERE checkoutinfo.checkoutID = ?";
                            sq2 = conn.prepareStatement(getBooks);
                            sq2.setString(1, orders.getString("CHECKOUTID"));
                            bks = sq2.executeQuery();
                            books.add(bks);
                        }
                        orders.beforeFirst();
                        request.setAttribute("orders", orders);
                        request.setAttribute("books", books);
                        RequestDispatcher rd = request.getRequestDispatcher("orders.jsp");
                        rd.include(request, response);
                    } finally {
                        bks.close();
                        orders.close();
                        sq2.close();
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
            Logger.getLogger(TBAOrdersServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(TBAOrdersServlet.class.getName()).log(Level.SEVERE, null, ex);
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
