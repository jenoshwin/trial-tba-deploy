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
 * @author Ash
 */
@WebServlet(name = "TBAResetPasswordServlet", urlPatterns = {"/ResetPassword"})
public class TBAResetPasswordServlet extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session;
            session = request.getSession();
            session.setMaxInactiveInterval(1200);
            String userEmail = (String) session.getAttribute("email");
            String newP = request.getParameter("newPassword").trim();
            String conP = request.getParameter("conPassword").trim();
            if (conn != null) {
                //Check if there is existing email
                String query = "SELECT password FROM userinfo WHERE email = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, userEmail);
                ResultSet rs = ps.executeQuery();
                if (newP.length() == 0 || conP.length() == 0) {//incomplete / no inputs
                    String msg = "Please enter all the required values";
                    request.setAttribute("msg", msg);
                    RequestDispatcher rd = request.getRequestDispatcher("resetpassword.jsp");
                    rd.forward(request, response);
                } else if (rs.next()) {
                    String decrypt = Security.decrypt(rs.getString("password"));
                    if (newP.equals(conP)) {//2 passwords are the same
                        String encrypt = Security.encrypt(newP);
                        String msg = "Password Updated!";
                        String updatePw = "UPDATE userinfo SET password=? WHERE email=?";
                        PreparedStatement ar = conn.prepareStatement(updatePw);
                        ar.setString(1, encrypt);
                        ar.setString(2, userEmail);
                        ar.executeUpdate();
                        request.setAttribute("msg", msg);
                        RequestDispatcher rd = request.getRequestDispatcher("resetpassword.jsp");
                        rd.forward(request, response);
                    } else {//pw mismatch
                        String msg = "Password Mismatch!";
                        request.setAttribute("msg", msg);
                        RequestDispatcher rd = request.getRequestDispatcher("resetpassword.jsp");
                        rd.forward(request, response);
                    }
                } else {
                    response.sendRedirect("Logout");
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