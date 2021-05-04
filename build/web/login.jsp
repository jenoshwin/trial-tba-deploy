<%-- 
    Document   : genre
    Created on : 02 25, 21, 12:07:53 AM
    Author     : karla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Log In | The Book Amiga Online Bookstore</title>
        <!--CSS files-->
        <link rel="stylesheet" href="css/signup_login.css">
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
        <div class="site-container">
            <main class="site-content">
                <!--Login Form-->
                <div class="container-fluid" id="grad1">
                    <div class="row justify-content-center mt-0">
                        <div class="col-11 col-sm-9 col-md-7 col-lg-6 p-0 mt-3 mb-2">
                            <%if (msg != null) {%>
                            <p class="create-account-text text-center mb-3"><%=msg%></p>
                            <%}%>
                            <form class="login-form border p-4 shadow bg-white" method="POST" action="Login">
                                <div class="credentials">
                                    <p class="create-account-text text-center mb-3">Log In</p>
                                    <%if (error != null) {%>
                                    <p style='color:red; text-align: center;'><%=error%></p>
                                    <%}%>
                                    <!--Email-->
                                    <label class="lbl-txt" for="defaultRegisterFormEmail"><b>Email Address</b><span class="asterisk-symbol"> *</span></label>
                                    <input type="email" id="defaultRegisterFormEmail" class="form-control mb-4 bg-light text-dark"
                                           name="email">
                                    <!--Password-->
                                    <label class="lbl-txt" for="defaultRegisterFormEmail"><b>Password</b><span class="asterisk-symbol"> *</span></label>
                                    <input type="password" id="defaultRegisterFormPassword" class="form-control mb-4 bg-light text-dark"
                                           aria-describedby="defaultRegisterFormPasswordHelpBlock" name="password">
                                    <a href="forgotpw.jsp" class="text2">Forgot your password?</a>
                                </div>
                                <!--Log In button-->
                                <div class="text-center actions">
                                    <button class="sign-up-btn my-3 font-weight-bold" disabled ="disabled" type="submit">Log In</button>
                                    <p class="text2">Don't have an account yet? <a href="signup.jsp">Sign Up</a></p>
                                </div>

                                <script>
                                    $(document).ready(function () {
                                        $('.credentials input').on('keyup', function () {
                                            let empty = false;

                                            $('.credentials input').each(function () {
                                                empty = $(this).val().length === 0;
                                            });

                                            if (empty)
                                                $('.actions button').attr('disabled', 'disabled');
                                            else
                                                $('.actions button').attr('disabled', false);
                                        });
                                    });
                                </script>

                            </form>
                        </div>
                    </div>
                </div>
                <!--Login Form-->
            </main>
            <jsp:include page="footer.jsp"/>
        </div>
    </body>
</html>
