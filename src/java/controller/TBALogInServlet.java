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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Security;

/**
 *
 * @author karla
 */
@WebServlet(name = "TBALogInServlet", urlPatterns = {"/Login"})
public class TBALogInServlet extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>The Book Amiga Online Bookstore</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h2>Error!</h2>");

            String userEmail = request.getParameter("email").trim();
            String userPassword = request.getParameter("password").trim();

            String admin = "You are admin";
            String guest = "You are guest";

            if (conn != null) {
                String query = "SELECT * FROM userinfo WHERE email= ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, userEmail);
                ResultSet rs = ps.executeQuery();

                int ctr = 0;
                while (rs.next()) {//username match
                    String truePassword = Security.decrypt(rs.getString("password").trim());//decrypt pw
                    System.out.println(truePassword);
                    if (userPassword.equals(truePassword)) {//pasword match; Log in successful 
                        HttpSession session = request.getSession();
                        session.setMaxInactiveInterval(1200); //25 mins
                        session.setAttribute("name", rs.getString("firstname").trim());
                        session.setAttribute("userID", rs.getString("userID").trim());
                        session.setAttribute("lname", rs.getString("lastname").trim());
                        session.setAttribute("email", rs.getString("email").trim());
                        session.setAttribute("phone", rs.getString("mobile").trim());
                        session.setAttribute("fbName", rs.getString("fb_uname").trim());
                        session.setAttribute("address", rs.getString("address").trim());
                        session.setAttribute("admin", rs.getBoolean("admin"));
                        if (rs.getBoolean("admin") == true) {//for admmin account
                            //go to admin management page????
                            session.setAttribute("role", "");
                            response.sendRedirect("BookManagement");
                        } else { // for guest account
                            session.setAttribute("role", guest);
                            //go to browsing page???
                            response.sendRedirect("BookBrowsing");
                        }
//                      session.setAttribute("email", rs.getString("uname").trim());

                    } else { //password mismatch
                        String msg = "The password that you have entered is incorrect.";
                        request.setAttribute("error", msg);
                        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                        rd.forward(request, response);
                    }
                    ctr++;
                }
                if (userEmail.length() == 0 || userPassword.length() == 0) { //no input
                    String msg = "Please enter username and password";
                    request.setAttribute("error", msg);
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                } else if (ctr == 0) {//no username match 
                    String msg = "The username that you have entered does not exist.";
                    request.setAttribute("error", msg);
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
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
            Logger.getLogger(TBALogInServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(TBALogInServlet.class.getName()).log(Level.SEVERE, null, ex);
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
