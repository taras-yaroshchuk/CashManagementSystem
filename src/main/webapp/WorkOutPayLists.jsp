<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Work out Pay List</title>

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
					</li> <a href="workOutPayLists.jsp" class="list-group-item active"
						align="center">Work out Pay Lists</a>
					</li> <a href="Send.html" class="list-group-item" align="center">Sending
						money page</a>
					</li>
				</div>
			</div>
			<div class="col-sm-8">
				<h3 align="center">Done successfully!</h3>
				<table class="table table-striped">

					<tr>
						<td><b>Merchant Id 
						<td><b>Sum Sent
						<td><b>Sent Date
						<td><b>Priority
						<td><b>Status 
					</tr>
					
					<%
						org.springframework.context.ApplicationContext context = new org.springframework.context.support.ClassPathXmlApplicationContext(
								"spring/application-config.xml");
						com.bionic.edu.PayListService payListService = (com.bionic.edu.PayListService) context
								.getBean("payListServiceImpl");
						com.bionic.edu.MerchantService merchantService = (com.bionic.edu.MerchantService) context
								.getBean("merchantServiceImpl");

						java.util.List<com.bionic.edu.PayList> notPaidPaymentLists = payListService.findNotPaid();

						java.util.Map<Integer, com.bionic.edu.PayList> notPaidPLMap = new java.util.HashMap();
						for (com.bionic.edu.PayList pl : notPaidPaymentLists) {
							notPaidPLMap.put(pl.getMerchantId(), pl);
						}

						java.util.List<com.bionic.edu.Merchant> merchants = merchantService.findReadyToBePayed();
						java.util.Date utilDate = new java.util.Date();
						java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
						java.sql.Timestamp timestamp = new java.sql.Timestamp(sqlDate.getTime());

						for (com.bionic.edu.Merchant merch : merchants) {
							com.bionic.edu.PayList pl = new com.bionic.edu.PayList();
							Integer merchantId = merch.getId();
							pl.setMerchantId(merchantId);
							pl.setSentDate(timestamp);
							pl.setStatus("NotPaid");
							pl.setSumSent(merch.getNeedToSend());
							pl.setPriority(1);

							com.bionic.edu.PayList notPaidPL = notPaidPLMap.get(merchantId);
							if (notPaidPL != null) {
								notPaidPL.setStatus("Modified");
								payListService.save(notPaidPL);
								pl.setPriority(notPaidPL.getPriority() + 1);
							}

							payListService.save(pl);
						}
						java.util.List<com.bionic.edu.PayList> list = payListService.findNotPaid();
						for (com.bionic.edu.PayList payList : list) {
							out.print("<tr>");
							out.print("<td>" + payList.getMerchantId());
							out.print("<td>" + payList.getSumSent());
							out.print("<td>" + payList.getSentDate());
							out.print("<td>" + payList.getPriority());
							out.print("<td>" + payList.getStatus());
							out.print("</tr>");
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


