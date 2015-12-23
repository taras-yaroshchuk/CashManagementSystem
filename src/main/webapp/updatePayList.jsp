<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Updated Pay Lists</title>

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
					</li> <a href="send.jsp" class="list-group-item" align="center">Sending
						money page</a>
					</li>
				</div>
			</div>
			<div class="col-sm-8">
				<h3 align="center">Next Pay Lists were updated:</h3>
				<table class="table table-striped table-bordered">

					<tr>
						<th>Merchant Id
						<th>Sum sent
						<th>Formed Date
						<th>Sent Date
						<th>Priority
						<th>Status
					</tr>

					<%
						org.springframework.context.ApplicationContext context = new org.springframework.context.support.ClassPathXmlApplicationContext(
								"spring/application-config.xml");
						com.bionic.edu.PayListService payListService = (com.bionic.edu.PayListService) context
								.getBean("payListServiceImpl");

						java.util.List<com.bionic.edu.PayList> list = payListService.findNotPaid();

						for (com.bionic.edu.PayList pl : list) {
							int StringId = pl.getId();
							String id = String.valueOf(StringId);
							Integer oldPriority = pl.getPriority();
							Integer newPriority = Integer.valueOf(request.getParameter(id));
							if (newPriority != oldPriority) {
								pl.setPriority(newPriority);
								payListService.save(pl);

								out.print("<tr>");
								out.print("<td>" + pl.getMerchantId());
								out.print("<td>" + pl.getSumSent());
								out.print("<td>" + pl.getFormedDate());
								out.print("<td>" + pl.getSentDate());
								out.print("<td>" + newPriority);
								out.print("<td>" + pl.getStatus());
								out.print("</tr>");
							}
						}
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


