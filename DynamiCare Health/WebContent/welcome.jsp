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
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
if (session.getAttribute("username")==null){
response.sendRedirect("L.jsp");	
}
%>
<h2>Welcome</h2>
<form action="L2.jsp">
<input type="submit" value="Logout">
</form>
</body>
</html>