<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<%
session.removeAttribute("user");
session.removeAttribute("msg");
session.invalidate();
response.sendRedirect("Login1.jsp");
%>
</body>
</html>