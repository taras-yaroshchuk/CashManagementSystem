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
			com.bionic.edu.PayListService payListService = (com.bionic.edu.PayListService) context
					.getBean("payListServiceImpl");
			com.bionic.edu.MerchantService merchantService =(com.bionic.edu.MerchantService)context
					.getBean("merchantServiceImpl");

			java.util.Date utilDate = new java.util.Date();
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			java.sql.Timestamp timestamp = new java.sql.Timestamp(sqlDate.getTime());

			Double sum = Double.valueOf(request.getParameter("sum"));
			java.util.List<com.bionic.edu.PayList> list = payListService.getSortedList();
			for (com.bionic.edu.PayList pl : list) {
				Double sumSent = pl.getSumSent();
				Double residue = sum - sumSent;
				if (residue >= 0) {
					sum = sum - sumSent;
					com.bionic.edu.Merchant m = merchantService.findById(pl.getMerchantId());
					m.setNeedToSend(m.getNeedToSend() - pl.getSumSent());
					m.setLastSent(sqlDate);
					pl.setStatus("Paid");
					
					merchantService.save(m);
					payListService.save(pl);
				} else {
					int priority = pl.getPriority();
					pl.setPriority(priority + 1);
				}
				out.print("<tr>");
				out.print("<td>" + pl.getMerchantId());
				out.print("<td>" + pl.getSumSent());
				out.print("<td>" + pl.getSentDate());
				out.print("<td>" + pl.getPriority());
				out.print("<td>" + pl.getStatus());
				out.print("</tr>");
			}
			
			out.print("<tr>Residue : " + sum + "</tr>");
		%>
	</table>
</body>
</html>