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
String u=request.getParameter("uname");
String p=request.getParameter("pass");

if (u.equals("rkasale28") && p.equals("abc")){
	session.setAttribute("username",u);
	response.sendRedirect("welcome.jsp");
}
else{
	response.sendRedirect("L.jsp");
}
%>
</body>
</html>