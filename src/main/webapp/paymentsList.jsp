<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">


<title>List of Payments</title>

 <link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/r/bs-3.3.5/jq-2.1.4,dt-1.10.8/datatables.min.css" />

<script type="text/javascript"
	src="https://cdn.datatables.net/r/bs-3.3.5/jqc-1.11.3,dt-1.10.8/datatables.min.js"></script>
 
 
<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		$('#paymentsTable').DataTable();
	});
</script>

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
					<a href="paymentsList.jsp" class="list-group-item active"
						align="center">Show list of Payments</a>
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
				<h3 align="center">List of Payments</h3>
				<table id="paymentsTable" class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>Merchant Id
							<th>Customer Id
							<th>Goods
							<th>Sum payed
							<th>Charge payed
						</tr>
					</thead>
					<tbody>
						<%
							org.springframework.context.ApplicationContext context = new org.springframework.context.support.ClassPathXmlApplicationContext(
									"spring/application-config.xml");
							com.bionic.edu.PaymentService paymentService = (com.bionic.edu.PaymentService) context
									.getBean("paymentServiceImpl");

							java.util.List<com.bionic.edu.Payment> list = paymentService.findAll();

							for (com.bionic.edu.Payment p : list) {
								out.print("<tr>");
								out.print("<td>" + p.getMerchantId());
								out.print("<td>" + p.getCustomerId());
								out.print("<td>" + p.getGoods());
								out.print("<td>" + p.getSumPayed());
								out.print("<td>" + p.getChargePayed());
								out.print("</tr>");
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>



	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.js"></script>


</body>
</html>
