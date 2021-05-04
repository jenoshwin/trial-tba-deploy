<%-- 
    Document   : genre
    Created on : 02 25, 21, 12:07:53 AM
    Author     : karla
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Genre | The Book Amiga Online Bookstore</title>
        <!--CSS FILES -->
        <link rel="stylesheet" href="css/genrepage_style.css">
        <!--Google fonts-->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <!--Bootstrap-->
        <link rel="icon" href="images/TBAIcon.jpg">
    </head>
    <body data-spy="scroll"  style="background-color: #FFF9C4;">
        <jsp:include page="header.jsp"/>
        <br>
        <br>


        <!--MAIN PAGE CONTENTS-->           
        <div class="container">
            <%
                ResultSet orders = (ResultSet) request.getAttribute("orders");
                ArrayList<ResultSet> books = (ArrayList<ResultSet>) request.getAttribute("books");
                int index = 0;
            %>

            <form action="Genre" method="GET">
                <label for="genre-dropdown" id="select-genres">Jump to:  </label>
                <div class="search_select_box" id="select-genres">
                    <select onchange="myAnchor(this.value)" name="genre-dropdown" id="genre-dropdown" class="w-100 btn btn-default btn-md dropdown-toggle" data-live-search="true">
                        <%while (orders.next()) {%>
                        <option value= "<%=orders.getString("GENRE")%>">
                            <%=orders.getString("genre")%>
                            <%}
                                orders.beforeFirst();%>
                        </option>       
                    </select>
                </div>
            </form>

            <%while (orders.next()) {%>
            <a id ="<%=orders.getString("genre")%>"><br>

                <br></a>
            <h2 id="genre"><%=orders.getString("GENRE")%></h2>    
            <%
                ResultSet order = books.get(index);
            %>

            <div class="row text-left">
                <%while (order.next()) {%>
                <div class="col-sm-6 col-md-6 col-lg-3">
                    <%
                        String bookID = order.getString("bookid");
                        String bookCover = order.getString("bookcover");
                        String bookName = order.getString("bookname");
                        String price = order.getString("price");
                        String author = order.getString("author");
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

            <%index++;
                }
            %>
        </div>


        <button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
        <script>
            //Get the button
            var mybutton = document.getElementById("myBtn");

            // When the user scrolls down 20px from the top of the document, show the button
            window.onscroll = function () {
                scrollFunction()
            };

            function scrollFunction() {
                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                    mybutton.style.display = "block";
                } else {
                    mybutton.style.display = "none";
                }
            }

            // When the user clicks on the button, scroll to the top of the document
            function topFunction() {
                document.body.scrollTop = 0;
                document.documentElement.scrollTop = 0;
            }
        </script>

        <script>

            function myAnchor(value) {
                var top = document.getElementById(value).offsetTop;
                window.scrollTo(0, top);
                //document.getElementById(value).scrollIntoView();
            }

        </script>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
