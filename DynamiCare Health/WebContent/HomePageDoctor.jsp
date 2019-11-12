<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%!Connection con2;
Statement st2;
ResultSet rs2;
String us,se,ag,p,sp;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DynamiCare Health</title>
<style type="text/css">
#userdetails {
border: 1px solid black;
	background-color: white;
	color: black;
	padding: 6px;
	border-radius: 20px;
	font-family: helvetica;
	position: relative;
	width: 40%;
	left:700px;
	height:350px;
	top: 80px;
}

.icons {
	border: 1px;
	padding: 6px;
	height: 50px;
}

a {
	color: white;
	text-decoration: none;
}

.back {
	width: 100%;
	position: absolute;
	z-index: -1;
	left: 0%;
	top:48px;
}

.head {
	text-align: center;
	position: absolute;
	left: 1%;
	width: 45%;
	height: 76%;
	color: black;
	vertical-align: middle;
	top:10%
}

.profile {
	width: 20%;
}

.text {
	position: relative;
	top: 45px;
	font-size: 90px;
	font-weight: bolder;
}

.topnav {
	overflow: hidden;
	background-color: #333;
	position:absolute;
	top:0px;
	left:0px;
	width:100%;
}

.topnav a {
	float: left;
	color: #f2f2f2;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
	font-size: 17px;
}

.topnav a:hover {
	background-color: #ddd;
	color: black;
}

.topnav a.active {
	background-color: #4CAF50;
	color: white;
}
</style>
</head>

<body>
<%
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
if (session.getAttribute("user")==null){
response.sendRedirect("Login1.jsp");	
}
if (session.getAttribute("msg")!=null){
	String message=session.getAttribute("msg").toString();
	out.println("<script>alert(\""+message+"\")</script>");
}
	%>
<center>
		<div class="topnav">			
				<a href="" class="active"> DC-Health</a>
				<a href="DetailsDoc.jsp"> View Details</a>
				<a href="AppointmentPat.jsp"> Schedule Appointment</a>
				<a href="ViewSchedule.jsp"> View Schedule</a>
				<a href="Payments.jsp"> Payments </a>
				<a href="Logout.jsp" style="float:right;">Logout</a>
		</div>
	</center>
	
	<%
	session.setAttribute("msg",null);
	try {
	Class.forName("com.mysql.jdbc.Driver");
	con2=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");

	st2=con2.createStatement();
	
	us=session.getAttribute("user").toString();
	
	rs2=st2.executeQuery("SELECT `sex`,`age`,`phone`,`specification` FROM `doctordetails` WHERE `username`='"+us+"'");
	
	while(rs2.next()){
		se=rs2.getString(1);
		ag=rs2.getString(2);
		p=rs2.getString(3);
		sp=rs2.getString(4);
	}
}
catch(Exception e){
	out.println(e);
}
%>

	<img class="back" alt="back" src="images/lhc.jpg">

	<div class="head">
		<span class="text">Welcome to <br>DynamiCare Health
		</span>
	</div>

	<div id="userdetails">
		<center>
			<% if (se.equals("Male")){ 
			out.println("<img src='images/doctorMale.png' class='profile'/>");
		}
		else{
			out.println("<img src='images/doctorFemale.png' class='profile'/>");
		}%>
			<h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;User Details</h2>
			<table style="font-family: verdana;" cellpadding="6">
				<tr>
					<td><b>User Name:</b></td>
					<td><%= us %></td>
				</tr>

				<tr>
					<td><b>Age: </b></td>
					<td><%= ag %></td>
				</tr>

				<tr>
					<td><b>Sex: </b>
					<td><%= se %></td>
				</tr>

				<tr>
					<td><b>Phone: </b>
					<td><%= p %></td>
				</tr>

				<tr>
					<td><b>Specification: </b>
					<td><%= sp %></td>
				</tr>
			</table>
		</center>
	</div>

	<%
			session.setAttribute("user",us);
			%>
</body>
</html>