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
                ArrayList<ResultSet> books = (ArrayList<ResultSet>) request.getAttribute("books");
                int index = 0;
            %>
            <div class="container-fluid">
                <%if (msg != null) {%>
                <p class="create-account-text text-center mb-3" style="color:green;"><%=msg%></p>
                <%}%>
                <!-- DataTables-->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold">Order Management</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered dataTable" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Facebook Username</th>
                                        <th>Order/s</th>
                                        <th>Address</th>
                                        <th>Payment Method</th>
                                        <th>Delivery Method</th>
                                        <th>Date Purchased</th>
                                        <th>Price (PHP)</th>
                                        <th>Reference Number</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% while (dataSet.next()) {
                                            String transactionID = dataSet.getString("checkoutID");
                                            String date = dataSet.getString("order_time");
                                            String firstName = dataSet.getString("firstname");
                                            String lastName = dataSet.getString("lastname");
                                            String fbName = dataSet.getString("fb_uname");
                                            String comAddress = dataSet.getString("address");
                                            String paymentMethod = dataSet.getString("payment_method");
                                            String deliveryMethod = dataSet.getString("delivery_method");
                                            String price = dataSet.getString("total_price");
                                            String paid = dataSet.getString("paid");
                                            String cancel = dataSet.getString("cancel");
                                            String rNum = dataSet.getString("ref_number");
                                            String address;
                                            String city;
                                            String postal;
                                            String region;
                                            String additional;

                                            try {
                                                address = comAddress.substring(comAddress.indexOf("Address;;") + 9, comAddress.indexOf("City;;"));
                                                city = comAddress.substring(comAddress.indexOf("City;;") + 6, comAddress.indexOf("Postal;;"));
                                                postal = comAddress.substring(comAddress.indexOf("Postal;;") + 8, comAddress.indexOf("Region;;"));
                                                region = comAddress.substring(comAddress.indexOf("Region;;") + 8, comAddress.indexOf("Additional;;"));
                                                additional = comAddress.substring(comAddress.indexOf("Additional;;") + 12, comAddress.length());
                                                comAddress = address + ", " + city + ", " + postal + ", " + region + " - " + additional;
                                            } catch (StringIndexOutOfBoundsException e) {
                                                comAddress = (String) session.getAttribute("address");
                                            }
                                            LocalDateTime newDate = LocalDateTime.now();
                                            DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("MM-dd-yyyy HH:mm:ss");
                                            String dateNow = newDate.format(myFormatObj);
                                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd-yyyy HH:mm:ss");
                                            LocalDateTime from = LocalDateTime.parse(date, formatter);
                                            LocalDateTime to = LocalDateTime.parse(dateNow, formatter);
                                            long hours = ChronoUnit.HOURS.between(from, to);
                                    %>
                                    <tr>
                                        <td>  
                                            <%=transactionID%> 
                                        </td>

                                        <td>    
                                            <%=firstName%> <%=lastName%>
                                        </td>

                                        <td>    
                                            <%=fbName%> 
                                        </td>

                                        <td>   
                                            <%
                                                ResultSet order = books.get(index);

                                                while (order.next()) {%>
                                            <%=order.getString("quantity")%> pc/s <%=order.getString("bookname")%> by <%=order.getString("author")%>
                                            <br>
                                            <%}
                                            %>
                                        </td>

                                        <td>    
                                            <%=comAddress%>
                                        </td>

                                        <td>    
                                            <%=paymentMethod%> 
                                        </td>

                                        <td>    
                                            <%=deliveryMethod%> 
                                        </td>

                                        <td>    
                                            <%=date%> 
                                        </td>


                                        <td>    
                                            <%=price%> 
                                        </td>

                                        <td>
                                            <%if (rNum == null) {%>
                                            <p>No Reference Number submitted yet</p>
                                            <%} else {%>
                                            <%=rNum%>     
                                            <%}%>
                                        </td>

                                        <td>    
                                            <div class="text-center">
                                                <%if (paid == "true") {%>
                                                <p> Paid</p>
                                                <%} else {%>
                                                <%if (cancel == "true") {%>
                                                <p> Canceled </p>
                                                <%} else {%>
                                                <%if (hours >= 48) {%>
                                                This order exceeded 48 hours. Cancel?
                                                <br>
                                                <ul class="list-inline m-0">

                                                    <li class="list-inline-item">
                                                        <form action="CancelOrder" method="POST">
                                                            <input type="hidden" name = "checkoutID" value ="<%=transactionID%>">
                                                            <button onclick="confirmCancel()" type="Submit" class="btn btn-danger btn-sm rounded-0" type="button" data-toggle="tooltip"
                                                                    data-placement="top" title="Cancel"><i class="fa fa-window-close"></i></button>
                                                            <!--<button class="delete" >
                                                                <a type="submit" onclick="confirmCancel()" style="color:white;">Cancel</a>
                                                            </button>-->
                                                        </form>
                                                        <%}%> 
                                                    </li>
                                                    <li class="list-inline-item">
                                                        <form action="UpdateOrder" method="POST">
                                                            <input type="hidden" name = "checkoutID" value ="<%=transactionID%>">
                                                            <button type="Submit" class="btn btn-success btn-sm rounded-0" type="button" data-toggle="tooltip"
                                                                    data-placement="top" title="Paid"><i class="fa fa-check-square-o"></i></button>
                                                        </form>                                 
                                                    </li>
                                                </ul>  
                                                <br>

                                                <%}%>
                                                <%}%>
                                                <script>
                                                    function confirmCancel() {
                                                        sure = confirm("Are you sure you want to cancel this order?");
                                                        if (sure) {
                                                            return true;
                                                        } else {
                                                            event.preventDefault()
                                                            return false;
                                                        }
                                                    }
                                                </script>
                                            </div>
                                        </td>
                                    </tr>
                                    <%index++;
                                            }
                                        }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-right">
                <form action="CreatePDF" method="post">
                    <input type="hidden" name="action" value="order">
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
