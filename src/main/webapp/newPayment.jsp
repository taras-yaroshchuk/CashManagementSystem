<%@page import="java.time.Instant"%>
<%@page import="com.bionic.edu.Merchant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="web.css" />
<title>Merchant List</title>
</head>
<body>
	<h1>Payment List</h1>
	<table>
		<tr>
			<td>Merchant Id
			<td>Customer Id
			<td>Goods
			<td>Sum payed
			<td>Charge payed
		</tr>
		<%
			org.springframework.context.ApplicationContext context = 
			new org.springframework.context.support.ClassPathXmlApplicationContext("spring/application-config.xml");
			com.bionic.edu.PaymentService paymentService =
					(com.bionic.edu.PaymentService)context
					.getBean("paymentServiceImpl");
			com.bionic.edu.MerchantService merchantService =(com.bionic.edu.MerchantService)context
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
			payment.setDt(new java.sql.Timestamp(sqlDate.getDate()));
			
			com.bionic.edu.Merchant merchant = merchantService.findById(merchId);
			Double chargePayed = (sumPayed / 100) * merchant.getCharge();
			payment.setChargePayed(chargePayed);
			
			merchant.setNeedToSend( merchant.getNeedToSend() + sumPayed - chargePayed);
			
			merchantService.save(merchant);
			paymentService.save(payment);
			
			java.util.List<com.bionic.edu.Payment> list = paymentService.findAll();
			for (com.bionic.edu.Payment p : list) {
				out.print("<tr>");
				out.print("<td>" + p.getCustomerId());
				out.print("<td>" + p.getCustomerId());
				out.print("<td>" + p.getGoods());
				out.print("<td>" + p.getSumPayed());
				out.print("<td>" + p.getChargePayed());
				out.print("</tr>");
			}
		%>
	</table>
</body>
</html>

