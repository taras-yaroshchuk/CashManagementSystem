<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<%@tag description="Simple Template" pageEncoding="UTF-8" %>

<%@attribute name="title" %>
<%@attribute name="head_area" fragment="true" %>
<%@attribute name="body_area" fragment="true" %>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>${title}</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.css' />">

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="<c:url value='/resources/js/bootstrap.js' />"></script>

    <jsp:invoke fragment="head_area"/>
</head>
<body>

<div class="container">

    <div class="page-header">
        <div class="well well-sm">
            <h1 align="center">Cash Management System</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-3">
            <div class="list-group">
                <h3 align="center">Customers</h3>
                <a href="/customer/customersList" class="list-group-item"
                   align="center">Show list of Customers</a>
                </li> <a href="NewCustomer.html" class="list-group-item" align="center">Create
                new Customer</a>
                </li>
                <h3 align="center">Merchants</h3>
                <a href="/merchant/merchantsList" class="list-group-item" align="center">Show
                    list of Merchants</a>
                </li> <a href="NewMerchant.html" class="list-group-item" align="center">Create
                new Merchant</a>
                </li>
                <h3 align="center">Payments</h3>
                <a href="payment/paymentsList" class="list-group-item" align="center">Show
                    list of Payments</a>
                </li> <a href="NewPayment.html" class="list-group-item" align="center">Create
                new Payment</a>
                </li>
                <h3 align="center">Pay Lists</h3>
                <a href="paylist/paylistList" class="list-group-item" align="center">Show
                    all Pay Lists</a>
                </li> <a href="workOutPayLists.jsp" class="list-group-item"
                         align="center">Work out Pay Lists</a>
                </li> <a href="send.jsp" class="list-group-item"
                         align="center">Sending money page</a>
                </li>
            </div>
        </div>
        <div class="col-sm-8">
            <jsp:invoke fragment="body_area"/>
        </div>
    </div>
</div>

</body>
</html>



