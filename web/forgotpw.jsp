<%-- 
    Document   : forgotpw
    Created on : 03 11, 21, 3:14:31 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password</title>
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
    <body data-spy="scroll"  style="background-color: #FFF9C4;">
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");

            String name = (String) session.getAttribute("name");
            String msg = (String) request.getAttribute("msg");
            String error = (String) request.getAttribute("error");
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
                    <form id="resetForm" class="sign-up-form border p-4 shadow bg-white" action="ForgotPW" method="POST">
                        <p class="create-account-text text-center mb-3">Forgot Your Password</p>
                        <div class="credentials">
                            <center>
                                <p>
                                    Please enter your login email, we'll have you answer a couple security questions.
                                </p>
                            </center>

                            <%if (error != null) {%>
                            <p style='color:red; text-align: center;'><%=error%></p>
                            <%}%>
                            <!--Email-->
                            <label class="lbl-txt" for="defaultRegisterFormEmail"><b>Email Address</b><span class="asterisk-symbol"> *</span></label>
                            <input type="email" id="defaultRegisterFormEmail" class="form-control mb-4 bg-light text-dark"
                                   name="email">
                        </div>
                        <div class="text-center actions">
                            <button class="sign-up-btn my-3 font-weight-bold" type="submit">Verify my email</button>
                        </div>

                        <script type="text/javascript">

                            $(document).ready(function () {
                                $("#resetForm").validate({
                                    rules: {
                                        email: {
                                            required: true,
                                            email: true
                                        }
                                    },

                                    messages: {
                                        email: {
                                            required: "Please enter email",
                                            email: "Please enter a valid email address"
                                        }
                                    }
                                });

                            });
                        </script>
                    </form>
                </div>
            </div>
        </div>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>

        <jsp:include page="footer.jsp"/>

    </body>
</html>
