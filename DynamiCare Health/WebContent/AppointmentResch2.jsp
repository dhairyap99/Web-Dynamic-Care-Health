<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="net.io.mail.Mailer"%>
    
<!DOCTYPE html>
<%!Connection con;
	Statement st,st1,st2;
	ResultSet rs,rs1;
	int row;
	String u,mail,subject,msg,df,dl,bid,dmail,dmsg,pf,pl,date,time;
	StringBuffer otp;%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reschedule Appointment</title>
</head>
<body>
<%
bid=request.getParameter("b");
u=session.getAttribute("user").toString();
date=request.getParameter("d");
time=request.getParameter("t");
try {
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");
	st = con.createStatement();
	rs=st.executeQuery("SELECT `fname`,`lname`,`mail` FROM `users` WHERE `uname`='"+u+"'");
	while(rs.next()){
		pf=rs.getString(1);
		pl=rs.getString(2);
		mail=rs.getString(3);
	}
	
	st1=con.createStatement();
	rs1=st1.executeQuery("SELECT users.fname,users.lname,users.mail "
			+"from users INNER JOIN booking "
			+"ON users.uname=booking.dname "
			+"where booking.bookingid='"+bid+"'");
	while(rs1.next()){
		df=rs1.getString(1);
		dl=rs1.getString(2);
		dmail=rs1.getString(3);
	}
	
	st2=con.createStatement();
	row=st2.executeUpdate("UPDATE `booking` SET `date`='"+date+"',`shift`='"+time+"',`status`=0,`time`=NULL WHERE `bookingid`='"+bid+"'");
}
catch(Exception e){
	out.println(e);
}

subject="Appointment Rescheduling Requested";
msg="You have requested for rescheduling of appointment with Dr. "+df+" "+dl+" on "+date+" at "+time+". (Booking ID: "+bid+")";
Mailer.send(mail,subject,msg);

dmsg=pf+" "+pl+" has requested for rescheduling of appointment on "+date+" at "+time+". Kindly address the request. (Booking ID: "+bid+")";
Mailer.send(dmail,subject,dmsg);

session.setAttribute("user",u);
session.setAttribute("msg",subject);
response.sendRedirect("HomePagePatient.jsp");
%>

</body>
</html>