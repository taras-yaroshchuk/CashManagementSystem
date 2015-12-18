<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>
	<h2>
	<%
	if(request.getParameter("psw").equals("admin"))
		out.println("Hello, " + request.getParameter("login"));
	else 
		out.println("Wrong password!");
	%>
	</h2>
	</body>
</html>