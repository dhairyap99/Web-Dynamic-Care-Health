<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.io.mail.Mailer" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%!
Connection con1;
Statement st4,st1,st2,st5,st6,st7,st8;
ResultSet rs1,rs2,rs5,rs6;
String b,pf,pl,df,dl,email,user,p;
float pbalance,dbalance,charges;
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
	rs1=st1.executeQuery("SELECT fname,lname,mail,uname from users WHERE uname in (SELECT pname from booking WHERE bookingid='"+b+"') limit 1");
	
	while(rs1.next()){
		pf=rs1.getString(1);
		pl=rs1.getString(2);
		email=rs1.getString(3);
		p=rs1.getString(4);
	}
	
	st2=con1.createStatement();
	rs2=st2.executeQuery("SELECT fname,lname,uname from users WHERE uname in (SELECT dname from booking WHERE bookingid='"+b+"') limit 1");
	while(rs2.next()){
		df=rs2.getString(1);
		dl=rs2.getString(2);
		user=rs2.getString(3);
	}
	
	st5=con1.createStatement();
	rs5=st5.executeQuery("SELECT `money` FROM `wallet` WHERE `username`='"+p+"'");
	while(rs5.next()){
		pbalance=Float.valueOf(rs5.getString(1));
	}
		
	st6=con1.createStatement();
	rs6=st6.executeQuery("SELECT wallet.money,doctordetails.charges "
			+"FROM doctordetails INNER JOIN wallet "
			+"ON doctordetails.username=wallet.username "
			+"WHERE doctordetails.username='"+user+"'");
	while(rs6.next()){
		dbalance=Float.valueOf(rs6.getString(1));
		charges=Float.valueOf(rs6.getString(2));
	}
	
	dbalance=dbalance-charges;
	pbalance=pbalance+charges;
	
	st7=con1.createStatement();
	int row1 = st7.executeUpdate("UPDATE `wallet` SET `money`=" + pbalance + " WHERE `username`='" + p + "'");
	
	st8=con1.createStatement();
	int row2 = st8.executeUpdate("UPDATE `wallet` SET `money`=" + dbalance + " WHERE `username`='" + user + "'");
	
	String subject="Appointment Cancelled";
	String msg="Dear "+pf+" "+pl+",\nSorry to inform you that your appointment with Dr. "+df+" "+dl+" has been cancelled. \n";
	msg+="Rs. "+charges+" has been refunded to your account.";
	Mailer.send(email, subject, msg);	
	session.setAttribute("user",user);
	response.sendRedirect("AppointmentPat.jsp");
	}
catch(Exception e){
	out.println(e);
}
 %>
</body>
</html>