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
<title>Update Details</title>
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
	height: 60%;
	padding-left: 1%;
	border-right: 2.5px dashed white;
	border-bottom-left-radius: 30px;
	border-bottom-right-radius: 30px;
}

.centered {
	position: absolute;
	top: 82%;
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
	<% String username=request.getParameter("user"); 
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
		st=con.createStatement();
		rs=st.executeQuery("SELECT * FROM `doctordetails` WHERE `username`='"+username+"' LIMIT 1");
		while (rs.next()){%>
	<div class="title">
		<h2 style="font-family: Verdana">Update Profile</h2>
		<hr>
	</div>
	<div class="form">
		<form action="UpdateProfileDoc1.jsp" method="get" autocomplete="on">
			<div class="left">
				<table cellpadding="6">
					<tr>
						<td>User Name:</td>
						<td><input type="text" name="user" size="40"
							value="<%= username%>" readonly="readonly"
							style="color: #eb1736"></td>
					</tr>

					<tr>
						<td>Sex:</td>
						<td><select name="sex">
								<option selected>Male</option>
								<option>Female</option>
						</select></td>
					</tr>

					<tr>
						<td>Age:</td>
						<td><input type="text" name="age" placeholder="in yrs"
							size="40" value="<%= rs.getString(3) %>"></td>
					</tr>

					<tr>
						<td>Phone No.:</td>
						<td><input type="text" name="ph" size="40" minlength="10" maxlength="10" value="<%= rs.getString(4) %>"></td>
					</tr>

					<tr>
						<td>Education:</td>
						<td><input type="text" name="edu" size="40" value="<%= rs.getString(5) %>"></td>
					</tr>

					<tr>
						<td>Specialization:</td>
						<td><input type="text" name="spec" size="40" value="<%= rs.getString(6) %>"></td>
					</tr>

					<tr>
						<td>Location:</td>
						<td><input type="text" name="loc" size="40" value="<%= rs.getString(7) %>"></td>
					</tr>

					<tr>
						<td>Charges:</td>
						<td><input type="text" name="cha" size="40" value="<%= rs.getString(9) %>"></td>
					</tr>


					<tr>
						<td>Preferred Shifts:</td>
						<td><input type="checkbox" name="shift" value="Morning">
							Morning (9:00 AM to 12:00 PM)</td>
						<td><input type="checkbox" name="shift" value="Afternoon">
							Afternoon (12:00 PM to 4:00 PM)</td>
						<td><input type="checkbox" name="shift" value="Evening">
							Evening (4:00 PM to 7:00 PM)</td>							
						<td><input type="checkbox" name="shift" value="Night">
							Night (7:00 PM to 11:00 PM)</td>
					</tr>

					<tr>
						<td>Experience:</td>
						<td><input type="text" name="exp" size="40" placeholder="In years" value="<%= rs.getString(8) %>"></td>
					</tr>

				</table>
<%
		}}
		catch(Exception e){
			out.println(e);
		}
%>
			</div>
			<div class="centered">
				<input type="submit" value="SUBMIT" class="submit">
			</div>
		</form>
	</div>
</body>
</html>

