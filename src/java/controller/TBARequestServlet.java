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
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author karla
 */
public class TBARequestServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            if (conn != null) {
                PreparedStatement ar = null;
                try {
                    /* TODO output your page here. You may use following sample code. */
                    String firstName = request.getParameter("firstName").trim();
                    String lastName = request.getParameter("lastName").trim();
                    String email = request.getParameter("email").trim();
                    String bookReq = request.getParameter("bookReq").trim();
                    String author = request.getParameter("author").trim();

                    if (bookReq.length() == 0 || author.length() == 0) { //no input
                        String msg = "Please complete all the fields";
                        request.setAttribute("msg", msg);
                        request.setAttribute("rBook", bookReq);
                        request.setAttribute("rAuthor", author);
                        RequestDispatcher rd = request.getRequestDispatcher("request.jsp");
                        rd.forward(request, response);
                    } else {

                        String addRecord = "INSERT INTO requestbook (firstname, lastname, email, bookname, author) VALUES (?, ?, ?, ?, ?)";
                        ar = conn.prepareStatement(addRecord);
                        ar.setString(1, firstName);
                        ar.setString(2, lastName);
                        ar.setString(3, email);
                        ar.setString(4, bookReq);
                        ar.setString(5, author);
                        ar.executeUpdate();
                        request.setAttribute("msg", "Your request has been submitted!");
                        RequestDispatcher rd = request.getRequestDispatcher("request.jsp");
                        rd.forward(request, response);
                    }
                } finally {
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
