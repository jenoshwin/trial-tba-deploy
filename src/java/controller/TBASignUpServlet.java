/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import model.Security;
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

/**
 *
 * @author karla
 */
@WebServlet(name = "TBASignUpServlet", urlPatterns = {"/Signup"})
public class TBASignUpServlet extends HttpServlet {

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
            String firstName = request.getParameter("firstName").trim();
            String lastName = request.getParameter("lastName").trim();
            String email = request.getParameter("email").trim();
            String fb = request.getParameter("fbUname").trim();
            String contact = request.getParameter("phone").trim();
            String password = request.getParameter("password").trim();
            String cpassword = request.getParameter("cpassword").trim();
            String address = request.getParameter("address").trim();
            String postal = request.getParameter("postalcode").trim();
            String city = request.getParameter("city").trim();
            String region = request.getParameter("region").trim();
            String addAddress = request.getParameter("aptoptional").trim();
            if (conn != null) {
                //Check if there is existing email
                String query = "SELECT * FROM userinfo WHERE email = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();
                if (firstName.length() == 0 || lastName.length() == 0 || email.length() == 0 || contact.length() == 0 || fb.length() == 0
                        || password.length() == 0 || cpassword.length() == 0 || address.length() == 0 || postal.length() == 0
                        || city.length() == 0 || region.length() == 0) {//incomplete / no inputs
                    String msg = "Please enter all the required values";
                    request.setAttribute("fname", firstName);
                    request.setAttribute("lname", lastName);
                    request.setAttribute("email", email);
                    request.setAttribute("fbName", fb);
                    request.setAttribute("contact", contact);
                    request.setAttribute("address", address);
                    request.setAttribute("postal", postal);
                    request.setAttribute("city", city);
                    request.setAttribute("optional", addAddress);
                    request.setAttribute("msg", msg);
                    RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                    rd.forward(request, response);
                } else if (!rs.next()) {//no duplicates
                    if (password.equals(cpassword)) {//2 passwords are the same
                        String encrypt = Security.encrypt(password);
                        String comAddress = "Address;;"+address + "City;;" + city + "Postal;;" + postal + "Region;;" + region + "Additional;;" + addAddress;
                        String addRecord = "INSERT INTO userinfo (email, firstname, lastname, mobile, address, password, fb_uname) VALUES (?, ?, ?,?,?, ?, ?)";
                        PreparedStatement ar = conn.prepareStatement(addRecord);
                        ar.setString(1, email);
                        ar.setString(2, firstName);
                        ar.setString(3, lastName);
                        ar.setString(4, contact);
                        ar.setString(5, comAddress);
                        ar.setString(6, encrypt);
                        ar.setString(7, fb);
                        ar.executeUpdate();
                        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                        rd.forward(request, response);
                        response.sendRedirect("login.jsp");
                    } else {//pw mismatch
                        String msg = "Password Mismatch!";
                        request.setAttribute("fname", firstName);
                        request.setAttribute("lname", lastName);
                        request.setAttribute("email", email);
                        request.setAttribute("contact", contact);
                        request.setAttribute("fbName", fb);
                        request.setAttribute("address", address);
                        request.setAttribute("postal", postal);
                        request.setAttribute("city", city);
                        request.setAttribute("optional", addAddress);
                        request.setAttribute("msg", msg);
                        RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                        rd.forward(request, response);
                    }

                } else {
                    String msg = "Email already taken";
                    request.setAttribute("fname", firstName);
                    request.setAttribute("lname", lastName);
                    request.setAttribute("email", email);
                    request.setAttribute("contact", contact);
                    request.setAttribute("address", address);
                    request.setAttribute("fbName", fb);
                    request.setAttribute("postal", postal);
                    request.setAttribute("city", city);
                    request.setAttribute("optional", addAddress);
                    request.setAttribute("msg", msg);
                    RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
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
            Logger.getLogger(TBASignUpServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(TBASignUpServlet.class.getName()).log(Level.SEVERE, null, ex);
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
