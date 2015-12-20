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
			<td>Address
			<td>Email
			<td>CCNo
			<td>CCType
		</tr>
		<%
			org.springframework.context.ApplicationContext context = 
			new org.springframework.context.support.ClassPathXmlApplicationContext("spring/application-config.xml");
			com.bionic.edu.CustomerService customerService = (com.bionic.edu.CustomerService)context
					.getBean("customerServiceImpl");
			com.bionic.edu.Customer customer = new com.bionic.edu.Customer();
			customer.setName(request.getParameter("name"));
			customer.setAddress(request.getParameter("address"));
			customer.setEmail(request.getParameter("email"));
			customer.setCcNo(request.getParameter("ccno"));
			customer.setCcType(request.getParameter("cctype"));
			java.util.Date utilDate = new java.util.Date();
		    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			customer.setMaturity(sqlDate);
			customerService.save(customer);
			java.util.List<com.bionic.edu.Customer> list = customerService.findAll();
			for (com.bionic.edu.Customer c : list) {
				out.print("<tr>");
				out.print("<td>" + c.getName());
				out.print("<td>" + c.getAddress());
				out.print("<td>" + c.getEmail());
				out.print("<td>" + c.getCcNo());
				out.print("<td>" + c.getCcType());
				out.print("</tr>");
			}
		%>
	</table>
</body>
</html>

