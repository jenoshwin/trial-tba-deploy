<%-- 
    Document   : success
    Created on : 02 14, 21, 9:08:17 PM
    Author     : karla
--%>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Arrays"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Book Amiga Online Bookstore</title>
    <link rel="stylesheet" href="css/success.css"> 
    <link rel="stylesheet" href="css/signup_login.css">
    <link rel="stylesheet" href="css/navbar_style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Offside&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="icon" href="images/TBAIcon.jpg">
</head>

<body>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        LocalDateTime newDate = LocalDateTime.now();
        DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("MM-dd-yyyy HH:mm:ss");
        String dateCheckout = newDate.format(myFormatObj);

        String checkoutID = (String) request.getAttribute("checkoutID");
        String fname = (String) request.getAttribute("fname");
        String lname = (String) request.getAttribute("lname");
        String email = (String) request.getAttribute("email");
        String phone = (String) request.getAttribute("phone");
        String address = (String) request.getAttribute("address");
        String payment = ((String) request.getAttribute("payment")).toUpperCase();
        String delivery = ((String) request.getAttribute("delivery")).toUpperCase();
        String total = (String) request.getAttribute("total");
        String[] prices = (String[]) request.getAttribute("orders");
        // String[] orders = (String[]) request.getAttribute("orders");
        ResultSet dataSet = (ResultSet) request.getAttribute("data");

    %>
    <!--Navigation Bar-->

    <jsp:include page="header.jsp"/> 
    <div class="site-container container">
        <h2>Thank you for your purchase!</h2>
        <br>
        <main class="site-content">
            <div class="row">
                <div class="col-md-6">
                    <div class="col-md-6-first">
                        <br>
                        <h6><b>Customer and Order Details</b></h6>
                        <br>
                        <div class="container">
                            <div class="row">
                                <div class="col align-self-start">
                                    Date
                                </div>
                                <div class="col align-self-end">
                                    <%=dateCheckout%>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="container">
                            <div class="row">
                                <div class="col align-self-start">
                                    Transaction ID
                                </div>
                                <div class="col align-self-end">
                                    <%=checkoutID%>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="container">
                            <div class="row">
                                <div class="col align-self-start">
                                    Name
                                </div>
                                <div class="col align-self-end">
                                    <%=fname%> <%=lname%>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="container">
                            <div class="row">
                                <div class="col align-self-start">
                                    Email
                                </div>
                                <div class="col align-self-end">
                                    <%=email%>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="container">
                            <div class="row">
                                <div class="col align-self-start">
                                    Contact No.
                                </div>
                                <div class="col align-self-end">
                                    <%=phone%>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="container">
                            <div class="row">
                                <div class="col align-self-start">
                                    Address
                                </div>
                                <div class="col align-self-end">
                                    <%=address%>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="container">
                            <div class="row">
                                <div class="col align-self-start">
                                    Mode of Payment
                                </div>
                                <div class="col align-self-end">
                                    <%=payment%>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="container">
                            <div class="row">
                                <div class="col align-self-start">
                                    Delivery Option
                                </div>
                                <div class="col align-self-end">
                                    <%=delivery%>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="container">
                            <div class="row">
                                <div class="col align-self-start">
                                    Items
                                </div>
                                <div class="col align-self-end">
                                    <%while (dataSet.next()) {%>
                                    <%=dataSet.getString("quantity")%>x <%=dataSet.getString("bookname")%> by <%=dataSet.getString("author")%>
                                    <br>
                                    <%}%>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="container">
                            <div class="row">
                                <div class="col align-self-start">
                                    <strong>Total</strong>
                                </div>
                                <div class="col align-self-end">
                                    <strong>PHP <%=total%></strong>
                                </div>
                            </div>
                        </div>
                        <br>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="col-md-6-second">
                        <br>
                        <h6><b>Payment Details</b></h6>
                        <br>
                        <div class="container">
                            <div class="row">
                                <div class="col align-self-start">
                                    <b>Gcash / Paymaya</b>
                                </div>
                                <div class="col align-self-end">
                                    <b>BDO / BPI/ UNION BANK</b>
                                </div>
                            </div>
                        </div>
                        <div class="container">
                            <div class="row">
                                <div class="col align-self-start">
                                    You can send your payments to the following numbers:
                                    <br>
                                    <br>
                                    <b>GCash</b> <br> Michael John S. Tria <br>09959619053
                                    <br>
                                    <br>
                                    <b>Paymaya</b><br>Charizze Santiana A. Villaruel<br>09289264365 
                                    <br>
                                    <br>
                                    Please include your name &  transaction id in the message area
                                </div>
                                <div class="col align-self-end">
                                    Make your payments via online bank transfers or through over-the-counter payment in any of the bank branches.
                                    <br>
                                    <br>
                                    <b>BDO</b>
                                    <br>
                                    Charizze Santiana A. Villaruel
                                    <br>
                                    005250429549
                                    <br>
                                    <br>
                                    <b>BPI</b>
                                    <br>
                                    Charizze Santiana A. Villaruel
                                    <br>
                                    8089222053
                                    <br>
                                    <br>
                                    <b>Union Bank</b>
                                    <br>
                                    Charizze Santiana A. Villaruel
                                    <br>
                                    109421295133
                                </div>
                            </div>
                        </div>
                        <br>
                    </div>
                </div>
            </div>
            <br>
            <strong><p class="text-note">Note: Please pay the total amount within 48 hours (2 days) for the order to be confirmed. </p></strong>
            <!-- Not returning the browse jsp -->
            <form action="BookBrowsing" class="text-center">
                <button class="sign-up-btn my-3 font-weight-bold" type="submit">Continue Shopping</button>
            </form>

            <br>
            <br>
            <br>
            <br>
        </main>
        <jsp:include page="footer.jsp"/>
    </div>
</body>
</html>
