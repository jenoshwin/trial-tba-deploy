<%-- 
    Document   : book
    Created on : 02 28, 21, 5:41:34 PM
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
            while (dataSet.next()) {
                String bookID = dataSet.getString("bookID");
                String bookCover = dataSet.getString("bookcover");
                String bookName = dataSet.getString("bookname");
                String author = dataSet.getString("author");
                String isbn = dataSet.getString("isbn");
                String genre = dataSet.getString("genre");
                String bookDesc = dataSet.getString("bookdesc");
                String price = dataSet.getString("price");
                String stock = dataSet.getString("stock");
                String availability = dataSet.getString("availability");
                String weight = dataSet.getString("weight");
                bookDesc = bookDesc.replaceAll("\\\\n", "<br><br>");
        %>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" href="images/TBAIcon.jpg">

        <title><%=bookName%></title>
        <!--CSS files-->
        <link rel="stylesheet" href="css/bookpage_style.css">
        <!--JS files-->
        <link rel="stylesheet" href="lib/minusandplus.js">
        <!--Google fonts-->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
        <!--Font Awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!--Bootstrap 4-->

    </head>

    <body>

        <script>
            function increment() {
                document.getElementById('demoInput').stepUp();
            }
            function decrement() {
                document.getElementById('demoInput').stepDown();
            }
        </script>

        <jsp:include page="header.jsp"/>
        <div class="site-container">
            <main class="site-content">
                <!--Book Page contents-->
                <div class="container">
                    <div class="row">
                        <div class="col-md-5">
                            <div class="item-box-blog">
                                <div class="item-box-blog-image">
                                    <img src="<%=bookCover%>" alt="<%=bookName%>" class="book-img">
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="item-box-blog">
                                <div class="item-box-blog-image">
                                    <form method="GET" action="AddToCart" id="checkoutButton"> 
                                        <input type="hidden" name = "bookID" value ="<%=bookID%>">
                                        <input type="hidden" name = "price" value ="<%=price%>">
                                        <h2 class="text-right book-name"><b><%=bookName%></b></h2>
                                        <h3 class="text-right"><b><%=author%></b></h3>
                                        <hr class="style1">
                                        <h4 class="text-left"><strong>Brief Overview</strong></h4>
                                        <p class="text-justify"><%=bookDesc%></p>
                                        <hr class="style1">
                                        <div class="container-lower">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="item-box-blog2">
                                                        <div class="item-box-blog-image">
                                                            <p class="text-left stock-no"> <b> No. of stocks left: <%=stock%> </b>
                                                            </p>
                                                            <h2 class="text-left"> <b>PHP <%=price%>0</b> </h2>
                                                        </div>

                                                        <div class="numbers-row">

                                                            <div class="input-group">Quantity
                                                                <input onclick="decrement()" type="button" value="-" class="button-minus"
                                                                       data-field="quantity">
                                                                <input id=demoInput type="number" step="1" max="<%=stock%>" min="1" type=number value="1" name="quantity"
                                                                       class="quantity-field">
                                                                <input onclick="increment()" type="button" value="+" class="button-plus"
                                                                       data-field="quantity">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-5">
                                                    <div class="item-box-blog2">
                                                        <p><strong>ISBN</strong><span style="float: right"><%=isbn%></span></p>
                                                        <p><strong>Genre</strong><span class="genre" style="float: right"><%=genre%></span></p>
                                                        <button form="checkoutButton" id='button' type="submit" class="btn-addtocart addCart" disabled>
                                                            <i class="fa fa-shopping-cart fa-flip-horizontal fa-lg"></i>Add to Cart
                                                        </button>

                                                        <script>
                                                            var stock = <%=stock%>;
                                                            if (stock === 0) {
                                                            } else {
                                                                document.getElementById('button').removeAttribute('disabled');
                                                            }
                                                        </script>


                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <%}%>
                <!--Book Page contents-->
            </main>
            <br>
            <jsp:include page="footer.jsp"/>
        </div>
    </body>
</html>

