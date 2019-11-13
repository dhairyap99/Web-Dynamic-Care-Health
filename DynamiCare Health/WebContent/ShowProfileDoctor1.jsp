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
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Doctor's Profile</title>
<style>
body {
font-size: 20px;
	font-family: Verdana;
}

td b {
	color: #5252d4;
}

td {
	padding: 10px;
}

a{
	color: white;
	background: #eb1736;
	position: absolute;
	top:480px;
	left:250px;
	border-radius: 30px;
	font-size: 20px;
	font-family: Verdana;
	position:absolute;
	font-weight:bold;
	height:100px;
	width:260px;
	border: 2.5px solid #eb1736;
	text-decoration: none;
}

a:hover{
	color: #eb1736;
	background: white;
}

table{
position:absolute;
left:200px;
top:85px;
}

h2{
position:absolute;
left:200px;}

img{
height:625px;
position:absolute;
right:200px;
top:0px;
}
</style>
</head>
<body>
	<%
		String doctorname=request.getParameter("uname");
	session.setAttribute("dname",doctorname);
  	try {
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
		st=con.createStatement();
		rs=st.executeQuery("SELECT doctordetails.sex,doctordetails.age,doctordetails.phone, "
				+"doctordetails.education, doctordetails.specification, doctordetails.location, doctordetails.experience,"
				+"users.fname, users.lname,doctordetails.charges,doctordetails.shifts "
				+"FROM `doctordetails` "
				+"INNER JOIN `users` "
				+"ON doctordetails.username=users.uname "
				+"WHERE doctordetails.username='"+doctorname+"'");
		
		while(rs.next())
		{
			if (rs.getString(1).equals("Male")){
				out.println("<img src=\"images/bannermaledoc.jpg\">");				
			}
			else{
				out.println("<img src=\"images/bannerfemaledoc.jpg\">");	
			}
			
			out.println("<h2>Dr. "+rs.getString(8)+" "+rs.getString(9)+"</h2>");
			out.println("<table cellpadding='6'>");
				out.println("<tr>");
				out.println("<td><b>Age: </b></td>");
				out.println("<td>"+rs.getString(2)+"</td>");
			out.println("</tr>");
			
			out.println("<tr>");
				out.println("<td><b>Phone No.: </b></td>");
				out.println("<td>"+rs.getString(3)+"</td>");
			out.println("</tr>");				

			out.println("<tr>");
				out.println("<td><b>Experience: </b></td>");
				out.println("<td>"+rs.getString(7)+"</td>");
			out.println("</tr>");
				
				out.println("<tr>");
					out.println("<td><b>Education: </b></td>");
					out.println("<td>"+rs.getString(4)+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
					out.println("<td><b>Specification: </b></td>");
					out.println("<td>"+rs.getString(5)+"</td>");
				out.println("</tr>");
				
				
				out.println("<tr>");
					out.println("<td><b>Location: </b></td>");
					out.println("<td>"+rs.getString(6)+"</td>");
				out.println("</tr>");

				out.println("<tr>");
					out.println("<td><b>Charges: </b></td>");
					out.println("<td>Rs. "+rs.getString(10)+"</td>");
				out.println("</tr>");
				

				out.println("<tr>");
					out.println("<td><b>Shifts: </b></td>");
					out.println("<td>"+rs.getString(11)+"</td>");
				out.println("</tr>");
				
			out.println("</table>");
		}
	}
	catch(Exception e){
	out.println(e);
}
%>
<a href="VerifyDoctor.jsp"><span style="position:relative;top:40px;left:90px;">VERIFY</span></a>
</body>
</html>