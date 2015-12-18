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
	<h1>Merchant List</h1>
	<table>
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
			java.util.List<com.bionic.edu.Merchant> list = merchantService.findAll();
			for (com.bionic.edu.Merchant m : list) {
				out.print(m.getDataForWeb());
			}
		%>
	</table>
</body>
</html>

