<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%> 
<%@page import="java.util.Calendar" %>
<%@page import="java.util.TimeZone" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%!Connection con;
Statement st;
ResultSet rs;
String uname;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Today's Schedule</title>
</head>
<style>
body{
		background:  #5252d4;
	}
.title{
		background: #eb1736;
		color: white;
		padding: 14px;
		text-align: center;
		border-top-left-radius:30px;		
		border-top-right-radius:30px;
	}
	
td{
text-align:center;
font-size:18px;
font-family: Verdana;
}

a {
	text-decoration: none;
	color: #eb1736;
}

.bold{
font-weight:bolder;
}

table{	
border-collapse:collapse;
	color: #eb1736;
		background: white;
		position: absolute;
		left:0.6%;
		width:98.9%;
		padding-left: 1%;
		border-right: 2.5px dashed white;
		border-bottom-left-radius:30px;
		border-bottom-right-radius:30px;
	}
	
</style>
<body>
<div class="title">
		<h2 style="font-family: Verdana">Diagnosis</h2>
		<hr>
	</div>
<table cellpadding="6">
<tr class="bold" style="border-bottom:1px solid black">
<td>Doctor Name</td>
<td>Date</td>
<td>Time</td>
<td>Reason</td>
</tr>
<%

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Calendar c = Calendar.getInstance();
Date d=new Date();
c.setTime(d);
String today = sdf.format(d);

SimpleDateFormat sd = new SimpleDateFormat("HH:mm:ss");

uname=request.getParameter("u"); 
Class.forName("com.mysql.jdbc.Driver");
con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
st=con.createStatement();

rs=st.executeQuery("SELECT users.fname,users.lname,booking.date,booking.time,booking.reason,users.uname "
		+"FROM `booking` INNER JOIN `users` "
		+"ON booking.dname=users.uname WHERE "
		+"booking.pname='"+uname+"' and booking.status=1 and booking.date<'"+today+"' "
		+"ORDER BY booking.date,booking.time");
while(rs.next()){
	out.println("<tr>");
	
	out.println("<td><a href=\"ShowProfileDoctor1.jsp?uname="+rs.getString(6)+"\">Dr. "+rs.getString(1)+" "+rs.getString(2)+"</a></td>");
	
	String dateInString=rs.getString(3); 
	SimpleDateFormat formatter = new SimpleDateFormat("EEEE, MMM dd, yyyy");
	Date date = sdf.parse(dateInString);
    out.println("<td>"+formatter.format(date)+"</td>");

	String timeInString=rs.getString(4); 
	SimpleDateFormat formatter1 = new SimpleDateFormat("KK:mm a");
	Date current = sd.parse(timeInString);
    out.println("<td>"+formatter1.format(current)+"</td>");


	out.println("<td>"+rs.getString(5)+"</td>");
	out.println("</tr>");
}
%>
</table>
</body>
</html>