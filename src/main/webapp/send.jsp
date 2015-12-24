<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Send money</title>

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
					<a href="customersList.jsp" class="list-group-item" align="center">Show
						list of Customers</a>
					</li> <a href="NewCustomer.html" class="list-group-item" align="center">Create
						new Customer</a>
					</li>
					<h3 align="center">Merchants</h3>
					<a href="merchantsList.jsp" class="list-group-item" align="center">Show
						list of Merchants</a>
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
					</li> <a href="send.jsp" class="list-group-item active" align="center">Sending
						money page</a>
					</li>
				</div>
			</div>
			<div class="col-sm-8">
				<h3 align="center">Sending money</h3>
				<form action="send.jsp" method="POST" role="form-horizontal">
					<%
						org.springframework.context.ApplicationContext context = new org.springframework.context.support.ClassPathXmlApplicationContext(
								"spring/application-config.xml");
						com.bionic.edu.PayListService payListService = (com.bionic.edu.PayListService) context
								.getBean("payListServiceImpl");

						String sumToPay = request.getParameter("sum");
						if (sumToPay != null) {
							Double sum = Double.valueOf(sumToPay);
							payListService.sendMoney(sum);
						}

						java.util.List<com.bionic.edu.PayList> list = payListService.getSortedList();

						Double total = 0d;
						for (com.bionic.edu.PayList pl : list) {
							total += pl.getSumSent();
						}
						Double accuracyTotal = new java.math.BigDecimal(total).setScale(3, java.math.RoundingMode.HALF_UP).doubleValue();
						out.print("<h2>Total sum need to send = " + accuracyTotal + "</h2>");
					%>
					<div class="form-group">
						<label for="name">Sum:</label> <input type="text"
							class="form-control" name="sum" placeholder="Enter sum">
					</div>

					<button type="submit" class="btn btn-primary btn-block">Submit</button>
					</br>
					<hr />
					<h2>Pay Lists:</h2>
					<table class="table table-striped">
						<tr>
							<th>Merchant Id
							<th>Sum sent
							<th>Formed Date
							<th>Sent Date
							<th>Priority
							<th>Status
						</tr>
						<%
							for (com.bionic.edu.PayList pl : list) {
								out.print("<tr>");
								out.print("<td>" + pl.getMerchantId());
								out.print("<td>" + pl.getSumSent());
								out.print("<td>" + pl.getFormedDate());
								out.print("<td>" + pl.getSentDate());
								out.print("<td>" + pl.getPriority());
								out.print("<td>" + pl.getStatus());
								out.print("</tr>");
							}
						%>
					</table>
				</form>
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
