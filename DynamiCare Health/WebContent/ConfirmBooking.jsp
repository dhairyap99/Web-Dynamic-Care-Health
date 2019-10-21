<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet" %>
<%@page import="javax.servlet.http.HttpServlet" %>
<%@page import="net.io.mail.Mailer" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%!Connection con2;
	Statement st2,st3;
	ResultSet rs2;
	String p,t,r,date,f,l,user;
	StringBuffer bookingid;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<%
f=session.getAttribute("fname").toString();
l=session.getAttribute("lname").toString();
try{
	Class.forName("com.mysql.jdbc.Driver");

	con2=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
	
	st2=con2.createStatement();
	
	p=request.getParameter("user");
	t=request.getParameter("time");
	r=request.getParameter("reas");
	date=request.getParameter("date");
	
	String characters="QWERTYUIOPASDFGHJKLZXCVBNM";
	bookingid=new StringBuffer("");
	
	for (int i=1;i<=3;i++){
		bookingid.append(characters.charAt((int)(Math.random()*26)));
	}
	
	for (int i=4;i<=9;i++){
		bookingid.append((int)(Math.random()*9));
	}
	
	st3=con2.createStatement();
	rs2=st3.executeQuery("SELECT uname FROM `users` WHERE `fname`='"+f+"' and `lname`='"+l+"' limit 1");
	
	while(rs2.next())
	{
		user=rs2.getString(1);
	}
	String b=bookingid.toString();
	int row=st2.executeUpdate("INSERT INTO `booking`(`bookingid`, `pname`, `dname`, `date`, `shift`, `reason`) VALUES ('"
	+b+"','"+p+"','"+user+"','"+date+"','"+t+"','"+r+"')");%>
	<%@ include file="HomePagePatient.jsp"%>
<%}
catch(Exception e){
	out.println(e);
}
%>
</body>
</html>