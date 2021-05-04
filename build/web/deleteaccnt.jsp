<%-- 
    Document   : deleteaccnt
    Created on : 04 2, 21, 4:22:23 PM
    Author     : karla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Customer Profile | Delete Account</title>
        <link rel="stylesheet" href="css/signup_login.css">
        <link rel="stylesheet" href="css/navbar_style.css">
        <!--Google fonts-->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
        <!--Font awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!--Bootstrap 4-->
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

                String error = (String) request.getAttribute("msg");
                if (admin == true) {%>
        <jsp:include page="admin-header.jsp"/>
        <%} else {
        %>

        <jsp:include page="header.jsp"/><%}%>
        <br>
        <br>
        <div class="site-container">
            <main class="site-content">
                <!--Account Page-->
                <div class="container-fluid" id="grad4">
                    <div class="row justify-content-center mt-0">
                        <div class="col-11 col-sm-9 col-md-7 col-lg-6 p-0 mt-3 mb-2">
                            <form class="login-form border p-4 shadow bg-white" method="POST" action="DeleteRecord">
                                <p class="create-account-text text-center mb-3">Delete my Account</p>
                                <input type="hidden"name="ID" value="<%=userID%>">
                                <input type="hidden"name="action" value="account">
                                <div class="text-center">
                                    <p class="text2"style="color: orange;">To confirm your action, complete the following fields</p>
                                </div>
                                <br>
                                <%if (error != null) {%>
                                <p style='color:red; text-align: center;'><%=error%></p>
                                <%}%>
                                <!--Full Name-->
                                <div class ="credentials"><center>                                                                                                                                                                                                                
                                        <div class="col row-credentials mb-3">
                                            <div class="row-3">
                                                <label class="lbl-txt credentials-label" style="margin-bottom: 4%;">Current Password</label>
                                            </div>
                                            <div class="row-9">
                                                <input type = "password" id = "origPass" class="form-control edit-form bg-light text-dark" name="password"/>
                                            </div>
                                        </div>
                                        <div class="col row-credentials mb-3">
                                            <div class="row-3">
                                                <label class="lbl-txt credentials-label" style="margin-bottom: 4%;">To confirm, type "DELETE"</label>
                                            </div>
                                            <div class="row-9">
                                                <input type = "text" id = "confirm" class="form-control edit-form bg-light text-dark" name="delete" onkeyup="check();" />
                                            </div>
                                            <span id="message"></span>
                                        </div>
                                    </center></div>
                                <script>
                                    var check = function () {
                                        var conDel = document.getElementById('confirm').value;
                                        if (conDel.toLowerCase() === 'delete') {
                                        } else {
                                            document.getElementById('button').removeAttribute('disabled');
                                        }
                                    }
                                </script>
                                <!--Request Button-->
                                <div class="request-changepw text-center">
                                    <a class="changepw-btn my-3 font-weight-bold" type="submit" href="account.jsp">Back</a>
                                    <button class="savechanges-btn my-3 font-weight-bold" id="button" style="background-color: red;" type="submit" disabled>Delete My Account</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!--Account Page-->
            </main>
            <br>
            <br>
            <%if (admin == true) {
                } else {%>
            <jsp:include page="footer.jsp"/>
            <%}%>
            <%}%>

        </div>

    </body>
</html>
