<%-- 
    Document   : Password
    Created on : 03 12, 21, 10:12:43 PM
    Author     : Matthew Artillero
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Customer Profile - Change Password</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--CSS files-->
        <link rel="stylesheet" href="css/vieworders-changepw_style.css">
        <link rel="stylesheet" href="css/navbar_style.css">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Chivo:wght@400&display=swap" rel="stylesheet">
        <link rel="icon" href="images/TBAIcon.jpg">
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");

            String userID = (String) session.getAttribute("userID");
            Boolean admin = (Boolean) session.getAttribute("admin");
            if (userID == null) {
                response.sendRedirect("login.jsp");
            } else {
                String msg = (String) request.getAttribute("msg");

                if (admin == true) {%>
        <jsp:include page="admin-header.jsp"/>
        <%} else {%>
        <jsp:include page="header.jsp"/>
        <%}%>
        <div class="site-container">
            <main class="site-content">
                <h4><strong>Change Password</strong></h4>
                <div class="container">
                    <form method="POST" action="ChangePassword">
                        <input type="hidden" name="userID" value="<%=userID%>">
                        <div class="profile-form p-5"> 
                            <%if (msg != null) {%>
                            <p style='color:red; text-align: center;'><%=msg%></p>
                            <%}%>
                            <div class="row row-credentials mb-3">
                                <div class="col-3">
                                    <label class="credentials-label">Current Password</label>
                                </div>
                                <div class="col-9">
                                    <input type = "password"
                                           id = "origPass"
                                           class="credentials"
                                           name="origPassword"/>
                                </div>
                            </div>
                            <div class="row row-credentials mb-3">
                                <div class="col-3">
                                    <label class="credentials-label">New Password</label>
                                </div>
                                <div class="col-9">
                                    <input type = "password"
                                           id = "newPass"
                                           class="credentials"
                                           name="newPassword" maxlength="20"/>                                    
                                </div>
                            </div>
                            <div class="row row-credentials mb-4">
                                <div class="col-3">
                                    <label class="credentials-label">Confirm New Password</label>
                                </div>
                                <div class="col-9">
                                    <input type = "password"
                                           id = "conPass"
                                           class="credentials"  name="conPassword" onkeyup="check();"/>
                                </div>
                                <span id="message"></span>
                            </div>

                            <script>

                                document.getElementById('newPass').onkeyup = function () {
                                    var val;
                                    if (!textLength(this.value)) {
                                        val = 'Password must have 8 - 20 characters';
                                    } else {
                                        val = '';
                                    }
                                    document.getElementById('message').style.color = 'red';
                                    document.getElementById('message').innerHTML = val;

                                }
                                function textLength(value) {
                                    var minLength = 8;
                                    if (value.length < minLength)
                                        return false;
                                    return true;
                                }
                                var check = function () {
                                    if (document.getElementById('newPass').value ==
                                            document.getElementById('conPass').value) {
                                        document.getElementById('message').style.color = 'green';
                                        document.getElementById('message').innerHTML = 'Password Matched!';
                                    } else {
                                        document.getElementById('message').style.color = 'red';
                                        document.getElementById('message').innerHTML = 'Password Not Matched!';
                                    }
                                }
                            </script>

                            <div class="text-center">
                                <a href="account.jsp" class="cancel-btn" style="text-decoration: none">                   
                                    Cancel
                                </a>
                                <button type="submit" class="savechanges-btn">                   
                                    Save Changes
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                <br>
                <br>
            </main>
            <%}%>
            <%if (admin == true) {
                } else {%>
            <jsp:include page="footer.jsp"/>
            <%}%>
        </div>
    </body>
</html>

