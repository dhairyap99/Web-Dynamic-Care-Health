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
float weight,height,bmi;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Details</title>
<style>
body {
	background: #5252d4;
}

.left {
	color: #eb1736;
	background: white;
	position: absolute;
	left: 0.6%;
	width: 49%;
	height: 230px;
	padding-left: 1%;
	border-right: 2.5px dashed white;
	border-bottom-left-radius: 30px;
	font-size: 20px;
	font-family: Verdana;
}

.right {
	font-size: 20px;
	color: #eb1736;
	background: white;
	position: absolute;
	left: 50.8%;
	width: 47.4%;
	height: 230px;
	padding-left: 1%;
	border-left: 2.5px dashed #eb1736;
	border-bottom-right-radius: 30px;
	font-family: Verdana;
}

.title {
	background: #eb1736;
	color: white;
	padding: 14px;
	text-align: center;
	border-top-left-radius: 30px;
	border-top-right-radius: 30px;
}

td b {
	text-decoration: underline;
	color: #5252d4;
}

td {
	padding: 10px;
}
</style>
</head>
<body>
	<div class="title">
		<h2 style="font-family: Verdana">Complete Details</h2>
		<hr>
	</div>

	<%
		String username=(String)session.getAttribute("user");
		
		try {
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
		st=con.createStatement();
		rs=st.executeQuery("SELECT doctordetails.sex,doctordetails.age,doctordetails.phone, "
				+"doctordetails.education, doctordetails.specification, doctordetails.location, doctordetails.experience,"
				+"users.fname, users.lname,doctordetails.charges "
				+"FROM `doctordetails` "
				+"INNER JOIN `users` "
				+"ON doctordetails.username=users.uname "
				+"WHERE doctordetails.username='"+username+"'");
		
		while(rs.next())
		{
			out.println("<div class='left'>");
			out.println("<table cellpadding='6'>");
				out.println("<tr>");
					out.println("<td><b>Name: </b></td>");
					out.println("<td>Dr. "+rs.getString(8)+" "+rs.getString(9)+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
					out.println("<td><b>Sex: </b></td>");
					out.println("<td>"+rs.getString(1)+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
				out.println("<td><b>Age: </b></td>");
				out.println("<td>"+rs.getString(2)+"</td>");
			out.println("</tr>");
			
			out.println("<tr>");
				out.println("<td><b>Phone No.: </b></td>");
				out.println("<td>"+rs.getString(3)+"</td>");
			out.println("</tr>");			
				out.println("</table>");
				out.println("</div>");
				
				out.println("<div class='right'>");
				out.println("<table cellpadding='6'>");
				out.println("<tr>");
					out.println("<td><b>Education: </b></td>");
					out.println("<td>"+rs.getString(4)+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
					out.println("<td><b>Specification: </b></td>");
					out.println("<td>"+rs.getString(5)+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
					out.println("<td><b>Experience: </b></td>");
					out.println("<td>"+rs.getString(7)+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
					out.println("<td><b>Location: </b></td>");
					out.println("<td>"+rs.getString(6)+"</td>");
				out.println("</tr>");
				

				out.println("<tr>");
					out.println("<td><b>Charges: </b></td>");
					out.println("<td>Rs. "+rs.getString(10)+"</td>");
				out.println("</tr>");
				
			out.println("</table>");
			out.println("</div>");
		}
	}
	catch(Exception e){
	out.println(e);
}
%>

</body>
</html>