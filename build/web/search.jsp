<%-- 
    Document   : browse
    Created on : 02 25, 21, 12:34:12 AM
    Author     : karla
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");

            String name = (String) session.getAttribute("name");
            ResultSet dataSet = (ResultSet) request.getAttribute("data");
            String keyword = (String) request.getAttribute("search");
        %>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Search results for "<%=keyword%>"</title>
        <!--CSS files-->
        <link rel="stylesheet" href="css/mainpagestyle.css">
        <link rel="icon" href="images/TBAIcon.jpg">
        <!--Google fonts-->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
        <!--Bootstrap 4-->
    </head>

    <body data-spy="scroll"  style="background-color: #FFF9C4;">

        <jsp:include page="header.jsp"/>
        <div class="site-container">
            <main class="site-content">

                <div class="container">

                    <h1>Search results for "<%=keyword%>"</h1>

                    <div class="row text-left">
                        <%while (dataSet.next()) {%>
                        <div class="col-sm-3">
                            <%
                                String bookID = dataSet.getString("bookID");
                                String bookCover = dataSet.getString("bookcover");
                                String bookName = dataSet.getString("bookname");
                                String price = dataSet.getString("price");
                                String author = dataSet.getString("author");
                            %>
                            <form action ="Book">
                                <div class="card h-100" style="margin-top: 20px ">
                                    <input type="hidden" name = "bookID" value ="<%=bookID%>">
                                    <img class="card-img-top"  height ="300px" src="<%=bookCover%>" alt="<%=bookName%>">
                                    <div class="card-body">
                                        <h5 class="card-title font-weight-bolder" name="bookTitle"><%=bookName%></h5>
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
            </main>
            <jsp:include page="footer.jsp"/>
        </div>
    </body>
</html>
