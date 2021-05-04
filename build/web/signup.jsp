<%-- 
    Document   : signup
    Created on : 02 13, 21, 3:27:03 PM
    Author     : karla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign Up</title>
        <!--CSS files-->
        <link rel="stylesheet" href="css/signup_login.css">
        <!--Google fonts-->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
        <!--Font Awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!--Images-->
        <link rel="icon" href="images/TBAIcon.jpg">
    </head>

    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");

            if (session.getAttribute("role") != null) {
                response.sendRedirect("BookBrowsing");
            } else {
                String msg = (String) request.getAttribute("msg");
                String fname = (String) request.getAttribute("fname");
                String lname = (String) request.getAttribute("lname");
                String email = (String) request.getAttribute("email");
                String contact = (String) request.getAttribute("contact");
                String fb = (String) request.getAttribute("fbName");
                String address = (String) request.getAttribute("address");
                String postal = (String) request.getAttribute("msg");
                String city = (String) request.getAttribute("city");
                String optional = (String) request.getAttribute("optional");

                if (fname == null) {
                    fname = "";
                }
                if (lname == null) {
                    lname = "";
                }
                if (email == null) {
                    email = "";
                }
                if (contact == null) {
                    contact = "";
                }
                if (fb == null) {
                    fb = "";
                }
                if (address == null) {
                    address = "";
                }
                if (postal == null) {
                    postal = "";
                }
                if (city == null) {
                    city = "";
                }
                if (optional == null) {
                    optional = "";
                }

        %>

        <jsp:include page="header.jsp"/>
        <div class="site-container">
            <main class="site-content">
                <!--Sign Up Form - Part 1-->
                <div class="container-fluid" id="grad2">
                    <div class="row justify-content-center mt-0">
                        <div class="col-11 col-sm-9 col-md-7 col-lg-6 p-0 mt-3 mb-2">
                            <form class="sign-up-form border p-4 shadow bg-white" action="Signup" method="POST">
                                <p class="create-account-text text-center mb-3">Create Account</p>
                                <div class="grid">
                                    <%if (msg != null) {%>
                                    <p style='color:red; text-align: center;'><%=msg%></p>
                                    <%}%>
                                    <!--First name & Last name-->
                                    <div class="row">
                                        <!--First name-->
                                        <div class="col credentials">
                                            <label class="lbl-txt" for="defaultRegisterFormFirstName"><b>First Name</b><span class="asterisk-symbol"> *</span></label>
                                            <input type="text" aria-required="true" id="defaultRegisterFormFirstName" class="form-control credentials bg-light text-dark" name="firstName" value="<%=fname%>">
                                        </div>
                                        <!--Last name-->
                                        <div class="col credentials">
                                            <label class="lbl-txt" for="defaultRegisterFormLastName"><b>Last Name</b><span class="asterisk-symbol"> *</span></label>
                                            <input type="text" aria-required="true" id="defaultRegisterFormLastName" class="form-control bg-light text-dark" name="lastName" value="<%=lname%>">
                                        </div>
                                    </div>
                                    <!--Email n Mobile-->   
                                    <div class="row fields-b"> 
                                        <!--Email-->
                                        <div class="col credentials">
                                            <label class="lbl-txt" for="defaultRegisterFormEmail"><b>Email Address</b><span class="asterisk-symbol"> *</span></label>
                                            <input type="email" aria-required="true" id="defaultRegisterFormEmail" class="form-control mb-4 bg-light text-dark" name="email" value="<%=email%>">
                                        </div>
                                        <div class="col credentials">
                                            <label class="lbl-txt" for="defaultRegisterFormFB"><b>Facebook Username</b><span class="asterisk-symbol"> *</span></label>
                                            <input type="text" aria-required="true" id="defaultRegisterFormFB" class="form-control mb-4 bg-light text-dark" name="fbUname" value="<%=fb%>">
                                        </div>
                                        <!--Mobile #-->
                                        <div class="col credentials">
                                            <label class="lbl-txt" for="defaultRegisterFormPhone"><b>Mobile Number</b><span class="asterisk-symbol"> *</span></label>
                                            <input type="number" aria-required="true" placeholder="09XXXXXXXXX" id="defaultRegisterFormPhone" class="form-control mb-4 bg-light text-dark" name="phone" value="<%=contact%>">

                                        </div>
                                    </div>
                                    <!--Password & Confirm Password-->
                                    <div class="row">
                                        <!--Password-->
                                        <div class="col credentials">
                                            <label class="lbl-txt" for="defaultRegisterFormPassword"><b>Password</b><span style="color: red;"> *</span></label>

                                            <input type="password" aria-required="true" id="defaultRegisterFormPassword" class="form-control bg-light text-dark" aria-describedby="defaultRegisterFormPasswordHelpBlock" name="password" maxlength="20"><span id='notice'></span>

                                        </div>
                                        <!--Confirm Password-->
                                        <div class="col credentials">
                                            <label class="lbl-txt" for="defaultRegisterFormConfirmPassword"><b>Confirm Password</b><span style="color: red;"> *</span></label>
                                            <input type="password" aria-required="true" id="defaultRegisterConfirmPassword" class="form-control bg-light text-dark" aria-describedby="defaultRegisterFormConfirmPasswordHelpBlock" name="cpassword" maxlength="20" onkeyup="check();">
                                            <span id='message'></span>
                                        </div>
                                        <script>


                                            document.getElementById('defaultRegisterFormPassword').onkeyup = function () {
                                                var val;
                                                if (!textLength(this.value)) {
                                                    val = 'Password must have 8 - 20 characters';
                                                } else {
                                                    val = '';
                                                }
                                                document.getElementById('notice').style.color = 'red';
                                                document.getElementById('notice').innerHTML = val;

                                            }
                                            function textLength(value) {
                                                var minLength = 8;
                                                if (value.length < minLength)
                                                    return false;
                                                return true;
                                            }

                                            var check = function () {
                                                if (document.getElementById('defaultRegisterFormPassword').value ==
                                                        document.getElementById('defaultRegisterConfirmPassword').value) {
                                                    document.getElementById('message').style.color = 'green';
                                                    document.getElementById('message').innerHTML = 'Password Matched!';
                                                } else {
                                                    document.getElementById('message').style.color = 'red';
                                                    document.getElementById('message').innerHTML = 'Password Not Matched!';
                                                }
                                            }
                                        </script>
                                    </div>
                                </div>
                                <hr>

                                <div class="grid">
                                    <!--Address-->
                                    <div class="row">
                                        <div class="col credentials">
                                            <label class="lbl-txt" for="defaultRegisterFormAddress"><b>Complete Address</b><span class="asterisk-symbol"> *</span></label>
                                            <input type="address" aria-required="true" id="defaultRegisterFormAddress" class="form-control mb-4 bg-light text-dark" name="address" value="<%=address%>">
                                        </div>
                                    </div>
                                    <!--Postal code & City-->
                                    <div class="row">
                                        <!--Postal code-->
                                        <div class="col credentials">
                                            <label class="lbl-txt" for="defaultRegisterFormPostalCode" ><b>Postal code</b><span class="asterisk-symbol"> *</span></label>
                                            <input type="number" aria-required="true" id="defaultRegisterFormPostalCode" class="form-control bg-light text-dark" name="postalcode" value="<%=postal%>">
                                        </div>
                                        <!--City-->
                                        <div class="col credentials">
                                            <label class="lbl-txt" for="defaultRegisterFormCity"><b>City</b><span class="asterisk-symbol"> *</span></label>
                                            <input type="text" aria-required="true" id="defaultRegisterFormCity" class="form-control bg-light text-dark" name="city" value="<%=city%>">
                                        </div>
                                    </div>

                                    <!--Regions-->
                                    <div class="row">
                                        <div class="col">
                                            <label class="lbl-txt" for="regions" style="margin-top:8px;"><b>Region</b><span class="asterisk-symbol"> *</span></label>
                                            <select class="form-control" id="region" name="region">
                                                <option value ="Luzon">Luzon</option>
                                                <option value ="Metro Manila">Metro Manila</option>
                                                <option value ="Visayas">Visayas</option>
                                                <option value ="Mindanao">Mindanao</option>
                                                <option value ="Island">Island</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <!--Landmarks (optional)-->
                                <div class="row">
                                    <div class="col">
                                        <label class="lbl-txt" for="defaultRegisterFormOptional"><b>Landmarks near your address</b> (optional)</label>
                                        <input type="address" id="defaultRegisterFormOptional" class="form-control mb-4 bg-light text-dark" name="aptoptional" value="<%=optional%>">
                                    </div>
                                </div>

                                <hr>
                                <!--SignUp Button-->
                                <div class="text-center actions">
                                    <input class="sign-up-btn my-3 font-weight-bold" 
                                           type="submit" id="register" disabled ="disabled" value = "Sign Up">
                                    <p class="text2">Already have an account? <a href="login.jsp">Log in</a></p>
                                </div>
                                <script>
                                    $(document).ready(function () {
                                        $('.credentials input').on('keyup', function () {
                                            let empty = false;

                                            $('.credentials input').each(function () {
                                                empty = $(this).val().length === 0;
                                            });

                                            if (empty)
                                                $('.actions input').attr('disabled', 'disabled');
                                            else
                                                $('.actions input').attr('disabled', false);
                                        });
                                    });
                                </script>
                            </form>
                        </div>
                    </div>
                </div>
                <!--Sign Up Form - Part 1-->
                <%}%>
            </main>
            <br>
            <jsp:include page="footer.jsp"/>
        </div>
    </body>
</html>