<%-- 
    Document   : admin-header.jsp
    Created on : 03 24, 21, 11:09:28 PM
    Author     : asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The Book Amiga Online Bookstore</title>
        <!--CSS files-->
        <link rel="stylesheet" href="css/admin-navbars_style.css">
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
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");

            String name = (String) session.getAttribute("name");
        %>
        <div id="main">
            <!--Top nav bar-->
            <nav class="navbar navbar-expand-lg">
                <button class="openbtn" onclick="openNav()"><i class="fa fa-bars"></i></button>
                <div class="admin-user ml-auto">
                    <!--Welcome, admin!-->
                    <div class="admin-icon">
                        <!--Account profile-->
                        <li class="nav-item dropdown" style="list-style: none;">
                            <a class="account-profile-icon dropdown-toggle" href="#" id="navbarDropdown" role="button"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Welcome, admin <%=name%>!
                            </a>
                            <!--Account profile dropdown-->
                            <div class="dropdown-menu dropdown-menu-right text-center" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="account.jsp">Profile</a>
                                <a class="dropdown-item" href="Logout">Log out</a>
                            </div>
                        </li>
                    </div>
                </div>
            </nav>
            <!--Top nav bar-->
        </div>

        <!--Side menu-->
        <div id="mySidebar" class="sidebar">
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
            <img src="images/thebookamigalogo.png" alt="The Book Amiga" class="thebookamigalogo">
            <hr class="line">
            <a class="sidenav-link" href="BookManagement"><i class="fa fa-book sidenav-icon"></i>Books</a>
            <a class="sidenav-link" href="BookRequests"><i class="fa fa-pencil sidenav-icon"></i>Requests</a>           
            <a class="sidenav-link" href="Orders"><i class="fa fa-shopping-cart fa-flip-horizontal sidenav-icon"></i>Orders</a>
            <a class="sidenav-link" href="Customers"><i class="fa fa-users sidenav-icon"></i>Customers</a>
            <a class="sidenav-link" href="Archives"><i class="fa fa-archive sidenav-icon"></i>Archives</a>
        </div>

        <script>
            function openNav() {
                document.getElementById("mySidebar").style.width = "200px";
                document.getElementById("main").style.marginLeft = "200px";
            }

            /* Set the width of the sidebar to 0 and the left margin of the page content to 0 */
            function closeNav() {
                document.getElementById("mySidebar").style.width = "0";
                document.getElementById("main").style.marginLeft = "0";
            }
        </script>
        <!--Side menu-->

    </body>
</html>
