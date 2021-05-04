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
public class TBAUpdateBookServlet extends HttpServlet {

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
                    try {
                        String action = request.getParameter("action").trim();
                        String cover = request.getParameter("bookcover").trim();
                        String name = request.getParameter("bookname").trim();
                        String author = request.getParameter("author").trim();
                        String isbn = request.getParameter("isbn").trim();
                        String genre = request.getParameter("genre").trim();
                        String pdate = request.getParameter("pdate").trim();
                        String price = request.getParameter("price").trim();
                        String stock = request.getParameter("stock").trim();
                        String weight = request.getParameter("weight").trim();
                        String desc = request.getParameter("bdesc").trim();
                        if (action.equals("add")) {
                            String addRecord = "INSERT INTO bookinfo (bookcover, bookname, author, isbn, genre, bookdesc, publish_date, price, stock, weight) VALUES (?,?,?,?,?,?,?,?,?,?)";
                            sq1 = conn.prepareStatement(addRecord);
                            sq1.setString(1, cover);
                            sq1.setString(2, name);
                            sq1.setString(3, author);
                            sq1.setString(4, isbn);
                            sq1.setString(5, genre);
                            sq1.setString(6, desc);
                            sq1.setString(7, pdate);
                            sq1.setString(8, price);
                            sq1.setString(9, stock);
                            sq1.setString(10, weight);
                            sq1.executeUpdate();
                        } else {
                            String bookID = request.getParameter("bookID").trim();
                            String addRecord = "UPDATE bookinfo SET bookcover = ? , bookname = ?, author = ?, isbn = ?, genre = ? , bookdesc = ? , publish_date = ?, price = ?, stock = ?, weight = ? WHERE bookID = ?";
                            sq1 = conn.prepareStatement(addRecord);
                            sq1.setString(1, cover);
                            sq1.setString(2, name);
                            sq1.setString(3, author);
                            sq1.setString(4, isbn);
                            sq1.setString(5, genre);
                            sq1.setString(6, desc);
                            sq1.setString(7, pdate);
                            sq1.setString(8, price);
                            sq1.setString(9, stock);
                            sq1.setString(10, weight);
                            sq1.setString(11, bookID);
                            sq1.executeUpdate();
                        }
                        response.sendRedirect("BookManagement");
                    } finally {
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
            Logger.getLogger(TBAUpdateBookServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(TBAUpdateBookServlet.class.getName()).log(Level.SEVERE, null, ex);
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
