<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%!Connection con1;
Statement st1;
ResultSet rs1;
String h,w,a,s,u;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>DynamiCare Health</title>
	<style type="text/css">
	#userdetails { 
		border:1px solid black; 
		background-color:white;
		color:black; 
		padding:6px;
		border-radius: 20px; 
		font-family: helvetica;
		position: absolute;
		width: 40%;
		left: 55%;
		height: 62%;
		top:3.3%;	
	} 
	
	.grid-container {
		display: grid;
		grid-template-columns: 428px 428px 428px;
		grid-template-rows: auto;
		grid-gap: 10px;
		padding: 10px;
	}

	.grid-container > div {
		background-color: #FFFFFF;
		text-align: center;
		padding-top: 20px;
		font-size: 30px;
		border: 1px solid black;
		border-radius: 25px;
	}
	
	.grid-container1 {
		display: grid;
		grid-template-columns: 321px 321px 321px 321px;
		grid-template-rows: auto;
		grid-gap: 10px;
		padding: 10px;
	}

	.grid-container1 > div {
		text-align: center;
		padding: 20px 0;
		font-size: 30px;
		border: 2px solid red;
		border-radius: 25px;
		font-family: verdana;
		background-color:black;
	}
	

	.icons{
		border:1px;
		padding:6px; 
		height:50px;
	}
	
	a{
		color:white;
		text-decoration: none;
	}
	
	.back{
		width: 99%;
		position: absolute;
		z-index: -1;
		border-radius: 5px;
		left: 0.5%;
	}
	
	.head{	
		text-align: center;
		position: absolute;
		left: 1%;
		width:45%;
		height:76%;
		color:black;
		vertical-align: middle; 
	}
	.doctors-block{
		position: absolute;
		top: 100%;
	}
	.menu-block{
		position: absolute;
		top: 70%;
		left:1%;
		margin-right:1%
	}
	.profile{
		width: 20%;
	}
	.text{
		position: relative;
		top:10%;
		font-size: 90px;
		font-weight: bolder;		
		
	}
</style>
</head>

<body>
<%try {
	Class.forName("com.mysql.jdbc.Driver");
	con1=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");

	st1=con1.createStatement();
	
	u=request.getParameter("user");
	
	rs1=st1.executeQuery("SELECT `height`,`weight`,`sex`,`age` FROM `patientdetails` WHERE `username`='"+u+"' LIMIT 1");
	
	while(rs1.next()){
		h=rs1.getString(1);
		w=rs1.getString(2);
		s=rs1.getString(3);
		a=rs1.getString(4);
	}
}
catch(Exception e){
	out.println(e);
}
%>
 <img class="back" alt="back" src="images/lhc.jpg">

<div class="head"><span class="text">Welcome to <br>DynamiCare Health</span></div>

<div id="userdetails">
	<center>
		<% if (s.equals("Male")){ 
			out.println("<img src='images/profileMale.png' class='profile'/>");
		}
		else{
			out.println("<img src='images/profileFemale.png' class='profile'/>");
		}%>
		<h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;User Details</h2>
		<table style="font-family:verdana;" cellpadding="6">
			<tr>
				<td><b>User Name:</b></td>
				<td><%= u %></td>
			</tr>
						
			<tr>
				<td><b>Age: </b></td>
				<td><%= a %></td>
			</tr>
			
			<tr>
				<td><b>Sex: </b>
					<td><%= s %></td>
				</tr>
				
				<tr>
					<td><b>Height: </b>
						<td><%= h %></td>
					</tr>
					
					<tr>
						<td><b>Weight: </b>
							<td><%= w %></td>
						</tr>
					</table>
				</center>
			</div>
			
			<center>
				<div class="menu-block">
					<div class="grid-container1">
						<div>
							<a href="DetailsPat.jsp" style="color:red;">
								<img class="icons" src="images/details.png"><hr>
							View Details</a>						
						</div>
						
						<div>
							<a href="Emergency.jsp" style="color:red;">
								<img class="icons" src="images/contacts.png"><hr>
							Emergency Contacts</a>			
						</div>			
						
						<div>
							<a href="AppointmentPat.jsp" style="color:red;">
								<img class="icons" src="images/appointment.png"><hr>
							Book Appointment</a>			
						</div>			
						
						
						<div>
							<a href="Payments.jsp" style="color:red;">
								<img class="icons" src="images/wallet.png"><hr>
							Payments</a>			
						</div>			
					</div>
				</div>
			</center>
			
			<%
			session.setAttribute("user",u);
			%>
</body>
</html>