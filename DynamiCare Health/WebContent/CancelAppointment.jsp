<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.io.mail.Mailer" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%!
Connection con1;
Statement st4,st1,st2;
ResultSet rs1,rs2;
String b,pf,pl,df,dl,email,user;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cancel Appointment</title>
</head>
<body>
<% 
b=request.getParameter("b");
try {
	Class.forName("com.mysql.jdbc.Driver");
	con1=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
	st4=con1.createStatement();
	int row=st4.executeUpdate("UPDATE `booking` SET `status`=-1 WHERE `bookingid`='"+b+"'");
	
	st1=con1.createStatement();
	rs1=st1.executeQuery("SELECT fname,lname,mail from users WHERE uname in (SELECT pname from booking WHERE bookingid='"+b+"') limit 1");
	while(rs1.next()){
		pf=rs1.getString(1);
		pl=rs1.getString(2);
		email=rs1.getString(3);
	}
	
	st2=con1.createStatement();
	rs2=st2.executeQuery("SELECT fname,lname,uname from users WHERE uname in (SELECT dname from booking WHERE bookingid='"+b+"') limit 1");
	while(rs2.next()){
		df=rs2.getString(1);
		dl=rs2.getString(2);
		user=rs2.getString(3);
	}
	
	String subject="Appointment Cancelled";
	String msg="Dear "+pf+" "+pl+",\nSorry to inform you that your appointment with Dr. "+df+" "+dl+" has been cancelled. ";
	Mailer.send(email, subject, msg);	
	session.setAttribute("user",user);%>
	<%@ include file="AppointmentPat.jsp"%>
<%}
catch(Exception e){
	out.println(e);
}
 %>
</body>
</html>