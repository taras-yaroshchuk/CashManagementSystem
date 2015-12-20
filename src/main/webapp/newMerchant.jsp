<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>New Merchant</title>

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
					</li> <a href="workOutPayLists.jsp" class="list-group-item"
						align="center">Sending money page</a>
					</li>
				</div>
			</div>
			<div class="col-sm-8">
				<h3 align="center">New Merchant was added successfully!</h3>
				<table class="table table-striped">
					<tr>
						<td>Name
						<td>Bank
						<td>Charge
						<td>Minimum Sum
					</tr>
					<%
						org.springframework.context.ApplicationContext context = new org.springframework.context.support.ClassPathXmlApplicationContext(
								"spring/application-config.xml");
						com.bionic.edu.MerchantService merchantService = (com.bionic.edu.MerchantService) context
								.getBean("merchantServiceImpl");
						com.bionic.edu.Merchant merchant = new com.bionic.edu.Merchant();
						merchant.setName(request.getParameter("name"));
						merchant.setBankName(request.getParameter("bank"));
						merchant.setSwift(request.getParameter("swift"));
						merchant.setAccount(request.getParameter("account"));
						merchant.setCharge(Double.valueOf(request.getParameter("charge")));
						merchant.setPeriod(Short.valueOf(request.getParameter("period")));
						merchant.setMinSum(Double.valueOf(request.getParameter("sum")));
						merchantService.save(merchant);

						out.print("<tr>");
						out.print("<td>" + merchant.getName());
						out.print("<td>" + merchant.getBankName());
						out.print("<td>" + merchant.getCharge());
						out.print("<td>" + merchant.getMinSum());
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

