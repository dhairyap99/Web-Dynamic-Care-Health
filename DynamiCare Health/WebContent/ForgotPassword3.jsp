<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Forgot Password</title>
</head>
<body>
<%
String u=session.getAttribute("uname").toString();
String otp1=session.getAttribute("otp").toString();
String otp2=request.getParameter("otp1");
out.println(otp1.equals(otp2));
if (otp1.equals(otp2)){
	session.setAttribute("msg", null);
	String redirectURL = "/DynamiCare_Health/ForgotPassword4.jsp";
	response.sendRedirect(redirectURL);	
}
else{
	String redirectURL = "/DynamiCare_Health/Login1.jsp";
session.setAttribute("msg","OTPs don't match");
response.sendRedirect(redirectURL);
}
session.setAttribute("uname", u);
%>
</body>
</html>