<%-- 
    Document   : about
    Created on : 02 25, 21, 12:33:24 AM
    Author     : karla
--%>

<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>The Book Amiga Online Bookstore | Order Management</title>
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
            String msg = (String) request.getAttribute("msg");
            if (admin == false) {
                response.sendRedirect("BookBrowsing.jsp");
            } else {
        %>
        <jsp:include page="admin-header.jsp"/>
        <br>
        <br>

        <div class="main-content">
            <%
                ResultSet dataSet = (ResultSet) request.getAttribute("orders");
            %>
            <div class="container-fluid">
                <!-- DataTables-->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold">Book Archive</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered dataTable" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Book ID</th>
                                        <th>Book Name</th>
                                        <th>Author</th>
                                        <th>ISBN</th>
                                        <th>Genre</th>
                                        <th>Book Description</th>
                                        <th>Publish Date</th>
                                        <th>Price (PHP)</th>
                                        <th>Weight (kg)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% while (dataSet.next()) {
                                            String id = dataSet.getString("archiveid");
                                            String bookID = dataSet.getString("bookid");
                                            String bName = dataSet.getString("bookname");
                                            String bAuthor = dataSet.getString("author");
                                            String isbn = dataSet.getString("isbn");
                                            String genre = dataSet.getString("genre");
                                            String desc = dataSet.getString("bookdesc");
                                            String pDate = dataSet.getString("publish_date");
                                            String price = dataSet.getString("price");
                                            String weight = dataSet.getString("weight");
                                    %>
                                    <tr>
                                        <td>  
                                            <%=id%> 
                                        </td>

                                        <td>    
                                            <%=bookID%>
                                        </td>

                                        <td>    
                                            <%=bName%> 
                                        </td>

                                        <td>   
                                            <%=bAuthor%>
                                        </td>

                                        <td>    
                                            <%=isbn%>
                                        </td>

                                        <td>    
                                            <%=genre%> 
                                        </td>

                                        <td>    
                                            <%=desc%> 
                                        </td>

                                        <td>    
                                            <%=pDate%> 
                                        </td>


                                        <td>    
                                            <%=price%> 
                                        </td>

                                        <td>
                                            <%=weight%>
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
            <div class="text-right">
                <form action="CreatePDF" method="post">
                    <input type="hidden" name="action" value="archive">
                    <input class="sign-up-btn my-3 font-weight-bold" type="submit" value="Export as PDF">
                </form>
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
                lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
                order: [[0, "desc"]]
            });
        </script>
    </body>

</html>
