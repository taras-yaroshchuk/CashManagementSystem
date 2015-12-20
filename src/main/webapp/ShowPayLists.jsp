<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Get PaymentLists</title>
<link rel="stylesheet" type="text/css" href="web.css" />
</head>

<body>
	<h1>PaymentLists:</h1>
	<table>
		<tr>
			<td>Merchant Id
			<td>Sum Sent
			<td>Sent Date
			<td>Priority
			<td>Status
		</tr>
		<%
			org.springframework.context.ApplicationContext context = new org.springframework.context.support.ClassPathXmlApplicationContext(
					"spring/application-config.xml");
			com.bionic.edu.PaymentListService payListService = (com.bionic.edu.PaymentListService) context
					.getBean("paymentListServiceImpls");
			java.util.List<com.bionic.edu.PaymentList> list = payListService.findAll();
			for (com.bionic.edu.PaymentList pl : list) {
				out.print("<tr>");
				out.print("<td>" + pl.getMerchantId());
				out.print("<td>" + pl.getSumSent());
				out.print("<td>" + pl.getSentDate());
				out.print("<td>" + pl.getPriority());
				out.print("<td>" + pl.getStatus());
				out.print("</tr>");
			}
		%>
	
</body>
</html>