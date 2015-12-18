<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>Welcome</title>
		<link rel="stylesheet" type="text/css" href="web.css" /> 
	</head> 
	<body>
		<%java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy"); %> 
		<h1>Current Date: <%= df.format(new java.util.Date()) %> 
		<br />
		<br />
		<br />
		
		<% out.println("Your IP address is " + request.getRemoteAddr()); %> 
		<br />
		<br />

		<%! int i = 0; %> 
		<%! int a, b, c; %> 
		<%! String q = "Hello"; %> 
		
		<p> 
			Today's date: <%= (new java.util.Date()).toLocaleString()%> 
		</p> 
		
		<br />
		<br />
		
		<%! int day = 7; %> 
		<% if (day == 1 | day == 7) { %> 
		<p> Today is weekend</p> 
		<% } else { %> 
		<p> Today is not weekend</p> 
		<% } %> 
		
		<br />
		<br />
		
		<% for ( int fontSize = 1; fontSize <= 5; fontSize++){ %> 
		<font color="green" size="<%= fontSize %>"> 
			JSP Tutorial 
		</font>
		
		<br /> 
		<%}%> 
		

       <%! org.springframework.context.ApplicationContext context = 
       new org.springframework.context.support.ClassPathXmlApplicationContext("spring/application-config.xml");
       com.bionic.edu.MerchantService merchantService = 
               (com.bionic.edu.MerchantService)context.getBean("merchantServiceImpl");
        	java.util.List<com.bionic.edu.Merchant> list = merchantService.findAll(); %>
		
		<h3>Merchant List</h3>
        <table>
        <tr>
        	<td>Name<td>Bank<td>Charge<td>Minimum Sum
        </tr>
        <%for(com.bionic.edu.Merchant m : list){  %>
        <tr>
        	<td> <%= m.getName() %>
        	<td> <%= m.getBankName() %>
        	<td> <%= m.getCharge() %>
        	<td> <%= m.getMinSum() %>
        </tr>
        
        <%} %>
        </table>
	</body>
</html>
