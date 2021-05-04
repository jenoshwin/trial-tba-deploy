<%-- 
    Document   : browse
    Created on : 02 25, 21, 12:34:12 AM
    Author     : karla
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>The Book Amiga Online Bookstore</title>
        <!--CSS files-->
        <link rel="stylesheet" href="css/mainpagestyle.css">
        <link rel="icon" href="images/TBAIcon.jpg">
        <!--Google fonts-->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
        <!--Bootstrap 4-->
    </head>

    <body data-spy="scroll"  style="background-color: #FFF9C4;">
        <%
            ResultSet goodBook = (ResultSet) request.getAttribute("availbooks");
            ResultSet naBook = (ResultSet) request.getAttribute("notavailbooks");
        %>


        <jsp:include page="header.jsp"/>
        <br>

        <!--MAIN PAGE CONTENTS-->           
        <div class="container">
            <br>
            <br>
            <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner" role="listbox">
                    <div class="carousel-item active">
                        <img class="d-block img-fluid" src="images/TBACarousel1.jpg" alt="First slide">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block img-fluid" src="images/TBACarousel1.jpg" alt="Second slide">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block img-fluid" src="images/TBACarousel1.jpg" alt="Third slide">
                    </div>
                </div>
                <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <h1>All Books</h1>
            <div class="row text-left mb-5">
                <%while (goodBook.next()) {%>
                <div class="col-sm-6 col-md-6 col-lg-3">
                    <%
                        String bookID = goodBook.getString("bookID");
                        String bookCover = goodBook.getString("bookcover");
                        String bookName = goodBook.getString("bookname");
                        String price = goodBook.getString("price");
                        String author = goodBook.getString("author");
                    %>
                    <form action ="Book">
                        <div class="card h-100" style="margin-top: 20px">
                            <input type="hidden" name = "bookID" value ="<%=bookID%>">
                            <img class="card-img-top"  height ="300px" src="<%=bookCover%>" alt="<%=bookName%>">
                            <div class="card-body">
                                <h5 class="card-title font-weight-bolder" name="bookTitle" title="<%=bookName%>"><%=bookName%></h5>
                                <p class="card-subtitle" name="bookAuthor"><%=author%></p>
                                <p class="card-text font-weight-bold" name="price">PHP <%=price%>0</p>
                            </div>
                            <div class="card-footer text-center">
                                <input type = "submit" class="btn btn-info cart-icon" value="View Book">
                            </div>
                        </div>
                    </form>
                </div>
                <%}%>
            </div>
            <hr>
            <h2 class="mt-4">Out-of-Stock Books</h2>
            <div class="row text-left">
                <%while (naBook.next()) {%>
                <div class="col-sm-6 col-md-6 col-lg-3">
                    <%
                        String bookID = naBook.getString("bookID");
                        String bookCover = naBook.getString("bookcover");
                        String bookName = naBook.getString("bookname");
                        String price = naBook.getString("price");
                        String author = naBook.getString("author");
                    %>
                    <form action ="Book">
                        <div class="card h-100" style="margin-top: 20px">
                            <input type="hidden" name = "bookID" value ="<%=bookID%>">
                            <img class="card-img-top"  height ="300px" src="<%=bookCover%>" alt="<%=bookName%>">
                            <div class="card-body">
                                <h5 class="card-title font-weight-bolder" name="bookTitle" title="<%=bookName%>"><%=bookName%></h5>
                                <p class="card-subtitle" name="bookAuthor"><%=author%></p>
                                <p class="card-text font-weight-bold" name="price">PHP <%=price%>0</p>
                            </div>
                            <div class="card-footer text-center">
                                <input type = "submit" class="btn btn-info cart-icon" value="View Book">
                            </div>
                        </div>
                    </form>
                </div>
                <%}%>
            </div>
        </div>
        <!--MAIN PAGE END-->           

        <jsp:include page="footer.jsp"/>

    </body>
</html>
