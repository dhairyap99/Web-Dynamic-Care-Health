<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="net.io.mail.Mailer"%>
    
<!DOCTYPE html>
<%!Connection con;
	Statement st,st1,st2,st3,st4,st5,st6;
	ResultSet rs,rs1,rs2,rs3,rs4;
	int row;
	String u,mail,subject,msg,df,dl,bid,dmail,dmsg,pf,pl,d,date,time,bdate,btime;
	float pbalance,dbalance,charges;
	StringBuffer otp;%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cancel Appointment</title>
</head>
<body>
<%
bid=request.getParameter("b");
u=session.getAttribute("user").toString();
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
	rs1=st1.executeQuery("SELECT users.fname,users.lname,users.mail,users.uname,booking.date,booking.time "
			+"from users INNER JOIN booking "
			+"ON users.uname=booking.dname "
			+"where booking.bookingid='"+bid+"'");
	while(rs1.next()){
		df=rs1.getString(1);
		dl=rs1.getString(2);
		dmail=rs1.getString(3);
		d=rs1.getString(4);
		date=rs1.getString(5);
		time=rs1.getString(6);
	}
	
	st2=con.createStatement();
	row=st2.executeUpdate("UPDATE `booking` SET `status`=-1 WHERE `bookingid`='"+bid+"'");
	
	st3=con.createStatement();
	rs3=st3.executeQuery("SELECT `money` FROM `wallet` WHERE `username`='"+u+"'");
	while(rs3.next()){
		pbalance=Float.valueOf(rs3.getString(1));
	}
		
	st4=con.createStatement();
	rs4=st4.executeQuery("SELECT wallet.money,doctordetails.charges "
			+"FROM doctordetails INNER JOIN wallet "
			+"ON doctordetails.username=wallet.username "
			+"WHERE doctordetails.username='"+d+"'");
	while(rs4.next()){
		dbalance=Float.valueOf(rs4.getString(1));
		charges=Float.valueOf(rs4.getString(2));
	}
	
	dbalance=dbalance-charges;
	pbalance=pbalance+charges;
	
	st5=con.createStatement();
	int row1 = st5.executeUpdate("UPDATE `wallet` SET `money`=" + pbalance + " WHERE `username`='" + u + "'");
	
	st6=con.createStatement();
	int row2 = st6.executeUpdate("UPDATE `wallet` SET `money`=" + dbalance + " WHERE `username`='" + d + "'");
	
}
catch(Exception e){
	out.println(e);
}

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat formatter = new SimpleDateFormat("MMM dd, yyyy");
SimpleDateFormat sd = new SimpleDateFormat("HH:mm:ss");
SimpleDateFormat formatter1 = new SimpleDateFormat("KK:mm a");

bdate=formatter.format(sdf.parse(date));
btime=formatter1.format(sd.parse(time));

subject="Appointment Cancelled";
msg="You have cancelled appointment with Dr. "+df+" "+dl+", dated "+bdate+" at "+btime+". (Booking ID: "+bid+")";
msg+="\nRs. "+charges+" has been refunded to your account.";
Mailer.send(mail,subject,msg);

dmsg="Sorry to inform you that your appointment, dated "+bdate+" at "+btime+" with "+pf+" "+pl+" has been cancelled. (Booking ID: "+bid+")";
Mailer.send(dmail,subject,dmsg);

session.setAttribute("user",u);
session.setAttribute("msg",subject);
response.sendRedirect("HomePagePatient.jsp");
%>

</body>
</html>