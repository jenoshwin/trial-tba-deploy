<%-- 
    Document   : contact
    Created on : 02 25, 21, 12:33:24 AM
    Author     : karla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Contact Us | The Book Amiga Online Bookstore</title>
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
                <!--Contact Us Page contents-->
                <div class="container-sm h-100">
                    <div class="row justify-content-center">
                        <div class="col-sm-10">
                            <p class="label">Contact Information</p>
                        </div>
                    </div>
                    <div class="container-info">
                        <div class="contact-info row py-3">
                            <div class="col-sm-4 text-center">
                                <i class="fa fa-envelope fa-2x icon"></i>
                            </div>
                            <div class="col-sm-8">
                                <h5>villaruelcharizze@gmail.com</h5>
                            </div>
                        </div>
                        <div class="contact-info row py-3">
                            <div class="col-sm-4 text-center">
                                <i class="fa fa-phone fa-2x icon"></i>
                            </div>
                            <div class="col-sm-8">
                                <h5>09289264365</h5>
                            </div>
                        </div>
                        <div class="contact-info row py-3">
                            <div class="col-sm-4 text-center">
                                <i class="fa fa-facebook-official fa-2x icon"></i>
                            </div>
                            <div class="col-sm-8">
                                <h5>facebook.com/thebookamiga</h5>
                            </div>
                        </div>
                        <div class="contact-info row py-3">
                            <div class="col-sm-4 text-center">
                                <i class="fa fa-instagram fa-2x icon"></i>
                            </div>
                            <div class="col-sm-8">
                                <h5>instagram.com/thebookamiga</h5>
                            </div>
                        </div>
                        <div class="contact-info row py-3">
                            <div class="col-sm-4 text-center">
                                <img src="images/shopee-logo.png" class="icon">
                            </div>
                            <div class="col-sm-8">
                                <h5>shopee.ph/bookamigaph</h5>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Contact Us Page contents-->
            </main>
            <jsp:include page="footer.jsp"/>
        </div>
    </body>
</html>
