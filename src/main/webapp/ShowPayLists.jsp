<%@ page import="com.bionic.edu.service.PayListService" %>
<%@ page import="com.bionic.edu.model.PayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Pay list</title>

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
					<a href="WEB-INF/jsp/merchantsList.jsp" class="list-group-item" align="center">Show
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
					<a href="showPayLists.jsp" class="list-group-item active"
						align="center">Show all Pay Lists</a>
					</li> <a href="workOutPayLists.jsp" class="list-group-item"
						align="center">Work out Pay Lists</a>
					</li> <a href="send.jsp" class="list-group-item" align="center">Sending
						money page</a>
					</li>
				</div>
			</div>
			<div class="col-sm-8">
				<h3 align="center">Pay Lists</h3>
				<form action="updatePayList.jsp" method="POST"
					role="form-horizontal">
					<table class="table table-striped table-bordered">

						<tr>
							<th>Merchant Id
							<th>Sum Sent
							<th>Formed Date
							<th>Sent Date
							<th>Priority
							<th>Status
						</tr>

						<%
							org.springframework.context.ApplicationContext context = new org.springframework.context.support.ClassPathXmlApplicationContext(
									"spring/application-config.xml");
							PayListService payListService = (PayListService) context
									.getBean("payListServiceImpl");

							java.util.List<PayList> list = payListService.findAll();

							for (PayList pl : list) {
								int id = pl.getId();
								out.print("<tr>");
								out.print("<td align=\"right\" >" + pl.getMerchantId());
								out.print("<td align=\"right\" >" + pl.getSumSent());
								out.print("<td>" + pl.getFormedDate());
								out.print("<td>" + pl.getSentDate());
								if (pl.getStatus().equals("NotPaid")) {
									out.print("<td><input type=\"number\" name=\"" + id + "\" min=\"0\" "
											+ " max=\"40\" size=\"1\" value=\"" + pl.getPriority() + "\">");
								} else {
									out.print("<td>" + pl.getPriority());
								}
								out.print("<td>" + pl.getStatus());
								out.print("</tr>");
							}
						%>

					</table>
					<button type="submit" class="btn btn-primary btn-block">Update
						priorities</button>
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
