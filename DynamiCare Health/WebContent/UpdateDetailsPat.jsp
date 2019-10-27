<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%!
Connection con;
Statement st;
ResultSet rs;
%>
<html>
<head>
<title>Other Details</title>
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
	height: 55%;
	padding-left: 1%;
	border-right: 2.5px dashed white;
	border-bottom-left-radius: 30px;
	border-bottom-right-radius: 30px;
}

.centered {
	position: absolute;
	top: 78%;
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
.right{
	color: #eb1736;
		background: white;
		position: absolute;
		left: 50.8%;
		width: 47.4%;
		height: 55%;
		padding-left: 1%;
		border-left: 2.5px dashed #eb1736;
		border-bottom-right-radius:30px;
	}

</style>
</head>
<body>
	<% String username=request.getParameter("user"); 
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
		st=con.createStatement();
		rs=st.executeQuery("SELECT * FROM `patientdetails` WHERE `username`='"+username+"' LIMIT 1");
		while (rs.next()){%>
	<div class="title">
		<h2 style="font-family: Verdana">Update Details</h2>
		<hr>
	</div>
	<div class="form">
		<form action="UpdateDetailsPat1.jsp" method="get" autocomplete="on">
			<div class="left">
				<table cellpadding="6">
				
				<h2 style="color:#eb1736">Details</h2>
					<tr>
						<td>User Name:</td>
						<td><input type="text" name="user" size="40" value="<%= username%>"  readonly="readonly" 
						style="color:#eb1736"></td>
					</tr> 

					<tr>
						<td>Height:</td>
						<td><input type="text" name="ht" placeholder="in ft" size="40"  value="<%= rs.getString(2)%>"></td>
					</tr>
					<tr>
						<td>Weight:</td>
						<td><input type="text" name="wt" placeholder="in kg" size="40" value="<%= rs.getString(3)%>"></td>
					</tr>

					<tr>
						<td>Blood Group:</td>
						<td>
							<select name="bg">
								<option>A +ve</option>
								<option>B +ve</option>
								<option>AB +ve</option>
								<option>O +ve</option>
								<option>A -ve</option>
								<option>B -ve</option>
								<option>AB -ve</option>
								<option>O -ve</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>Sex:</td>
						<td>
							<select name="sex">
								<option>Male</option>
								<option>Female</option>
							</select>
						</td>
					</tr>

					<tr>
						<td>Age:</td>
						<td><input type="text" name="age" placeholder="in yrs" size="40" value="<%= rs.getString(5)%>"></td>
					</tr>
				</table>
				</div>
				
				<div class="right">
				<table cellpadding="6">
					<h2 style="color:#eb1736">History</h2>
					<tr>
						<td>Family History:</td>         
						<td><input type="text" name="fhist" size="40" value="<%= rs.getString(7)%>"></td>
					</tr>

					<tr>
						<td>Allergy History:</td>         
						<td><input type="text" name="alhist" size="40" value="<%= rs.getString(8)%>"></td>
					</tr>

					<tr>
						<td>Major Illness:</td>         
						<td><input type="text" name="mil" size="40" value="<%= rs.getString(9)%>"></td>
					</tr>
				</table>
			</div>
<%
		}}
		catch(Exception e){
			out.println(e);
		}
%>
			<div class="centered">
				<input type="submit" value="SUBMIT" class="submit">
			</div>
		</form>
	</div>
</body>
</html>

