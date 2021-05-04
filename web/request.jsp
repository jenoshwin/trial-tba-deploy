<%-- 
    Document   : request
    Created on : 02 25, 21, 12:33:14 AM
    Author     : karla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Book Request | The Book Amiga Online Bookstore</title>
        <link rel="stylesheet" href="css/signup_login.css">
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

            String name = (String) session.getAttribute("name");
            if (name == null) {
                response.sendRedirect("login.jsp");
            } else {
                String lastName = (String) session.getAttribute("lname");
                String mobile = (String) session.getAttribute("phone");
                String email = (String) session.getAttribute("email");
                String msg = (String) request.getAttribute("msg");

                String rBook = (String) request.getAttribute("rBook");
                String rAuthor = (String) request.getAttribute("rAuthor");

                if (rBook == null) {
                    rBook = "";
                }
                if (rAuthor == null) {
                    rAuthor = "";
                }

        %>
        <jsp:include page="header.jsp"/>
        <div class="site-container">
                <!--Request Form-->
                <div class="container-fluid" id="grad1">
                    <div class="row justify-content-center mt-0">
                        <div class="col-11 col-sm-9 col-md-7 col-lg-6 p-0 mt-3 mb-2">
                            <form class="login-form border p-4 shadow bg-white" method="POST" action="Request">
                                <p class="create-account-text text-center mb-3">Request a Book</p>
                                <!--Full Name-->
                                <div class="row">
                                    <!--First name-->
                                    <div class="col credentials">
                                        <label class="lbl-txt" for="defaultRegisterFormFirstName"><b>First Name</b></label>
                                        <input type="text" aria-required="true" id="defaultRegisterFormFirstName" class="form-control credentials bg-light text-dark" name="firstName" value="<%=name%>" readonly>
                                    </div>
                                    <!--Last name-->
                                    <div class="col credentials">
                                        <label class="lbl-txt" for="defaultRegisterFormLastName"><b>Last Name</b></label>
                                        <input type="text" aria-required="true" id="defaultRegisterFormLastName" class="form-control bg-light text-dark" name="lastName" value="<%=lastName%>" readonly>
                                    </div>
                                </div>
                                <!--Contact Details-->
                                <div class="row">
                                    <!--Email Address-->
                                    <div class="col credentials">
                                        <label class="lbl-txt" for="defaultRegisterFormFirstName"><b>Email Address</b></label>
                                        <input type="text" aria-required="true" id="defaultRegisterFormFirstName" class="form-control credentials bg-light text-dark" name="email" value="<%=email%>" readonly>
                                    </div>
                                    <!--Mobile Num-->
                                    <div class="col credentials">
                                        <label class="lbl-txt" for="defaultRegisterFormLastName"><b>Contact Information</b></label>
                                        <input type="text" aria-required="true" id="defaultRegisterFormLastName" class="form-control bg-light text-dark" name="mobile" value="0<%=mobile%>" readonly>
                                    </div>
                                </div>
                                <!--Note-->
                                <div class="text-center">
                                    <p class="text4" style="color: black;">*If you wish to change your contact information, go to the <a href="account.jsp">account profile</a> page</p>
                                </div>
                                <hr>
                                <!--Book Request-->
                                <div class="row">
                                    <div class="col">
                                        <label class="lbl-txt" for="defaultRegisterFormAddress"><b>Book Requested</b><span class="asterisk-symbol"> *</span></label>
                                        <input type="text" aria-required="true" id="defaultRegisterFormAddress" class="form-control mb-4 bg-light text-dark" name="bookReq" placeholder="Book Title Here..." value="<%=rBook%>">
                                    </div>
                                </div> 
                                <!--Author-->
                                <div class="row">
                                    <div class="col">
                                        <label class="lbl-txt" for="defaultRegisterFormAddress"><b>Author Name</b><span class="asterisk-symbol"> *</span></label>
                                        <input type="text" aria-required="true" id="defaultRegisterFormAddress" class="form-control mb-4 bg-light text-dark" name="author" placeholder="Author Name Here..." value="<%=rAuthor%>">
                                    </div>
                                </div>
                                <%if (msg != null) {%>
                                <div class="text-center">
                                    <p class="text2"style="color: red;"><big><big><%=msg%></big></big></p>
                                </div>
                                <%}%>
                                <!--Request Button-->
                                <div class="text-center mb-2">
                                    <button class="sign-up-btn my-3 font-weight-bold" type="submit">Submit</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!--Request Form-->
        </div>
        <jsp:include page="footer.jsp"/>
        <%}%>

    </body>
</html>
