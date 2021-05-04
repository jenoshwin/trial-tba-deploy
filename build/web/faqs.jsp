<%-- 
    Document   : faqs
    Created on : 02 25, 21, 12:33:24 AM
    Author     : karla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>FAQs | The Book Amiga Online Bookstore</title>
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
                <!--FAQs Page contents-->
                <div class="FAQs-container container-sm">
                    <div class="row justify-content-center">
                        <div class="col-sm-10">
                            <p class="label">Frequently Asked Questions (FAQs)</p>
                        </div>
                    </div>
                    <div class="row py-2 ml-4 mr-4">
                        <div class="question-icon col-sm-2 text-center">
                            <h2><strong>Q</strong></h2>
                        </div>
                        <div class="question col-sm-10">
                            <h4>
                                What is the expected time of arrival?
                            </h4>
                        </div>
                        <div class="answer-icon col-sm-2 text-center">
                            <h2><strong>A</strong></h2>
                        </div>
                        <div class="answer col-sm-10">
                            <h5>
                                The expected time of arrival for every batch (ETA) is usually two to four weeks after the cut-off date. 
                            </h5>
                        </div>
                    </div>
                    <div class="row py-2 mr-3 ml-4 mr-4">
                        <div class="question-icon col-sm-2 text-center">
                            <h2><strong>Q</strong></h2>
                        </div>
                        <div class="question col-sm-10">
                            <h4>
                                What are you payment methods?
                            </h4>
                        </div>
                        <div class="answer-icon col-sm-2 text-center">
                            <h2><strong>A</strong></h2>
                        </div>
                        <div class="answer col-sm-10">
                            <h5>
                                We accept payments via:
                                    <br>- Bank (BDO, BPI, and Union Bank)
                                    <br>- GCash
                                    <br>- PayMaya
                            </h5>
                        </div>
                    </div>
                    <div class="row py-2 mr-3 ml-4 mr-4">
                        <div class="question-icon col-sm-2 text-center">
                            <h2><strong>Q</strong></h2>
                        </div>
                        <div class="question col-sm-10">
                            <h4>
                                What is your mode of delivery?
                            </h4>
                        </div>
                        <div class="answer-icon col-sm-2 text-center">
                            <h2><strong>A</strong></h2>
                        </div>
                        <div class="answer col-sm-10">
                            <h5>
                                Our courier is J&T Express for door-to-door delivery. Rates depend on the weight of the item/s and location of the buyer. LBC Cash on Pickup (maximum 3 kgs., for delivery fee only) is also available upon request.
                            </h5>
                        </div>
                    </div>
                    <hr>
                    <div class="row justify-content-center">
                        <div class="col-sm-10">
                            <p class="label">Shipping Fees</p>
                        </div>
                    </div>
                    <div class="row py-2 ml-4 mr-4">
                        <div class="col-sm-12 text-center">
                            <img src="images/shipping-fee.jpg" alt="Shipping Fee" style="width:90%; height: 100%;">
                        </div>
                    </div>
                </div>
                <!--FAQs Page contents-->
            </main>
            <br>
            <br>
            <br>
            <jsp:include page="footer.jsp"/>
        </div>
    </body>
</html>
