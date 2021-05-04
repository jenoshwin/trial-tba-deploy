<%-- 
    Document   : header
    Created on : 02 28, 21, 2:43:45 PM
    Author     : karla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>The Book Amiga Online Bookstore</title>
        <!--CSS files-->
        <link rel="stylesheet" href="css/navbar_style.css">
        <!--Google fonts-->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
        <!--Font Awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!--Bootstrap 4-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="icon" href="images/TBAIcon.jpg">
    </head>
    <body data-spy="scroll"  style="background-color: #FFF9C4;">
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");

            String name = (String) session.getAttribute("name");
        %>
        <!--NAV BAR-->
        <nav class="navbar navbar-expand-lg py-0 navbar-dark fixed-top">
            <a class="navbar-brand" href="BookBrowsing">
                <img src="images/thebookamigalogo.png" alt="The Book Amiga" class="thebookamigalogo">
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <!--Tabs-->
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <!--Browse Book tab-->
                    <li class="nav-item dropdown">
                        <a class="nav-link" href="BookBrowsing">Browse</a>
                    </li>
                    <!--Genres tab-->
                    <li class="nav-item dropdown">
                        <a class="nav-link" href="Genre">Genres</a>
                    </li>
                    <!--Pre-order tab-->
                    <li class="nav-item">
                        <a class="nav-link" href="request.jsp">Request Book</a>
                    </li>
                    <!--About Us tab-->
                    <li class="nav-item">
                        <a class="nav-link" href="about.jsp">About Us</a>
                    </li>
                    <!--Contact Us tab-->
                    <li class="nav-item">
                        <a class="nav-link" href="contact.jsp">Contact Us</a>
                    </li>
                    <!--FAQs tab-->
                    <li class="nav-item">
                        <a class="nav-link" href="faqs.jsp">FAQs</a>
                    </li>
                </ul>
                <!--Search bar-->
                <form class="form-inline my-2 my-lg-0" action="Search" id="formdata">
                    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="search" id="search">
                    <button class="btn btn-outline my-2 my-sm-0" type="submit"><i
                            class="fa fa-search search-icon"></i></button>
                </form>
                <script type="text/javascript">
                    $(document).ready(function () {
                        $('#formdata').submit(function () {
                            if ($.trim($('#search').val()) === '')
                            {
                                return false;
                            } else
                            {
                                return true;
                            }
                        });
                    });
                </script>
                <%if (session.getAttribute("name") != null) {%>
                <!--Shopping cart & Account Profile icons-->
                <div class="btn-group my-2" role="group" aria-label="cart-account">
                    <ul class="cart-account">
                        <!--Account profile-->
                        <li class="nav-item dropdown">
                            <a class="account-profile-icon dropdown-toggle" id="navbarDropdown" role="button"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Hi, <%=name%>!
                            </a>
                            <!--Account Details-->
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown" width = "50px">
                                <a class="dropdown-item" href="account.jsp">Profile</a>
                                <a class="dropdown-item" href="MyOrders">My Orders</a>
                                <a class="dropdown-item" href="Logout">Log Out</a>
                            </div>
                        </li>
                        <!--Shopping cart-->
                        <li><a class="shopping-cart-icon" href="Cart"><i class="fa fa-shopping-cart fa-2x fa-flip-horizontal"></i></a></li>
                        <li></li>
                    </ul>
                </div>
                <%} else {%>
                <div class="btn-group my-2" role="group" aria-label="Login-Signup">
                    <a href="login.jsp"><button type="button" class="btn btn-login btn-light">Login</button></a>
                    <a href="signup.jsp"><button type="button" class="btn btn-signup btn-light">Sign-up</button></a>
                </div>
                <%}%>
            </div>
        </nav>
        <!--NAV BAR-->
    </body>
</html>
