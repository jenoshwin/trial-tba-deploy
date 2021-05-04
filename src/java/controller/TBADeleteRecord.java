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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Security;

/**
 *
 * @author karla
 */
public class TBADeleteRecord extends HttpServlet {

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
            String admin = (String) session.getAttribute("userID");
            if (admin == null) {
                response.sendRedirect("BookBrowsing");
            } else {
                if (conn != null) {
                    PreparedStatement ar = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        String action = request.getParameter("action").trim();

                        String deleteRecord;
                        String msg;

                        if (action.equals("order")) {
                            String[] deleteB = request.getParameterValues("orderID");
                            if (deleteB == null) {
                                request.setAttribute("msg", "Please select books to remove from cart.");
                                RequestDispatcher rd = request.getRequestDispatcher("Cart");
                                rd.forward(request, response);
                            } else {
                                for (String order : deleteB) {
                                    deleteRecord = "DELETE FROM orderinfo WHERE orderID = ?";
                                    ar = conn.prepareStatement(deleteRecord);
                                    ar.setString(1, order);
                                    ar.executeUpdate();
                                }
                            }
                            RequestDispatcher rd = request.getRequestDispatcher("Cart");
                            rd.include(request, response);
                        } else {
                            String ID = request.getParameter("ID").trim();
                            String delete = request.getParameter("delete").trim().toLowerCase();
                            String password = request.getParameter("password").trim();
                            String query = "SELECT * FROM checkoutinfo WHERE userID_FK = ? AND paid = false AND cancel = false";
                            ps = conn.prepareStatement(query);
                            ps.setString(1, ID);
                            rs = ps.executeQuery();
                            if (rs.next()) {
                                msg = "You cannot delete your account. You still have unpaid orders.";
                                request.setAttribute("msg", msg);
                                RequestDispatcher rd = request.getRequestDispatcher("deleteaccnt.jsp");
                                rd.forward(request, response);
                            } else {
                                query = "SELECT password FROM userinfo WHERE userID = ?";
                                ps = conn.prepareStatement(query);
                                ps.setString(1, ID);
                                rs = ps.executeQuery();
                                if (password.length() == 0 || delete.length() == 0) {//incomplete / no inputs
                                    msg = "Please enter all the required values";
                                    request.setAttribute("msg", msg);
                                    RequestDispatcher rd = request.getRequestDispatcher("deleteaccnt.jsp");
                                    rd.forward(request, response);
                                } else if (rs.next()) {
                                    String decrypt = Security.decrypt(rs.getString("password"));
                                    if (password.equals(decrypt) && delete.equals("delete")) {//2 passwords are the same
                                        deleteRecord = "DELETE FROM orderinfo WHERE userID_FK = ?";
                                        ar = conn.prepareStatement(deleteRecord);
                                        ar.setString(1, ID);
                                        ar.executeUpdate();
                                        deleteRecord = "DELETE FROM checkoutinfo WHERE userID_FK = ?";
                                        ar = conn.prepareStatement(deleteRecord);
                                        ar.setString(1, ID);
                                        ar.executeUpdate();
                                        deleteRecord = "DELETE FROM userinfo WHERE userID = ?";
                                        ar = conn.prepareStatement(deleteRecord);
                                        ar.setString(1, ID);
                                        ar.executeUpdate();
                                        response.sendRedirect("Logout");
                                    } else {//pw mismatch
                                        msg = "Password Mismatch!";
                                        request.setAttribute("msg", msg);
                                        RequestDispatcher rd = request.getRequestDispatcher("deleteaccnt.jsp");
                                        rd.forward(request, response);
                                    }
                                }
                            }
                        }
                    } finally {
                        rs.close();
                        ps.close();
                        ar.close();
//                    }

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
