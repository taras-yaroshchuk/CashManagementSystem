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
			<div class="well">
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
					<a href="merchantsList.jsp" class="list-group-item"
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
					</li> <a href="Send.html" class="list-group-item"
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
					<%
						org.springframework.context.ApplicationContext context = new org.springframework.context.support.ClassPathXmlApplicationContext(
								"spring/application-config.xml");
						com.bionic.edu.PaymentService paymentService = (com.bionic.edu.PaymentService) context
								.getBean("paymentServiceImpl");
						com.bionic.edu.MerchantService merchantService = (com.bionic.edu.MerchantService) context
								.getBean("merchantServiceImpl");
						com.bionic.edu.Payment payment = new com.bionic.edu.Payment();

						payment.setCustomerId(Integer.valueOf(request.getParameter("customerId")));

						Integer merchId = Integer.valueOf(request.getParameter("merchantId"));
						payment.setMerchantId(merchId);
						payment.setGoods(request.getParameter("goods"));

						Double sumPayed = Double.valueOf(request.getParameter("sum"));
						payment.setSumPayed(sumPayed);

						java.util.Date utilDate = new java.util.Date();
						java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
						payment.setDt(new java.sql.Timestamp(sqlDate.getTime()));

						com.bionic.edu.Merchant merchant = merchantService.findById(merchId);
						Double chargePayed = (sumPayed / 100) * merchant.getCharge();
						Double accuracyChargePayed = new java.math.BigDecimal(chargePayed)
								.setScale(3, java.math.RoundingMode.HALF_UP).doubleValue();
						payment.setChargePayed(accuracyChargePayed);

						merchant.setNeedToSend(merchant.getNeedToSend() + sumPayed - chargePayed);

						merchantService.save(merchant);
						paymentService.save(payment);

						out.print("<tr>");
						out.print("<td>" + payment.getCustomerId());
						out.print("<td>" + payment.getMerchantId());
						out.print("<td>" + payment.getGoods());
						out.print("<td>" + payment.getSumPayed());
						out.print("<td>" + payment.getChargePayed());
						out.print("</tr>");
					%>
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

