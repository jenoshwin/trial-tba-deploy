<%-- 
    Document   : about
    Created on : 02 25, 21, 12:33:24 AM
    Author     : karla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>About Us | The Book Amiga Online Bookstore</title>
        <!--CSS files-->
        <link rel="stylesheet" href="css/aboutus-contactus-FAQs_style.css">
        <!--Google fonts-->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
        <!--Font awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="icon" href="images/TBAIcon.jpg">

    </head>

    <body>
        <jsp:include page="header.jsp"/>
        <div class="site-container">
            <main class="site-content">
                <!--About Us-->
                <div class="container-sm h-100">
                    <div class="row justify-content-center">
                        <div class="col-sm-10">
                            <p class="label">About Us</p>
                        </div>
                    </div>
                    <div class="row justify-content-center">
                        <div class="header col-sm-12">
                            <img src="images/thebookamigaheader.png" class="img-fluid" alt="The Book Amiga">
                        </div>
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-sm-7 text-center">
                            <p class="description">
                                Hola, amigos and amigas! The Book Amiga is an independent
                                bookstore catering pre-orders for brand new, bestselling books.
                                Let us be your one-stop shop for your go-to, worthy reads!
                            </p>
                        </div>
                    </div> 
                </div>
                <!--About Us-->
            </main>

            <jsp:include page="footer.jsp"/>
        </div>
    </body>
</html>
