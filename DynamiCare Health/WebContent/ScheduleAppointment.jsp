<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.io.mail.Mailer"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%!
Connection con1;
Statement st4,st1,st2,st3;
ResultSet rs1,rs2,rs3;
String t,b,pf,pl,df,dl,email,user,dateInString,timeInString,dString,tString,pat;
float pbal,dbal,dch;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Schedule Appointment</title>
</head>
<body>
	<%
t=request.getParameter("appt");
b=request.getParameter("b");
try {
	Class.forName("com.mysql.jdbc.Driver");
	con1=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
	st4=con1.createStatement();
	int row=st4.executeUpdate("UPDATE `booking` SET `time`='"+t+"',`status`=1 WHERE `bookingid`='"+b+"'");
	
	st1=con1.createStatement();
	rs1=st1.executeQuery("SELECT users.fname,users.lname,users.mail from users "
			+"WHERE uname in (SELECT pname from booking WHERE bookingid='"+b+"') limit 1");
	while(rs1.next()){
		pf=rs1.getString(1);
		pl=rs1.getString(2);
		email=rs1.getString(3);
	}
	
	st2=con1.createStatement();
	rs2=st2.executeQuery("SELECT users.fname,users.lname,users.uname from users "
			+"WHERE uname in (SELECT dname from booking WHERE bookingid='"+b+"') limit 1");
	while(rs2.next()){
		df=rs2.getString(1);
		dl=rs2.getString(2);
		user=rs2.getString(3);
	}
	
		String subject="Appointment Confirmed";	
	String msg="Dear "+pf+" "+pl+",\n"+"Your appointment with Dr. "+df+" "+dl+" is confirmed at ";
	st3=con1.createStatement();
	rs3=st3.executeQuery("SELECT `date`,`time` FROM `booking` WHERE `bookingid`='"+b+"' limit 1");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat formatter = new SimpleDateFormat("EEEE, MMM dd, yyyy");
	SimpleDateFormat sd = new SimpleDateFormat("HH:mm:ss");
	SimpleDateFormat formatter1 = new SimpleDateFormat("KK:mm a");

	while(rs3.next()){
		dateInString=rs3.getString(1);
		timeInString=rs3.getString(2);
	}
    dString=formatter.format(sdf.parse(dateInString));
    tString=formatter1.format(sd.parse(timeInString));
	
	msg+=tString+" on "+dString+".\nYour booking id is "+b+".";
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