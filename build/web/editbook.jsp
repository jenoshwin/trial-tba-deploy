<%-- 
    Document   : editbook
    Created on : 03 22, 21, 11:17:39 PM
    Author     : karla
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>The Book Amiga Online Bookstore | Edit Book</title>

        <link rel="stylesheet" href="css/addbook_style.css">
        <link rel="stylesheet" href="css/admin-navbars_style.css">

        <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="icon" href="images/TBAIcon.jpg">


    </head>

    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");

            Boolean admin = (Boolean) session.getAttribute("admin");
            if (admin == false) {
                response.sendRedirect("BookBrowsing.jsp");
            } else {
                ResultSet book = (ResultSet) request.getAttribute("books");
        %>

        <jsp:include page="admin-header.jsp"/>

        <br>
        <br>

        <div class="main-content" style="background-color: white;">
            <div class="container">
                <form action="UpdateBook" method="post" id="editbook">
                    <div class="headerbook">
                        <br>
                        <div class="row">
                            <div class="col-md-4 col-sm-4">
                                <p class="txtedit">Edit Book Information</p> 
                            </div>
                            <div class="col-md-7 col-sm-7">
                                <button class="sign-up-btn font-weight-bold" type="submit">
                                    Done <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-check" viewBox="0 0 16 16">
                                    <path d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.267.267 0 0 1 .02-.022z"/>
                                    </svg>                                           
                                </button>    

                            </div>
                        </div>

                    </div>
                    <br>

                    <%while (book.next()) {
                            String bookID = book.getString("BOOKID");
                            String cover = book.getString("BOOKCOVER");
                            String title = book.getString("BOOKNAME");
                            String author = book.getString("AUTHOR");
                            String isbn = book.getString("ISBN");
                            String genre = book.getString("GENRE");
                            String bdesc = book.getString("BOOKDESC");
                            String pdate = book.getString("PUBLISH_DATE");
                            String price = book.getString("PRICE");
                            String stock = book.getString("STOCK");
                            String weight = book.getString("WEIGHT");
                    %>
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="bookID" value="<%=bookID%>">
                    <br>
                    <div class="row">
                        <div class="col-md-5" style="padding: 0px 75px">
                            <label class="lbl-txt" for="cover"><b>Book Cover URL</b></label>
                            <input type="text" id="cover" class="form-control mb-4 bg-light text-dark" value="<%=cover%>" name="bookcover">
                        </div>

                        <div class="col txtbox-col" style="padding: 0px 0px 0px 70px">
                            <div class="col-md-9">
                                <label class="lbl-txt" for="title"><b>Title of the book</b></label>
                                <input type="text" id="title" class="form-control mb-4 bg-light text-dark" value="<%=title%>" name="bookname">
                            </div>
                            <div class="col-md-9">
                                <label class="lbl-txt" for="auth"><b>Author</b></label>
                                <input type="text" id="auth" class="form-control mb-4 bg-light text-dark" value="<%=author%>" name="author">
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <label class="lbl-txt" for="isbn"><b>ISBN</b></label>
                                    <input type="text" id="isbn" class="form-control mb-4 bg-light text-dark" value="<%=isbn%>" name="isbn">
                                </div>
                                <div class="col-md-3">
                                    <label class="lbl-txt" for="stock"><b>Stock</b></label>
                                    <input type="number" id="stock" class="form-control mb-4 bg-light text-dark" value="<%=stock%>" name="stock">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label class="lbl-txt" for="date"><b>Date of Publication</b></label>
                                    <input type="text" id="date" class="form-control mb-4 bg-light text-dark" value="<%=pdate%>" name="pdate">
                                </div>
                                <div class="col-md-3">
                                    <label class="lbl-txt" for="date"><b>Price</b></label>
                                    <input type="number" id="date" class="form-control mb-4 bg-light text-dark" value="<%=price%>" name="price">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label class="lbl-txt" for="gen"><b>Genre</b></label>
                                    <input type="text" id="gen" class="form-control mb-4 bg-light text-dark" value="<%=genre%>" name="genre">
                                </div>

                                <div class="col-md-3">
                                        <label class="lbl-txt" for="weight"><b>Weight </b><small>(kg)</small></label>
                                    <input type="number" id="weight" class="form-control mb-4 bg-light text-dark" value="<%=weight%>" name="weight">
                                </div> </div>
                        </div>
                    </div>
                    <label class="lbl-txt" for="bdes"><b>Book Description</b></label>
                    <textarea form="editbook"  rows="5"  id="bdes" class="form-control mb-4 bg-light text-dark" name="bdesc"> <%=bdesc%>
                    </textarea>
                </form>
                <%}
                    }%>

                <br>
                <br>
            </div>
        </div>

    </body>

</html>