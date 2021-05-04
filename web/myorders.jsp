<%-- 
    Document   : myorders
    Created on : 03 13, 21, 11:14:51 PM
    Author     : karla
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Customer Profile - View Orders</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--CSS files-->
        <link rel="stylesheet" href="css/orders.css">
        <!--<link rel="stylesheet" href="css/vieworders-changepw_style.css">-->
        <!--Google fonts-->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Chivo:wght@400&display=swap" rel="stylesheet">
        <!--Bootstrap 4-->
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css" >
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

            String name = (String) session.getAttribute("name");
            if (name == null) {
                response.sendRedirect("login.jsp");
            } else {
                ResultSet orders = (ResultSet) request.getAttribute("orders");
                ArrayList<ResultSet> books = (ArrayList<ResultSet>) request.getAttribute("books");
                int index = 0;
        %>
        <jsp:include page="header.jsp"/>

        <div class="site-container container">
            <main class="site-content">
                <%if (!orders.next()) {%>
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold">My Orders</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered dataTable" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Date of Order</th>
                                        <th>Item/s</th>
                                        <th>Price</th>
                                        <th>Reference Number</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                    <center>
                        <form action="BookBrowsing" method="post">
                            <div class="center text-center actions mr-5">
                                <input class="sign-up-btn my-3 font-weight-bold" 
                                       type="submit" value = "Browse Books">
                            </div>
                        </form>
                    </center>
                </div>

                <%} else {
                    orders.beforeFirst();
                %>
                <center>
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold">My Orders</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Order Date</th>
                                            <th>Item/s</th>
                                            <th>Price</th>
                                            <th>Reference Number</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <%while (orders.next()) {
                                                String orderID = orders.getString("checkoutID");
                                                String orderTime = orders.getString("order_time");
                                                String price = orders.getString("total_price");
                                                String paid = orders.getString("paid");
                                                String cancel = orders.getString("cancel");
                                                String rNum = orders.getString("ref_number");
                                        %>
                                        <tr>
                                            <td>    
                                                <%=orderID%> 
                                            </td>
                                            <td>    
                                                <%=orderTime%>
                                            </td>
                                            <td>    
                                                <%
                                                    ResultSet order = books.get(index);

                                                    while (order.next()) {%>
                                                <%=order.getString("quantity")%> pc/s <%=order.getString("bookname")%>
                                                <br>
                                                <%}
                                                %>
                                            </td>
                                            <td>    
                                                PHP <%=price%>
                                            </td>
                                            <td>    
                                                <%if (rNum == null) {%>
                                                <p> - </p>
                                                <% } else {%>
                                                <%=rNum%>
                                                <% }%>
                                            </td>
                                            <td>    
                                                <%if (cancel.equals("true")) {
                                                        out.println("Order Cancelled");
                                                    } else if (paid.equals("true")) {
                                                        out.println("Payment Received");
                                                    } else if (rNum == null) {%>
                                                <form action="UpdateRNumber" method="POST">
                                                    <input type="hidden" name="checkoutID" value="<%=orderID%>">
                                                    <p>For proof of payment, please enter the reference number of the transaction of payment</p>
                                                    <div class="<%=orderID%>credentials">
                                                        <input type="text" id="refNumber" class="form-control mb-4 bg-light text-dark" name="refNum">
                                                    </div>
                                                    <div class="text-center <%=orderID%>actions">
                                                        <button class="font-weight-bold" style="border-radius: 50px; padding: 12px; border: none; outline: none !important; font-size: 16px; cursor: pointer; color: white; background-color: darkorange; transition: all .5s ease-in-out; margin-left: auto; float: right;" disabled="disabled" type="submit">Submit</button>
                                                    </div>

                                                    <script>
                                                        $(document).ready(function () {
                                                            $('.<%=orderID%>credentials input').on('keyup', function () {
                                                                let empty = false;

                                                                $('.<%=orderID%>credentials input').each(function () {
                                                                    empty = $(this).val().length === 0;
                                                                });

                                                                if (empty)
                                                                    $('.<%=orderID%>actions button').attr('disabled', 'disabled');

                                                                else
                                                                    $('.<%=orderID%>actions button').attr('disabled', false);

                                                            });
                                                        });
                                                    </script>
                                                </form>
                                                <%} else {
                                                        out.println("Waiting for Confirmation");
                                                    }%>
                                            </td>
                                        </tr>
                                        <%index++;
                                            }%>
                                    </tbody>
                                </table>
                                <%}%>
                            </div>
                        </div>
                    </div>

                </center>
            </main>
        </div>
        <jsp:include page="footer.jsp"/>
        <%}%>

        <!--Bootstrap-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>

        <script>
                                                        $('.dataTable').DataTable({
                                                            responsive: true,
                                                            lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
                                                            order: [[0, "desc"]]
                                                        });
        </script>
    </body>
</html>