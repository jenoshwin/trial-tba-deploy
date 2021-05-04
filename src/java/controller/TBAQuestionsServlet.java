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
import java.util.Objects;
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
 * @author Ash
 */
@WebServlet(name = "TBAQuestionsServlet", urlPatterns = {"/Questions"})
public class TBAQuestionsServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try {
            HttpSession session;
            session = request.getSession();
            session.setMaxInactiveInterval(1200);
            String userEmail = (String) session.getAttribute("email");
            String userNum = request.getParameter("mobile").trim().toLowerCase();
            String userName = request.getParameter("lname").trim().toLowerCase();

            if (conn != null) {
                String query = "SELECT * FROM userinfo WHERE email=?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, userEmail);
                ResultSet rs = ps.executeQuery();

                int ctr = 0;

                while (rs.next()) {
                    String a = rs.getString("mobile").toLowerCase();
                    String b = rs.getString("lastname").toLowerCase();
                    boolean c = Objects.equals(a, userNum);
                    getServletContext().log(a + " " + b);
                    getServletContext().log(userNum + " " + userName);
                    getServletContext().log(c + " ");

                    if (Objects.equals(a, userNum) && Objects.equals(b, userName)) {
                        getServletContext().log("before redirect");
                        session.setAttribute("mobile", a);
                        session.setAttribute("lname", b);
                        response.sendRedirect("resetpassword.jsp");
                    }
                    ctr++;
                }
                if (userNum.length() == 0 || userName.length() == 0) {
                    String msg = "Please enter all the required values";
                    request.setAttribute("error", msg);
                    RequestDispatcher rd = request.getRequestDispatcher("questions.jsp");
                    rd.forward(request, response);
                } else if (ctr == 0) {
                    String msg = "Please enter the correct credentials.";
                    request.setAttribute("error", msg);
                    RequestDispatcher rd = request.getRequestDispatcher("questions.jsp");
                    rd.forward(request, response);
                } else {
                    getServletContext().log("inside else");
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Incorrect Credentials');");
                    out.println("window.location.href = \"questions.jsp\";");
                    out.println("</script>");
//                    RequestDispatcher rd = request.getRequestDispatcher("questions.jsp");
//                    rd.forward(request, response);
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