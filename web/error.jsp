<%-- 
    Document   : error
    Created on : 02 14, 21, 4:23:11 AM
    Author     : karla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    if (session.getAttribute("explain") == null) {
        response.sendRedirect("index.html");
    } else {

        String reason = (String) session.getAttribute("explain");
        out.print("<h3 style='color:red'>" + reason + "</h3>");
    }
%>
<form method="post" action="BookBrowsing">
    <button type="submit" >Go Back</button>
</form>
</body>
</html>
