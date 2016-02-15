<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>New Payment</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.css" rel="stylesheet">

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
                <a href="WEB-INF/jsp/customersList.jsp" class="list-group-item" align="center">Show
                    list of Customers</a>
                </li> <a href="NewCustomer.html" class="list-group-item" align="center">Create
                new Customer</a>
                </li>
                <h3 align="center">Merchants</h3>
                <a href="WEB-INF/jsp/merchantsList.jsp" class="list-group-item"
                   align="center">Show list of Merchants</a>
                </li> <a href="NewMerchant.html" class="list-group-item" align="center">Create
                new Merchant</a>
                </li>
                <h3 align="center">Payments</h3>
                <a href="paymentsList.jsp" class="list-group-item" align="center">Show
                    list of Payments</a>
                </li> <a href="NewPayment.html" class="list-group-item" align="center">Create
                new Payment</a>
                </li>
                <h3 align="center">Pay Lists</h3>
                <a href="showPayLists.jsp" class="list-group-item" align="center">Show
                    all Pay Lists</a>
                </li> <a href="workOutPayLists.jsp" class="list-group-item"
                         align="center">Work out Pay Lists</a>
                </li> <a href="send.jsp" class="list-group-item"
                         align="center">Sending money page</a>
                </li>
            </div>
        </div>
        <div class="col-sm-8">
            <h3 align="center">New Payment was added successfully!</h3>
            <table class="table table-striped">
                <tr>
                    <td>Merchant Id
                    <td>Customer Id
                    <td>Goods
                    <td>Sum payed
                    <td>Charge payed
                </tr>
                <c:forEach items="${merchantsList}" var="merchant">
                    <tr>
                        <td><c:out value="${merchant.getId()}"/></td>
                        <td><c:out value="${merchant.getName()}"/></td>
                        <td><c:out value="${merchant.getBankName()}"/></td>
                        <td><c:out value="${merchant.getCharge()}"/></td>
                        <td><c:out value="${merchant.getMinSum()}"/></td>
                        <td><c:out value="${merchant.getNeedToSend()}"/></td>
                        <td><c:out value="${merchant.getSent()}"/></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>



<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script
        src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="js/bootstrap.js"></script>
</body>
</html>

