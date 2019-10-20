<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%!Connection con;
	Statement st;
	ResultSet rs;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book Appointment</title>
<style>
.grid-container {
	display: grid;
	grid-template-columns: 428px 428px 428px;
	grid-template-rows: auto;
	grid-gap: 10px;
	padding: 10px;
}

.grid-container>div {
	background-color: #FFFFFF;
	text-align: center;
	padding-top: 20px;
	font-size: 30px;
	border: 1px solid black;
	border-radius: 25px;
}

a {
	text-decoration: none;
}
</style>
</head>
<body>
	<h2 style="font-family: verdana">Doctors</h2>
	<div class="grid-container">
		<%
			session.setAttribute("username", session.getAttribute("uname").toString());
			String type = request.getParameter("type");
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");

				st = con.createStatement();

				rs = st.executeQuery(
						"SELECT users.fname,users.lname,doctordetails.sex,doctordetails.username FROM `users` INNER JOIN `doctordetails` "
								+ "ON users.uname = doctordetails.username WHERE doctordetails.specification='" + type
								+ "'");

				while (rs.next()) {
		%>
		<div>
			<a href=<%="\"ShowProfileDoctor.jsp?uname=" + rs.getString(4) + "\""%>>
				<div style="background-color: green; color: white; height: 50px">
					<span style="position: relative; top: 7px;">Dr. <%=rs.getString(1)%>
						<%=rs.getString(2)%></span>
				</div> <%
 	if (rs.getString(3).equals("Male")) {
 				out.println("<img src='images/doctorMale.png' class='profile'/>");
 			} else {
 				out.println("<img src='images/doctorFemale.png' class='profile'/>");
 			}
 %>
			</a>
		</div>
		<%
			}
			} catch (Exception e) {
				out.println(e);
			}
		%>
	</div>
</body>
</html>