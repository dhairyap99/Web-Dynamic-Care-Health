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
<style type="text/css">
.grid-container {
	display: grid;
	grid-template-columns: 428px 428px 428px;
	grid-template-rows: auto;
	grid-gap: 10px;
	padding: 10px;
}

.grid-container>div {
	background-color: #3A23B0;
	text-align: center;
	padding-top: 20px;
	font-size: 30px;
	border: 1px solid #3A23B0;
	border-radius: 25px;
	height: 90px;
	color: white;
}
a {
	color: white;
	text-decoration: none;
	position: relative;
	top: 20%;
}
</style>
</head>
<body>
<h2 style="font-family: verdana">Select Doctor Type</h2>
	<div class="grid-container">
		<%
			session.setAttribute("uname", session.getAttribute("user").toString());
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");

				st = con.createStatement();

				rs = st.executeQuery("SELECT DISTINCT specification FROM `doctordetails` ORDER by specification");
				while (rs.next()) {
		%>
		<div>
			<a href=<%="\"SelectDoctor.jsp?type=" + rs.getString(1) + "\""%>> <%=rs.getString(1)%>
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