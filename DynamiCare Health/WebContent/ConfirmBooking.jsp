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
	Statement st2,st3,st4,st5,st6,st7;
	ResultSet rs2,rs4,rs5;
	String p,t,r,date,f,l,user;
	StringBuffer bookingid;
	float pbalance,dbalance,charges;%>
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
	
	p=request.getParameter("user");
	t=request.getParameter("time");
	r=request.getParameter("reas");
	date=request.getParameter("date");
	
	st4=con2.createStatement();
	rs4=st4.executeQuery("SELECT `money` FROM `wallet` WHERE `username`='"+p+"'");
	while(rs4.next()){
		pbalance=Float.valueOf(rs4.getString(1));
	}
	
	st3=con2.createStatement();
	rs2=st3.executeQuery("SELECT uname FROM `users` WHERE `fname`='"+f+"' and `lname`='"+l+"' limit 1");
	
	while(rs2.next())
	{
		user=rs2.getString(1);
	}
	
	st5=con2.createStatement();
	rs5=st5.executeQuery("SELECT wallet.money,doctordetails.charges "
			+"FROM doctordetails INNER JOIN wallet "
			+"ON doctordetails.username=wallet.username "
			+"WHERE doctordetails.username='"+user+"'");
	while(rs5.next()){
		dbalance=Float.valueOf(rs5.getString(1));
		charges=Float.valueOf(rs5.getString(2));
	}
	
	if (pbalance>=charges){
	pbalance=pbalance-charges;
	dbalance=dbalance+charges;	
			
	String characters="QWERTYUIOPASDFGHJKLZXCVBNM";
	bookingid=new StringBuffer("");
	
	for (int i=1;i<=3;i++){
		bookingid.append(characters.charAt((int)(Math.random()*26)));
	}
	
	for (int i=4;i<=9;i++){
		bookingid.append((int)(Math.random()*9));
	}
	
	String b=bookingid.toString();
	st6=con2.createStatement();
	int row = st6.executeUpdate("UPDATE `wallet` SET `money`=" + pbalance + " WHERE `username`='" + p + "'");
	
	st7=con2.createStatement();
	int row1 = st7.executeUpdate("UPDATE `wallet` SET `money`=" + dbalance + " WHERE `username`='" + user + "'");
	
	st2=con2.createStatement();
	int row2=st2.executeUpdate("INSERT INTO `booking`(`bookingid`, `pname`, `dname`, `date`, `shift`, `reason`) VALUES ('"
	+b+"','"+p+"','"+user+"','"+date+"','"+t+"','"+r+"')");
	
	String redirectURL = "/DynamiCare_Health/HomePagePatient.jsp";
	session.setAttribute("user",p);
	session.setAttribute("msg","Booking Successful. Your Booking Id is "+b);
    response.sendRedirect(redirectURL);
    }
	else {
		String redirectURL = "/DynamiCare_Health/HomePagePatient.jsp";
		session.setAttribute("user",p);
		session.setAttribute("msg","Insufficient Balance");
	    response.sendRedirect(redirectURL);
	    }}
catch(Exception e){
	out.println(e);
}
%>
</body>
</html>