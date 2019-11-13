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
<title>Contacts</title>
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
	height: 350px;
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
	height: 350px;
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

img{
height:50px;
width:50px;
position:absolute;
right:17px;
top:24px;
}
</style>
</head>
<body>
	<%
		String username=(String)request.getParameter("u");
	%>
	<div class="title">
		<h2 style="font-family: Verdana">Emergency Contacts</h2>
		<hr>
	</div>
	<%	
		try {
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
		st=con.createStatement();
		rs=st.executeQuery("SELECT patientcontacts.ename1, patientcontacts.ename2, "
				+"patientcontacts.eph1, patientcontacts.eph2, "
				+"patientcontacts.erel1, patientcontacts.erel2, "
				+"users.fname,users.lname, "
				+"patientdetails.phone "
				+"FROM patientcontacts INNER JOIN users INNER JOIN patientdetails "
				+"ON patientcontacts.username = users.uname AND patientcontacts.username = patientdetails.username "
				+"WHERE patientcontacts.username='"+username+"'");
		
		while(rs.next())
		{
			out.println("<div class='left'>");
			out.println("<table cellpadding='6'>");
				out.println("<tr>");
					out.println("<td><b>Name: </b></td>");
					out.println("<td>"+rs.getString(7)+" "+rs.getString(8)+"</td>");
				out.println("</tr>");
			
			out.println("<tr>");
				out.println("<td><b>Phone No.: </b></td>");
				out.println("<td>"+rs.getString(9)+"</td>");
			out.println("</tr>");
			out.println("</table>");
			
			out.println("<hr>");
			out.println("<h2>Emergency Contact No. 1</h2>");
			out.println("<table cellpadding='6'>");
			out.println("<tr>");
				out.println("<td><b>Name: </b></td>");
				out.println("<td>"+rs.getString(1)+"</td>");
			out.println("</tr>");
			
			out.println("<tr>");
				out.println("<td><b>Phone No.: </b></td>");
				out.println("<td>"+rs.getString(3)+"</td>");
			out.println("</tr>");		

			out.println("<tr>");
				out.println("<td><b>Relation: </b></td>");
				out.println("<td>"+rs.getString(5)+"</td>");
			out.println("</tr>");	
			out.println("</table>");
			out.println("</div>");
			
			out.println("<div class='right'>");

			out.println("<h2>Emergency Contact No. 2</h2>");
			out.println("<table cellpadding='6'>");				
			out.println("<tr>");
				out.println("<td><b>Name: </b></td>");
				out.println("<td>"+rs.getString(2)+"</td>");
			out.println("</tr>");
			
			out.println("<tr>");
				out.println("<td><b>Phone No.: </b></td>");
				out.println("<td>"+rs.getString(4)+"</td>");
			out.println("</tr>");
			

			out.println("<tr>");
				out.println("<td><b>Relation: </b></td>");
				out.println("<td>"+rs.getString(6)+"</td>");
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