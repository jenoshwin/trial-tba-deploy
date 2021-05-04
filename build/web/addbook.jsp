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
        <title>The Book Amiga Online Bookstore | Add Book</title>
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
        %>

        <jsp:include page="admin-header.jsp"/>

        <br>
        <br>
        <br>

        <div class="main-content" style="background-color: white">
            <div class="container">
                <form action="UpdateBook" method="post" id="editbook">
                    <div class="headerbook">
                        <br>
                        <div class="row">
                            <div class="col-md-4 col-sm-4">
                                <p class="txtedit">Add A New Book</p>
                            </div>
                            <div class="col-md-7 col-sm-7 actions">
                                <button class="sign-up-btn font-weight-bold" type="submit" disabled="disabled">
                                    Done <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-check" viewBox="0 0 16 16">
                                    <path d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.267.267 0 0 1 .02-.022z"/>
                                </button>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="action" value="add">
                    <br>
                    <div class="credentials">
                        <div class="row">
                            <div class="col-md-5" style="padding: 0px 75px">
                                <label class="lbl-txt" for="cover"><b>Book Cover URL</b></label>
                                <input type="text" id="cover" class="form-control mb-4 bg-light text-dark" name="bookcover">
                            </div>

                            <div class="col txtbox-col" style="padding: 0px 0px 0px 70px">
                                <div class="col-md-9">
                                    <label class="lbl-txt" for="title"><b>Title of the book</b></label>
                                    <input type="text" id="title" class="form-control mb-4 bg-light text-dark" name="bookname">
                                </div>
                                <div class="col-md-9">
                                    <label class="lbl-txt" for="auth"><b>Author</b></label>
                                    <input type="text" id="auth" class="form-control mb-4 bg-light text-dark" name="author">
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <label class="lbl-txt" for="isbn"><b>ISBN</b></label>
                                        <input type="text" id="isbn" class="form-control mb-4 bg-light text-dark" name="isbn">
                                    </div>
                                    <div class="col-md-3">
                                        <label class="lbl-txt" for="stock"><b>Stock</b></label>
                                        <input type="number" id="stock" class="form-control mb-4 bg-light text-dark" name="stock">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <label class="lbl-txt" for="date"><b>Date of Publication</b></label>
                                        <input type="text"  value="MM/DD/YYYY" id="date" class="form-control mb-4 bg-light text-dark" name="pdate">
                                    </div>
                                    <div class="col-md-3">
                                        <label class="lbl-txt" for="date"><b>Price</b></label>
                                        <input type="number" id="date" class="form-control mb-4 bg-light text-dark" name="price">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <label class="lbl-txt" for="gen"><b>Genre</b></label>
                                        <input type="text"  value="e.g. Fiction..." id="gen" class="form-control mb-4 bg-light text-dark" name="genre">
                                    </div>


                                    <div class="col-md-3">
                                        <label class="lbl-txt" for="weight"><b>Weight </b><small>(kg)</small></label>
                                        <input type="number" id="weight" class="form-control mb-4 bg-light text-dark" name="weight">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <label class="lbl-txt" for="bdes"><b>Book Description</b></label>
                        <textarea form="editbook"  rows="5"  id="bdes" class="form-control mb-4 bg-light text-dark" name="bdesc"> 
                        </textarea>
                    </div>
                    <script>
                        $(document).ready(function () {
                            $('.credentials input').on('keyup', function () {
                                let empty = false;

                                $('.credentials input').each(function () {
                                    empty = $(this).val().length === 0;
                                });

                                if (empty)
                                    $('.actions button').attr('disabled', 'disabled');
                                else
                                    $('.actions button').attr('disabled', false);
                            });
                        });
                    </script>
                    <%
                        }%>
                </form>
                <br>
                <br>
            </div>
        </div>


    </body>

</html>