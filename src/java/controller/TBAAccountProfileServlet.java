package controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author karla
 */
public class TBAAccountProfileServlet extends HttpServlet {

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
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");
            HttpSession session = request.getSession(false);
            if (session.getAttribute("userID") == null) {
                response.sendRedirect("BookBrowsing");
            } else {
                if (conn != null) {
                    PreparedStatement ar = null;
                    try {
                        /* TODO output your page here. You may use following sample code. */
                        String userID = request.getParameter("userID").trim();
                        out.println("AAA");

                        String firstName = request.getParameter("firstName").trim();
                        out.println("AAA");

                        String lastName = request.getParameter("lastName").trim();
                        out.println("AAA");

                        String email = request.getParameter("email").trim();
                        String fb = request.getParameter("fb").trim();
                        out.println(fb);

                        String mobile = request.getParameter("mobile").trim();
                        out.println("AAA");

                        String address = request.getParameter("address").trim();
                        out.println("AAA");

                        String postal = request.getParameter("postalcode").trim();
                        out.println("AAA");

                        String city = request.getParameter("city").trim();
                        out.println("CCC");

                        String region = request.getParameter("region").trim();
                        out.println("BBB");

                        String addAddress = request.getParameter("aptoptional").trim();

                        String comAddress = "Address;;" + address + "City;;" + city + "Postal;;" + postal + "Region;;" + region + "Additional;;" + addAddress;
                        out.println(comAddress);
                        String updateRecord = "UPDATE userinfo SET email=?, firstname=?, lastname=?, mobile=?, address=?,fb_uname=? WHERE userID=?";

                        ar = conn.prepareStatement(updateRecord);
                        ar.setString(1, email);
                        ar.setString(2, firstName);
                        ar.setString(3, lastName);
                        ar.setString(4, mobile);
                        ar.setString(5, comAddress);
                        ar.setString(6, fb);
                        ar.setString(7, userID);
                        ar.executeUpdate();
                        session.setAttribute("name", firstName);
                        session.setAttribute("lname", lastName);
                        session.setAttribute("fbName", fb);
                        session.setAttribute("email", email);
                        session.setAttribute("phone", mobile);
                        session.setAttribute("address", comAddress);
                        request.setAttribute("msg", "Your information has been updated!");
                        RequestDispatcher rd = request.getRequestDispatcher("account.jsp");
                        rd.forward(request, response);

                    } finally {
                        ar.close();
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
