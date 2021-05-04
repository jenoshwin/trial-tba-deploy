<%-- 
    Document   : questions
    Created on : 04 5, 21, 4:20:12 PM
    Author     : Ash
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Security Questions</title>
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

        String name = (String) session.getAttribute("name");
        String email = (String) request.getAttribute("email");
        String mobile = (String) request.getAttribute("mobile");
        String lname = (String) request.getAttribute("lname");
        String msg = (String) request.getAttribute("msg");
        String error = (String) request.getAttribute("error");

        if (email == null) {
            email = "";
        }
        if (mobile == null) {
            mobile = "";
        }
        if (lname == null) {
            lname = "";
        }

    %>

    <jsp:include page="header.jsp"/>
    <br>
    <br>
    <br>
    <br>
    <div class="container-fluid" id="grad2">
        <div class="row justify-content-center mt-0">
            <div class="col-11 col-sm-9 col-md-7 col-lg-6 p-0 mt-3 mb-2">
                <form id="resetForm" class="sign-up-form border p-4 shadow bg-white" action="Questions" method="POST">
                    <p class="create-account-text text-center mb-3">Security Questions</p>
                    <%if (msg != null) {%>
                    <p style='color:red; text-align: center;'><%=msg%></p>
                    <%}%>
                    <div class="credentials">
                        <center>
                            <p>
                                Please answer all the security questions.
                            </p>
                        </center>
                        <div class="row row-credentials mb-3">
                            <!--Postal Code-->
                            <div class="col credentials">
                                <label class="lbl-txt" for="defaultRegisterFormLastName"><b>Last Name</b><span class="asterisk-symbol"> *</span></label>
                                <input type="text" aria-required="true" id="defaultRegisterFormLastName" class="form-control credentials bg-light text-dark" name="lname" value="<%=lname%>">
                            </div>
                        </div>
                        <div class="row row-credentials mb-3">
                            <!--Mobile Number-->
                            <div class="col credentials">
                                <label class="lbl-txt" for="defaultRegisterFormPhone"><b>Mobile Number</b><span class="asterisk-symbol"> *</span></label>
                                <div class="input-group mb-3">
                                    <div class="input-group-append">
                                        <span class="input-group-text">+63</span>
                                    </div>
                                    <input type="number" aria-required="true" id="defaultRegisterFormPhone" class="form-control bg-light text-dark" name="mobile" value="<%=mobile%>" pattern="/^-?\d+\.?\d*$/" onKeyPress="if(this.value.length>=10) return false;">
                                </div>
                            </div>
                        </div>
                        <div class="text-center actions">
                            <button class="sign-up-btn my-3 font-weight-bold" type="submit">Submit</button>
                        </div>
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
