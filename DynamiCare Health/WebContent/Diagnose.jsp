<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%!
Connection con1;
Statement st1,st2;
ResultSet rs1,rs2;
String pf,pl,df,dl;
%>
<html>
<head>
<title>Diagnose</title>
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
	height: 65%;
	padding-left: 1%;
	border-right: 2.5px dashed white;
	border-bottom-left-radius: 30px;
	border-bottom-right-radius: 30px;
}

.centered {
	position: absolute;
	top: 87%;
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
String patname=request.getParameter("u");
String bid=request.getParameter("bid");
String docname=session.getAttribute("docname").toString();
String email="";

try {
	Class.forName("com.mysql.jdbc.Driver");
	con1=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
	
	st1=con1.createStatement();
	rs1=st1.executeQuery("SELECT fname,lname,mail FROM users WHERE uname='"+patname+"' Limit 1");
	
	while(rs1.next()){
		pf=rs1.getString(1);
		pl=rs1.getString(2);
		email=rs1.getString(3);
	}
	
	st2=con1.createStatement();
	rs2=st2.executeQuery("SELECT fname,lname FROM users WHERE uname='"+docname+"' Limit 1");
	
	while(rs2.next()){
		df=rs2.getString(1);
		dl=rs2.getString(2);
	}
	
}
catch (Exception e){
	System.out.println(e);
}
%>
	<div class="title">
		<h2 style="font-family: Verdana">Diagnose</h2>
		<hr>
	</div>
	<div class="form">
		<form action="GeneratePDF.jsp" method="get" autocomplete="on">
			<div class="left">
				<table cellpadding="6">
					<tr>
					<td>Patient Name: </td>
					<td><input type="text" name="patname" value="<%= pf %> <%= pl %>" readonly="readonly" style="color: #eb1736"></td>
					</tr>
					
					<tr>
					<td>Doctor Name: </td>
					<td><input type="text" name="docname" value="Dr. <%= df %> <%= dl %>" readonly="readonly" style="color: #eb1736"></td>
					</tr>
					
					<tr>
					<td>Booking Id: </td>
					<td><input type="text" name="bid" value=<%= bid %> readonly="readonly" style="color: #eb1736"></td>
					</tr>
					
					<tr>
						<td>Diagnosis:</td>
						<td><textarea rows="5" cols="100" name="d"></textarea></td>
					</tr>
					
					<tr>
						<td>Prescription:</td>
						<td><textarea rows="5" cols="100" name="p"></textarea></td>
					</tr>
					
					<tr>
						<td>Additional Comments:</td>
						<td><textarea rows="5" cols="100" name="ac"></textarea></td>
					</tr>
				
				</table>

			</div>
						<input type="hidden" name="dname" value=<%=docname%>>
						<input type="hidden" name="email" value=<%=email%>>
			<div class="centered">
				<input type="submit" value="SUBMIT" class="submit">
			</div>
		</form>
	</div>
</body>
</html>

