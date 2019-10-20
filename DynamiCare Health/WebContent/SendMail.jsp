<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet" %>
<%@page import="javax.servlet.http.HttpServlet" %>
<%@page import="net.io.mail.Mailer" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
response.setContentType("text/html");  
	    String to=request.getParameter("to"); 
	    String subject=request.getParameter("subject");  
	    String msg=request.getParameter("msg");  
	          
	   Mailer.send(to, subject, msg); 
	    out.print("message has been sent successfully");  
	    out.close();  
%>
</body>
</html>