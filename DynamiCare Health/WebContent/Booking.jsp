<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%> 
<%@page import="java.util.Calendar" %>
<%@page import="java.text.SimpleDateFormat"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%!Connection con;
Statement st,st1;
ResultSet rs,rs1;
String patname,docname,firstname,lastname,max,min,sh;
String shifts[];
%>
<html>
<head>
<title>Book Appointment</title>
<style type="text/css">
body {
	background: #5252d4;
}

.form {
	background: #ffffff;
	color: white;
	font-family: Calibri;
	font-size: 18px;
	padding: 8px;
}

.title {
	background: #eb1736;
	color: white;
	padding: 14px;
	text-align: center;
	border-top-left-radius: 30px;
	border-top-right-radius: 30px;
}

.left {
	background: white;
	position: absolute;
	left: 0.6%;
	width: 97.6%;
	height: 36%;
	padding-left: 1%;
	border-right: 2.5px dashed white;
	border-bottom-left-radius: 30px;
	border-bottom-right-radius: 30px;
}

.centered {
	position: absolute;
	top: 58%;
	left: 0.6%;
	height: 8%;
	width: 98.7%;
}

.submit {
	background: #101357;
	color: white;
	height: 100%;
	font-size: 24px;
	position: relative;
	left: 38%;
	border: 2px solid #101357;
	width: 25%;
	top:2%;
	border-radius: 35px;
}

td {
	text-align: left;
	color: #eb1736;
	font-weight: bold;
}
</style>
</head>
<body>
<%
patname=session.getAttribute("pname").toString();
docname=session.getAttribute("dname").toString();
try {
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
	st=con.createStatement();
	rs=st.executeQuery("SELECT `fname`,`lname` FROM `users` WHERE `uname`='"+docname+"'");
	while (rs.next()){
		firstname=rs.getString(1);
		lastname=rs.getString(2);
	}
	session.setAttribute("fname",firstname);
	session.setAttribute("lname",lastname);
	st1=con.createStatement();
	rs1=st1.executeQuery("SELECT `shifts` FROM `doctordetails` WHERE `username`='"+docname+"'");
	while (rs1.next()){
		sh=rs1.getString(1);
	}
	shifts=sh.split(",");
}
catch(Exception e){
	out.println(e);
}
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Calendar c = Calendar.getInstance();
Date d=new Date();
c.setTime(d);
min = sdf.format(d);
c.add(Calendar.DATE, 30);
max = sdf.format(c.getTime());
%>
	<div class="title">
		<h2 style="font-family: Verdana">Enter Booking Details</h2>
		<hr>
	</div>
	<div class="form">
		<form action="ConfirmBooking.jsp" method="get" autocomplete="on">
			<div class="left">
				<table cellpadding="6">
					<tr>
						<td>User Name:</td>
						<td><input type="text" name="user" size="40"
							value="<%= patname %>" readonly="readonly"
							style="color: #eb1736"></td>
					</tr>
					<tr>
					<td>Doctor Name:</td>
						<td><input type="text" name="doctor" size="40"
							value="Dr. <%= firstname %> <%= lastname %>" readonly="readonly"
							style="color: #eb1736"></td>
					</tr>

					<tr>
						<td>Date:</td>
						<td><input type="date" name="date" min=<%= min %> max=<%= max %>></td>
					</tr>
					<tr>
					<td>Time Slots</td>
					<td>Morning (9:00 AM to 12:00 PM)</td>
					<td>Afternoon (12:00 PM to 4:00 PM)</td>
					<td>Evening (4:00 PM to 7:00 PM)</td>
					<td>Night (7:00 PM to 11:00 PM)</td>
					</tr>
					<tr>
						<td>Preferred Time:</td>
						<% for (String x:shifts){%>							
						<td><input type="radio" name="time" value=<%= x %>><%= x %></td>							
							<%}%>
					</tr>

					<tr>
						<td>Reason:</td>
						<td><input type="text" name="reas" size="40"></td>
					</tr>
				</table>

			</div>
			<div class="centered">
				<input type="submit" value="BOOK" class="submit">
			</div>
		</form>
	</div>
</body>
</html>

