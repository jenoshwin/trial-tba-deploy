/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.itextpdf.text.DocumentException;
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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.MakePDF;

/**
 *
 * @author karla
 */
public class TBAPDFServlet extends HttpServlet {

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
            throws ServletException, IOException, DocumentException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if (conn != null) {
                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
                response.setHeader("Pragma", "no-cache");
                response.setHeader("Expires", "0");
                HttpSession session = request.getSession(false);
                Boolean admin = (Boolean) session.getAttribute("admin");
                String adminName = (String) session.getAttribute("name") + " " + (String) session.getAttribute("lname");
                String action = request.getParameter("action").trim();
                String query = null;
                PreparedStatement ar = null;
                PreparedStatement ps = null;
                ResultSet orders = null;
                ResultSet bks = null;
                String msg = null;
                RequestDispatcher rd  = null;
                try {
                    if (admin == false) {
                        response.sendRedirect("BookBrowsing.jsp");
                    } else {
                        switch (action) {
                            case "request":
                                query = "SELECT requestID, firstname, lastname, email, bookname, author FROM requestbook";
                                ar = conn.prepareStatement(query);
                                orders = ar.executeQuery();
                                new MakePDF().dlUser(adminName, orders, action);
                                msg = "Download Success!";
                                request.setAttribute("msg", msg);
                                rd = request.getRequestDispatcher("BookRequests");
                                rd.forward(request, response);
                                break;
                            case "archive":
                                query = "SELECT * FROM archiveinfo";
                                ar = conn.prepareStatement(query);
                                orders = ar.executeQuery();
                                new MakePDF().dlUser(orders, action);
                                msg = "Download Success!";
                                request.setAttribute("msg", msg);
                                rd = request.getRequestDispatcher("Archives");
                                rd.forward(request, response);
                                break;
                            case "order":
                                ArrayList<ResultSet> books = new ArrayList<>();
                                String getOrders = "SELECT DISTINCT checkoutinfo.CHECKOUTID, userinfo.firstname, userinfo.fb_uname, userinfo.lastname, userinfo.address, checkoutinfo.payment_method, checkoutinfo.delivery_method, checkoutinfo.order_time, checkoutinfo.TOTAL_PRICE, checkoutinfo.paid, checkoutinfo.cancel FROM bookinfo INNER JOIN orderinfo ON bookinfo.bookID = orderinfo.bookID_FK INNER JOIN checkoutinfo ON checkoutinfo.checkoutID = orderinfo.checkoutID_FK INNER JOIN userinfo ON userinfo.userID = orderinfo.userID_FK WHERE orderinfo.bookcheckout = true AND checkoutinfo.paid = true ORDER BY checkoutinfo.checkoutid DESC";
                                ar = conn.prepareStatement(getOrders, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                                orders = ar.executeQuery();
                                while (orders.next()) {
                                    String getBooks = "SELECT orderinfo.quantity, bookinfo.bookname, bookinfo.author FROM bookinfo INNER JOIN orderinfo ON bookinfo.bookID = orderinfo.bookID_FK INNER JOIN checkoutinfo ON checkoutinfo.checkoutID = orderinfo.checkoutID_FK WHERE checkoutinfo.checkoutID = ?";
                                    ps = conn.prepareStatement(getBooks);
                                    ps.setString(1, orders.getString("CHECKOUTID"));
                                    bks = ps.executeQuery();
                                    books.add(bks);
                                }
                                orders.beforeFirst();
                                new MakePDF().dlUser(adminName, orders, books, action);
                                msg = "Download Success!";
                                request.setAttribute("msg", msg);
                                rd = request.getRequestDispatcher("Orders");
                                rd.forward(request, response);
                        }

//                        if (action.equals("order")) {
//                            query = "SELECT checkoutinfo.CHECKOUTID, userinfo.firstname, userinfo.lastname, orderinfo.quantity ,bookinfo.bookname, bookinfo.author, checkoutinfo.payment_method, checkoutinfo.delivery_method, checkoutinfo.order_time, orderinfo.PRICE FROM bookinfo INNER JOIN orderinfo ON bookinfo.bookID = orderinfo.bookID_FK INNER JOIN checkoutinfo ON checkoutinfo.checkoutID = orderinfo.checkoutID_FK INNER JOIN userinfo ON userinfo.userID = orderinfo.userID_FK WHERE orderinfo.bookcheckout = true AND checkoutinfo.paid = true";
//                        } else {
//                            query = "SELECT requestID, firstname, lastname, email, bookname, author FROM requestbook";
//                        }
//                        ar = conn.prepareStatement(query);
//                        orders = ar.executeQuery();
//                        new MakePDF().dlUser(adminName, orders, action);
//                        String msg = "Download Success!";
//                        request.setAttribute("msg", msg);
//                        RequestDispatcher rd = null;
//                        if (action.equals("order")) {
//                            rd = request.getRequestDispatcher("Orders");
//                        } else {
//                            rd = request.getRequestDispatcher("BookRequests");
//                        }
//                        rd.forward(request, response);
                    }
                } finally {
                    orders.close();
                    ar.close();
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
        } catch (DocumentException ex) {
            Logger.getLogger(TBAPDFServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (DocumentException ex) {
            Logger.getLogger(TBAPDFServlet.class.getName()).log(Level.SEVERE, null, ex);
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
