<%-- 
    Document   : about
    Created on : 02 25, 21, 12:33:24 AM
    Author     : karla
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>The Book Amiga Online Bookstore | Book Request Management</title>
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
                ResultSet dataSet = (ResultSet) request.getAttribute("data");
            %>
            <div class="container-fluid">
                <%if (msg != null) {%>
                <p class="create-account-text text-center mb-3" style="color:green;"><%=msg%></p>
                <%}%>
             
                <!-- DataTables -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold">Book Request Management</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered dataTable" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>Request ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Book Name</th>
                                        <th>Author</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <% while (dataSet.next()) {

                                            String requestID = dataSet.getString("requestID");
                                            String email = dataSet.getString("email");
                                            String firstName = dataSet.getString("firstname");
                                            String lastName = dataSet.getString("lastname");
                                            String bookName = dataSet.getString("bookname");
                                            String author = dataSet.getString("author");
                                    %>
                                    <tr>
                                        <td>    
                                            <%=requestID%> 
                                        </td>
                                        <td>    
                                            <%=firstName%> <%=lastName%>
                                        </td>
                                        <td>    
                                            <%=email%> 
                                        </td>
                                        <td>    
                                            <%=bookName%> 
                                        </td>
                                        <td>    
                                            <%=author%> 
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
                    <input type="hidden" name="action" value="request">
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
                lengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
                order: [[ 0, "desc" ]]
            });
        </script>
    </body>
</html>
