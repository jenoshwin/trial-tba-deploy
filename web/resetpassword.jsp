<%-- 
    Document   : resetpassword
    Created on : 04 5, 21, 4:41:40 PM
    Author     : Ash
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reset Password</title>
        <!--CSS files-->
        <link rel="stylesheet" href="css/navbar_style.css">
        <link rel="stylesheet" href="css/signup_login.css">
        <link rel="stylesheet" href="css/navbar_style2.css">
        <link rel="icon" href="images/TBAIcon.jpg">
        <!--Google fonts-->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
        <!--Font awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!--Bootstrap 4-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

        String msg = (String) request.getAttribute("msg");
    %>

    <jsp:include page="header.jsp"/>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <div class="container-fluid" id="grad2">
        <div class="row justify-content-center mt-0">
            <div class="col-11 col-sm-9 col-md-7 col-lg-6 p-0 mt-3 mb-2">
                <form id="resetForm" class="sign-up-form border p-4 shadow bg-white" action="ResetPassword" method="POST">
                    <p class="create-account-text text-center mb-3">Reset your Password</p>
                    <div class="credentials">
                        <center>
                            <p>
                                Please enter your new password.  
                            </p>
                        </center>

                        <%if (msg != null) {%>
                        <p style='color:red; text-align: center;'><%=msg%></p>
                        <%}%>

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
                                       class="credentials"  name="conPassword" onkeyup="check();"maxlength="20"/>
                            </div>
                            <span id="message"></span>
                        </div>
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

                    <div class="text-center actions">
                        <button class="sign-up-btn my-3 font-weight-bold" type="submit">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <br>
    <br>
    <br>
    <jsp:include page="footer.jsp"/>
</body>
</html>
