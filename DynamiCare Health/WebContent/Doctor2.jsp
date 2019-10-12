<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%!Connection con;
Statement st;
String pname,sex,age,ph,edu,exp,spec,loc;
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
		grid-template-columns: 400px 400px;
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
		left:19%;
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
	<%
	try {
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");

	st=con.createStatement();

	pname=request.getParameter("user");
	sex=request.getParameter("sex");
	age=request.getParameter("age");
	ph=request.getParameter("ph");
	edu=request.getParameter("edu");
	spec=request.getParameter("spec");
	loc=request.getParameter("loc");
	exp=request.getParameter("exp");


	int row=st.executeUpdate("insert into doctordetails values('"+pname+"','"+sex+"','"+age+"','"+ph+"','"+edu+"','"+spec+"','"+loc+"','"
	+exp+"')");
			
	st.close();

	con.close();

}
catch (Exception e) {
e.printStackTrace(response.getWriter());
}

%>	

 <img class="back" alt="back" src="images/lhc.jpg">

<div class="head"><span class="text">Welcome to <br>DynamiCare Health</span></div>

<div id="userdetails">
	<center>
		<img src="images/profile.png" class="profile"/>
		<h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;User Details</h2>
		<table style="font-family:verdana;" cellpadding="6">
			<tr>
				<td><b>User Name:</b></td>
				<td><%= pname %></td>
			</tr>
						
			<tr>
				<td><b>Age: </b></td>
				<td><%= age %></td>
			</tr>
			
			<tr>
				<td><b>Sex: </b>
					<td><%= sex %></td>
				</tr>
				
				<tr>
					<td><b>Phone: </b>
						<td><%= ph %></td>
					</tr>
					
					<tr>
						<td><b>Specification: </b>
							<td><%= spec %></td>
						</tr>
					</table>
				</center>
			</div>
			
			<center>
				<div class="menu-block">
					<div class="grid-container1">
						<div>
							<a href="Details.jsp" style="color:red;">
								<img class="icons" src="images/details.png"><hr>
							Complete Details</a>						
						</div>
						
						<div>
							<a href="Emergency.jsp" style="color:red;">
								<img class="icons" src="images/contacts.png"><hr>
							Emergency Contacts</a>			
						</div>			
					</div>
				</div>
			</center>
		</body>
		</html>