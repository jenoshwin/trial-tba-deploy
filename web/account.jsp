<%-- 
    Document   : account
    Created on : 02 25, 21, 12:33:24 AM
    Author     : karla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Account | The Book Amiga Online Bookstore</title>
        <!--CSS files-->
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

            String userID = (String) session.getAttribute("userID");
            Boolean admin = (Boolean) session.getAttribute("admin");
            if (userID == null) {
                response.sendRedirect("login.jsp");
            } else {
                String name = (String) session.getAttribute("name");
                String lastName = (String) session.getAttribute("lname");
                String mobile = (String) session.getAttribute("phone");
                String fb = (String) session.getAttribute("fbName");
                String email = (String) session.getAttribute("email");
                String comAddress = (String) session.getAttribute("address");
                String address;
                String city;
                String postal;
                String region;
                String additional;
                try {
                    address = comAddress.substring(comAddress.indexOf("Address;;") + 9, comAddress.indexOf("City;;"));
                    city = comAddress.substring(comAddress.indexOf("City;;") + 6, comAddress.indexOf("Postal;;"));
                    postal = comAddress.substring(comAddress.indexOf("Postal;;") + 8, comAddress.indexOf("Region;;"));
                    region = comAddress.substring(comAddress.indexOf("Region;;") + 8, comAddress.indexOf("Additional;;"));
                    additional = comAddress.substring(comAddress.indexOf("Additional;;") + 12, comAddress.length());
                } catch (StringIndexOutOfBoundsException e) {
                    address = (String) session.getAttribute("address");
                    city = "";
                    postal = "";
                    region = "";
                    additional = "";
                }

                String msg = (String) request.getAttribute("msg");
                if (admin == true) {%>
        <jsp:include page="admin-header.jsp"/>
        <%} else {%>
        <jsp:include page="header.jsp"/>
        <%}%>
        <div class="site-container">
            <main class="site-content">
                <!--Account Page-->
                <div class="container-fluid" id="grad4">
                    <div class="row justify-content-center mt-0">
                        <div class="col-11 col-sm-9 col-md-7 col-lg-6 p-0 mt-3 mb-2">
                            <form class="login-form border p-4 shadow bg-white" method="POST" action="Profile">
                                <p class="create-account-text text-center mb-3">Manage my Account</p>
                                <input type="hidden"name="userID" value="<%=userID%>">
                                <%if (msg != null) {%>
                                <div class="text-center">
                                    <p class="text2"style="color: orange;"><big><big><%=msg%></big></big></p>
                                </div>
                                <%}%>
                                <!--Full Name-->
                                <div class ="credentials">
                                    <div class="row">
                                        <!--First name-->
                                        <div class="col">
                                            <label class="lbl-txt credentials-label" for="defaultRegisterFormFirstName">
                                                <b>First Name</b>
                                                <p id="updateFN" class="edit-btn" type="submit"><b>EDIT</b></p>
                                            </label>
                                            <input type="text" aria-required="true" class="form-control edit-form bg-light text-dark" id="editFN" name="firstName" value="<%=name%>" readonly>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <!--Last name-->
                                        <div class="col">
                                            <label class="lbl-txt" for="defaultRegisterFormLastName">
                                                <b>Last Name</b>
                                                <p id="updateLN" class="edit-btn" type="submit"><b>EDIT</b></p>
                                            </label>
                                            <input type="text" aria-required="true" class="form-control edit-form bg-light text-dark" id="editLN" name="lastName" value="<%=lastName%>" readonly>
                                        </div>
                                    </div>
                                    <!--Contact Details-->
                                    <div class="row">
                                        <!--Email Address-->
                                        <div class="col">
                                            <label class="lbl-txt" for="defaultRegisterFormEmailAddress">
                                                <b>Email Address</b>
                                                <p id="updateEML" class="edit-btn" type="submit"><b>EDIT</b></p>
                                            </label>
                                            <input type="text" aria-required="true" class="form-control edit-form bg-light text-dark" id="editEML" name="email" value="<%=email%>" readonly>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <!--FB Uname-->
                                        <div class="col">
                                            <label class="lbl-txt" for="defaultRegisterFormFBUName">
                                                <b>Facebook Username</b>
                                                <p id="updateFB" class="edit-btn" type="submit"><b>EDIT</b></p>
                                            </label>
                                            <input type="text" aria-required="true" class="form-control bg-light text-dark" id="editFB" name="fb" value="<%=fb%>" readonly>
                                        </div>
                                        <div class="col">
                                            <label class="lbl-txt" for="defaultRegisterFormContact">
                                                <b>Contact Information</b>
                                                <p id="updateMBL" class="edit-btn" type="submit"><b>EDIT</b></p>
                                            </label>
                                            <div class="input-group mb-3">
                                                <div class="input-group-append">
                                                    <span class="input-group-text">+63</span>
                                                </div>
                                                <input type="number" aria-required="true"  class="form-control bg-light text-dark" id="editMBL" name="mobile" value="<%=mobile%>" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="grid">
                                        <!--Address-->
                                        <div class="row">
                                            <div class="col credentials">
                                                <label class="lbl-txt" for="defaultRegisterFormAddress"><b>Complete Address</b>
                                                    <p id="updateCAdd" class="edit-btn" type="submit"><b>EDIT</b></p>
                                                </label>
                                                <input type="address" aria-required="true" id="editCAdd" class="form-control edit-form mb-4 bg-light text-dark" name="address" value="<%=address%>" readonly>
                                            </div>
                                        </div>
                                        <!--Postal code & City-->
                                        <div class="row">
                                            <!--Postal code-->
                                            <div class="col credentials">
                                                <label class="lbl-txt" for="defaultRegisterFormPostalCode" ><b>Postal code</b>
                                                    <p id="updatePos" class="edit-btn" type="submit"><b>EDIT</b></p>
                                                </label>
                                                <input type="number" aria-required="true" id="editPos" class="form-control edit-form  bg-light text-dark" name="postalcode" value="<%=postal%>" readonly>
                                            </div>
                                            <!--City-->
                                            <div class="col credentials">
                                                <label class="lbl-txt" for="defaultRegisterFormCity"><b>City</b>
                                                    <p id="updateCT" class="edit-btn" type="submit"><b>EDIT</b></p>
                                                </label>
                                                <input type="text" aria-required="true" id="editCT" class="form-control edit-form  bg-light text-dark" name="city" value="<%=city%>" readonly>
                                            </div>
                                        </div>

                                        <!--Regions-->
                                        <div class="row">
                                            <div class="col">
                                                <label class="lbl-txt" for="regions" style="margin-top:8px;"><b>Region</b>
                                                    <p id="updateReg" class="edit-btn" type="submit"><b>EDIT</b></p>
                                                </label>

                                                <select class="form-control" id="editReg" name="region">
                                                    <%
                                                        if (region.equals("Luzon")) {
                                                            out.println("<option value =\"Luzon\" selected>Luzon</option>");
                                                        } else {
                                                            out.println("<option value =\"Luzon\">Luzon</option>");
                                                        }
                                                        if (region.equals("Metro Manila")) {
                                                            out.println("<option value =\"Metro Manila\" selected>Metro Manila</option>");
                                                        } else {
                                                            out.println("<option value =\"Metro Manila\">Metro Manila</option>");
                                                        }
                                                        if (region.equals("Visayas")) {
                                                            out.println("<option value =\"Visayas\" selected>Visayas</option>");
                                                        } else {
                                                            out.println("<option value =\"Visayas\">Visayas</option>");
                                                        }
                                                        if (region.equals("Mindanao")) {
                                                            out.println("<option value =\"Mindanao\" selected>Mindanao</option>");
                                                        } else {
                                                            out.println("<option value =\"Mindanao\">Mindanao</option>");
                                                        }
                                                        if (region.equals("Island")) {
                                                            out.println("<option value =\"Island\" selected>Island</option>");
                                                        } else {
                                                            out.println("<option value =\"Island\">Island</option>");
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <br>
                                    <!--Landmarks (optional)-->
                                    <div class="row">
                                        <div class="col">
                                            <label class="lbl-txt" for="defaultRegisterFormOptional"><b>Landmarks near your address</b>
                                                <p id="updateAAdd" class="edit-btn" type="submit"><b>EDIT</b></p>
                                            </label>
                                            <input type="address" id="editAAdd" class="form-control edit-form mb-4 bg-light text-dark" name="aptoptional" value="<%=additional%>" readonly>
                                        </div>
                                    </div>
                                </div>
                                <script>
                                    document.getElementById('updateFN').onclick = function () {
                                        document.getElementById('editFN').removeAttribute('readonly');
                                    };
                                    document.getElementById('updateLN').onclick = function () {
                                        document.getElementById('editLN').removeAttribute('readonly');
                                    };
                                    document.getElementById('updateEML').onclick = function () {
                                        document.getElementById('editEML').removeAttribute('readonly');
                                    };
                                    document.getElementById('updateFB').onclick = function () {
                                        document.getElementById('editFB').removeAttribute('readonly');
                                    };
                                    document.getElementById('updateMBL').onclick = function () {
                                        document.getElementById('editMBL').removeAttribute('readonly');
                                    };
                                    document.getElementById('updateCAdd').onclick = function () {
                                        document.getElementById('editCAdd').removeAttribute('readonly');
                                    };
                                    document.getElementById('updatePos').onclick = function () {
                                        document.getElementById('editPos').removeAttribute('readonly');
                                    };
                                    document.getElementById('updateCT').onclick = function () {
                                        document.getElementById('editCT').removeAttribute('readonly');
                                    };
                                    document.getElementById('updateReg').onclick = function () {
                                        document.getElementById('editReg').removeAttribute('disabled');
                                    };
                                    document.getElementById('updateAAdd').onclick = function () {
                                        document.getElementById('editAAdd').removeAttribute('readonly');
                                    };
                                </script>

                                <!--Request Button-->
                                <div class="request-changepw text-center">
                                    <button class="savechanges-btn my-3 font-weight-bold" type="submit">Save changes</button>
                                    <a class="changepw-btn my-3 font-weight-bold" type="submit" href="changepassword.jsp">Change Password</a>
                                </div>
                                <hr>
                                <center>
                                    <a style="color:red;" type="submit" href="deleteaccnt.jsp" onclick="return confirm('Are you sure?')" ><bold>Delete my Account</bold></a>
                                </center>
                            </form>
                        </div>
                    </div>
                </div>
                <!--Account Page-->
            </main>
            <br>
            <br>
            <%}%>
        </div>
        <%if (admin == true) {
            } else {%>
        <jsp:include page="footer.jsp"/>
        <%}%>

    </body>
</html>
