<%-- 
    Document   : bookmanagement
    Created on : 03 22, 21, 10:19:32 PM
    Author     : karla
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>   
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>The Book Amiga Online Bookstore | Book Management</title>
        <!--CSS files-->
        <link rel="stylesheet" href="css/orders.css">
        <!--Google fonts-->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Chivo:wght@400&display=swap" rel="stylesheet">
        <!--Bootstrap-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" >
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css" >
        <!--Bootstrap 4-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <!--Font awesome-->
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
                ResultSet books = (ResultSet) request.getAttribute("orders");
                String msg = (String) request.getAttribute("msg");
        %>

        <jsp:include page="admin-header.jsp"/>
        <br>
        <br>
        <div class="main-content">
            <%if (msg != null) {%>
            <p class="create-account-text text-center mb-3"><%=msg%></p>
            <%}%>

            <div class="container-fluid">

                <!-- DataTables Example -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3" style="color: #FFECB3">
                        <form action="addbook.jsp" method ="post" style="display: flex">

                            <h6 class="m-0 font-weight-bold">Product Management</h6>
                            <button class="sign-up-btn font-weight-bold" type="submit">Add a book +</button>
                        </form>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered dataTable" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Author</th>
                                        <th>Price (PHP)</th>
                                        <th>ISBN</th>
                                        <th>Genre</th>
                                        <th>Stock</th>
                                        <th>EDIT</th>
                                        <th>DELETE</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%while (books.next()) {
                                            String bookID = books.getString("bookID");
                                            String bookname = books.getString("bookname");
                                            String author = books.getString("author");
                                            String price = books.getString("price");
                                            String isbn = books.getString("ISBN");
                                            String genre = books.getString("genre");
                                            String stock = books.getString("stock");
                                    %>
                                    <tr>
                                        <td>    
                                            <%=bookID%> 
                                        </td>
                                        <td>    
                                            <%=bookname%>
                                        </td>
                                        <td>    
                                            <%=author%>
                                        </td>
                                        <td>    
                                            <%=price%>0
                                        </td>
                                        <td>    
                                            <%=isbn%>
                                        </td>
                                        <td>    
                                            <%=genre%>
                                        </td>
                                        <td>    
                                            <%=stock%>
                                        </td>
                                        <td>    
                                            <form action="EditBook" method ="get">
                                                <input type="hidden" name = "bookID" value ="<%=bookID%>">
                                                <center><button type="Submit" class="btn btn-success btn-sm rounded-0" type="button" data-toggle="tooltip"
                                                                data-placement="top" title="Edit"><i class="fa fa-edit"></i></button></center>
                                            </form>
                                        </td>
                                        <td>    
                                            <form action="DeleteBook" method ="post">
                                                <input type="hidden" name = "bookID" value ="<%=bookID%>">
                                                <center><button onclick="confirmDelete()" type="Submit" class="btn btn-danger btn-sm rounded-0" type="button" data-toggle="tooltip"
                                                                data-placement="top" title="Delete"><i class="fa fa-trash"></i></button></center>
                                            </form>
                                            <script>
                                                function confirmDelete() {
                                                    sure = confirm("Are you sure you want to delete the book?");
                                                    if (sure) {
                                                        return true;
                                                    } else {
                                                        event.preventDefault()
                                                        return false;
                                                    }
                                                }
                                            </script>
                                        </td>
                                    </tr>
                                    <%}
                                        }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js"></script>
        <script>
                                                $('.dataTable').DataTable({
                                                    responsive: true,
                                                    lengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
                                                });
        </script>


    </body>
</html>
