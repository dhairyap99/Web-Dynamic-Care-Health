<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%!Connection con;
Statement st;
ResultSet rs;%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reports</title>
<style type="text/css">
.grid-container {
	display: grid;
	grid-template-columns: 255px 255px 255px 255px 255px;
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
	position: relative;
	top: 20%;
}
</style>
</head>
<body>
<h2 style="font-family: verdana">Reports</h2>
	<div class="grid-container">
		<%
			String uname=session.getAttribute("user").toString();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatter = new SimpleDateFormat("MMM dd, yyyy");
		
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");

				st = con.createStatement();

				rs = st.executeQuery("SELECT `bookingid`,`date` FROM `booking` WHERE `pname`='"+uname+"' and `diagnosed`=true order by `date`");
				while (rs.next()) {
		%>
		<div>
			<a href=<%="\"ViewPdf.jsp?bid=" + rs.getString(1) + "\""%>><img src="images/pdf.png"></a>
			<h2></h2>
			<p style="font-style: oblique; font-size: 0.7em"><%= formatter.format(sdf.parse(rs.getString(2))) %></p>
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