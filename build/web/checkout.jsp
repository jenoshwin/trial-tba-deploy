<%-- 
    Document   : checkout
    Created on : 02 25, 21, 12:33:24 AM
    Author     : karla
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Checkout | The Book Amiga</title>
        <link rel="stylesheet" href="css/signup_login.css">
        <link rel="stylesheet" href="css/checkoutpage_style.css">
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
                String fb = (String) session.getAttribute("fbName");
                String comAddress = (String) session.getAttribute("address");
                String address;
                String city;
                String postal;
                String region;
                String additional;
                String msg = null;
                try {
                    address = comAddress.substring(comAddress.indexOf("Address;;") + 9, comAddress.indexOf("City;;"));
                    city = comAddress.substring(comAddress.indexOf("City;;") + 6, comAddress.indexOf("Postal;;"));
                    postal = comAddress.substring(comAddress.indexOf("Postal;;") + 8, comAddress.indexOf("Region;;"));
                    region = comAddress.substring(comAddress.indexOf("Region;;") + 8, comAddress.indexOf("Additional;;"));
                    additional = comAddress.substring(comAddress.indexOf("Additional;;") + 12, comAddress.length());
                    comAddress = address + ", " + city + ", " + postal + ", " + region + " - " + additional;
                } catch (StringIndexOutOfBoundsException e) {
                    comAddress = (String) session.getAttribute("address");
                    city = "";
                    postal = "";
                    region = "";
                    additional = "";
                    msg = "Please complete your address in the Account Profile.";
                }
                ResultSet orders = (ResultSet) request.getAttribute("data");
                String error = (String) request.getAttribute("msg");
        %>
        <jsp:include page="header.jsp"/>

        <div class="site-container">
            <main class="site-content">

                <!--Checkout-->

                <div class="container">
                    <form class="login-form" name="checkout" method="POST" action="Checkout">
                        <div class="row">
                            <div class="col-md-5">
                                <div class="item-box-blog0">
                                    <div class="item-box-blog-image">
                                        <p class="create-account-text text-center mb-3">Check-out Form</p>
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
                                        <!--Address Details-->
                                        <div class="row">
                                            <div class="col credentials">
                                                <label class="lbl-txt" for="defaultRegisterFormFirstName"><b>Complete Address</b></label>
                                                <input type="text" aria-required="true" id="defaultRegisterFormFirstName" class="form-control credentials bg-light text-dark" name="address" value="<%=comAddress%>" readonly>
                                            </div>
                                        </div>
                                        <div class="text-center">
                                            <p class="text4" style="color: black;">If you wish to change your contact information, go to the <a href="account.jsp">account profile</a> page</p>
                                        </div>
                                        <hr>

                                        <!--Delivery Details-->
                                        <div class="row">
                                            <!--Mode Of Payment-->
                                            <div class="col credentials">
                                                <label for="mopselect" class="lbl-txt"><b>Mode of Payment:</b></label>
                                                <select name="modePayment" id="mopselect" class="btn btn-default btn-md dropdown-toggle" style="border-radius: 6px; font-size: 13px; border-color: black; background-color: white;">
                                                    <option value="bdo">Bank Transfer (BDO)</option>
                                                    <option value="bpi">Bank Transfer (BPI)</option>
                                                    <option value="gcash">GCash/Paymaya</option>
                                                    <option value="gcash">Bank Transfer (Union Bank)</option>
                                                </select>
                                            </div>

                                            <!--Delivery Options-->
                                            <div class="col credentials">
                                                <label for="mod" class="lbl-txt"><b>Mode of Delivery:</b></label>
                                                <select name="modeDelivery" id="mod" class="btn btn-default btn-md dropdown-toggle" style="border-radius: 6px; font-size: 13px; border-color: black; background-color: white;">                                               
                                                    <option value="j&t">J&T Express</option>                                                  
                                                </select>
                                            </div>
                                            <!--Region Select-->
                                            <div class="col credentials">
                                                <select name="region" id="regselect" hidden class="btn btn-default btn-md dropdown-toggle" style="border-radius: 6px; font-size: 13px; border-color: black; background-color: white;">
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
                                                <%if (msg != null) {%>
                                                <p style='color:red; text-align: center;'><%=msg%></p>
                                                <script></script>
                                                <%}%>

                                            </div>
                                        </div>
                                        <input type="SUBMIT" value="Cancel" class="btn cancel-btn btn-md" formaction="BookBrowsing">
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-6">
                                <div class="item-box-blog1">
                                    <div class="item-box-blog-image">
                                        <p class="create-account-text text-center mb-3">My Cart</p>
                                        <%if (error != null) {%>
                                        <p style='color:red; text-align: center;'><%=error%></p>
                                        <%}%>

                                        <%if (!orders.next()) {%>
                                        <br>
                                        <br>
                                        <p><center>You have no books in your cart yet.
                                            <br>
                                            <br>
                                            <br>
                                            <br>
                                        </center>
                                        </p>

                                        <%} else {
                                            orders.beforeFirst();
                                        %>

                                        <table class="tab">
                                            <tr>
                                                <th> </th>
                                                <th>Qty</th>
                                                <th style="padding-left: 10px">Book Name</th>
                                                <th style="padding-left: 10px">Price</th>
                                                <!--                                                <th style="padding-left: 10px">Weight</th>-->
                                                <th>&nbsp;</th>
                                            </tr>
                                            <%while (orders.next()) {

                                                    String orderID = orders.getString("orderID");
                                                    String bookName = orders.getString("bookname");
                                                    String subtotal = orders.getString("subtotal");
                                                    String quantity = orders.getString("quantity");
                                                    String bookWeight = orders.getString("weight");
                                                    float weight = Float.parseFloat(quantity) * Float.parseFloat(bookWeight);
                                            %>
                                            <script>
                                                var book = {};
                                                book[<%=orderID%>] = parseFloat(<%=subtotal%>);
                                            </script>
                                            <tr>
                                                <td class="checkbox">    
                                                    <input type="checkbox"  class="checkbox" name="orderID" value="<%=orderID%>" value2="<%=subtotal%>" value3="<%=weight%>"> 
                                                </td>
                                                <td class="cart0">    
                                                    <%=quantity%>
                                                </td>
                                                <td class="cart1">    
                                                    <%=bookName%>
                                                </td>
                                                <td class="cart1">    
                                                    PHP <%=subtotal%>0
                                                </td>
                                                <!--                                                <td class="cart1">    
                                                <%=weight%>
                                            </td>-->
                                                <td class="cart1">    
                                                    <input type="hidden" name = "action" value ="order">
                                                </td>
                                            </tr>
                                            <script>
                                                $(':checkbox').change(function () {
                                                    var total = 0;
                                                    var delivery = 0.00;
                                                    var weight = 0.00;

                                                    $(':checkbox:checked').each(function () {
                                                        weight = weight + parseFloat(this.getAttribute("value3"));
                                                        var region = $("#regselect :selected").text();
                                                        if (region === "Luzon") {
                                                            if (weight <= .5) {
                                                                delivery = 110;
                                                            } else if (weight > .5 && weight <= 1) {
                                                                delivery = 180;
                                                            } else if (weight > 1 && weight <= 3) {
                                                                delivery = 210;
                                                            } else if (weight > 3 && weight <= 4) {
                                                                delivery = 300;
                                                            } else if (weight > 4 && weight <= 5) {
                                                                delivery = 380;
                                                            } else if (weight > 5 && weight <= 6) {
                                                                delivery = 470;
                                                            } else if (weight > 6) {
                                                                delivery = 500;
                                                            }
                                                        } else if (region === "Metro Manila") {
                                                            if (weight <= .5) {
                                                                delivery = 120;
                                                            } else if (weight > .5 && weight <= 1) {
                                                                delivery = 190;
                                                            } else if (weight > 1 && weight <= 3) {
                                                                delivery = 220;
                                                            } else if (weight > 3 && weight <= 4) {
                                                                delivery = 310;
                                                            } else if (weight > 4 && weight <= 5) {
                                                                delivery = 400;
                                                            } else if (weight > 5 && weight <= 6) {
                                                                delivery = 480;
                                                            } else if (weight > 6) {
                                                                delivery = 510;
                                                            }
                                                        } else if (region === "Visayas") {
                                                            if (weight <= .5) {
                                                                delivery = 130;
                                                            } else if (weight > .5 && weight <= 1) {
                                                                delivery = 210;
                                                            } else if (weight > 1 && weight <= 3) {
                                                                delivery = 230;
                                                            } else if (weight > 3 && weight <= 4) {
                                                                delivery = 330;
                                                            } else if (weight > 4 && weight <= 5) {
                                                                delivery = 430;
                                                            } else if (weight > 5 && weight <= 6) {
                                                                delivery = 530;
                                                            } else if (weight > 6) {
                                                                delivery = 540;
                                                            }
                                                        } else if (region === "Mindanao") {
                                                            if (weight <= .5) {
                                                                delivery = 140;
                                                            } else if (weight > .5 && weight <= 1) {
                                                                delivery = 220;
                                                            } else if (weight > 1 && weight <= 3) {
                                                                delivery = 250;
                                                            } else if (weight > 3 && weight <= 4) {
                                                                delivery = 360;
                                                            } else if (weight > 4 && weight <= 5) {
                                                                delivery = 470;
                                                            } else if (weight > 5 && weight <= 6) {
                                                                delivery = 580;
                                                            } else if (weight > 6) {
                                                                delivery = 590;
                                                            }
                                                        } else if (region === "Island") {
                                                            if (weight <= .5) {
                                                                delivery = 150;
                                                            } else if (weight > .5 && weight <= 1) {
                                                                delivery = 240;
                                                            } else if (weight > 1 && weight <= 3) {
                                                                delivery = 260;
                                                            } else if (weight > 3 && weight <= 4) {
                                                                delivery = 370;
                                                            } else if (weight > 4 && weight <= 5) {
                                                                delivery = 480;
                                                            } else if (weight > 5 && weight <= 6) {
                                                                delivery = 600;
                                                            } else if (weight > 6) {
                                                                delivery = 610;
                                                            }
                                                        }

                                                        total = total + parseFloat(this.getAttribute("value2"));

                                                    });
                                                    total = total + delivery;
                                                    var value = total.toLocaleString(
                                                            undefined, {minimumFractionDigits: 2}
                                                    );
                                                    document.getElementById('total').innerHTML = "PHP " + value;
                                                    document.checkout.totalPrice.value = value;
                                                    document.getElementById('delivery').innerHTML = "PHP " + delivery;
                                                });

                                            </script>
                                            <script>
                                                function confirmDel() {
                                                    sure = confirm("Are you sure you want to delete this item from your cart?");
                                                    if (sure) {
                                                        return true;
                                                    } else {
                                                        event.preventDefault()
                                                        return false;
                                                    }
                                                }
                                            </script>
                                            <%}%>
                                        </table>
                                        <hr>
                                        <p class="delivery-amount"><b>DELIVERY FEE: </b><span id="delivery">PHP 0.00</span></p>
                                        <p class="total-amount"><b>TOTAL: </b><span id="total">PHP 0.00</span></p>
                                        <input type="hidden" name="totalPrice">
                                        <input type="SUBMIT" value="Order Books" class="rectangle2" formaction="Checkout">
                                        <input type="SUBMIT" value="Delete Orders" class="rectangle2" formaction="DeleteRecord">
                                    </div>
                                </div>
                            </div>
                            <br>
                            <br>

                        </div>                
                    </form>
                </div>
                <!--Checkout-->
            </main>
            <jsp:include page="footer.jsp"/>
            <%}
                }%>
        </div>
    </body>
</html>
