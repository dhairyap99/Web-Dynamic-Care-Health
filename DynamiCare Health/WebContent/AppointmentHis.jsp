<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%!Connection con;
	Statement st;
	ResultSet rs;
	String uname;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Appointment History</title>
</head>
<style>
body {
	background: #5252d4;
}

.title {
	background: #eb1736;
	color: white;
	padding: 14px;
	text-align: center;
	border-top-left-radius: 30px;
	border-top-right-radius: 30px;
}

td {
	text-align: center;
	font-size: 18px;
	font-family: Verdana;
}

.bold {
	font-weight: bolder;
}

table {
	border-collapse: collapse;
	color: #eb1736;
	background: white;
	position: absolute;
	left: 0.6%;
	width: 98.9%;
	padding-left: 1%;
	border-right: 2.5px dashed white;
	border-bottom-left-radius: 30px;
	border-bottom-right-radius: 30px;
}
</style>
<body>
	<div class="title">
		<h2 style="font-family: Verdana">Appointment History</h2>
		<hr>
	</div>
	<table cellpadding="6">
		<tr class="bold" style="border-bottom: 1px solid black">
			<td>Booking Id</td>
			<td>Doctor Name</td>
			<td>Date</td>
			<td>Time</td>
			<td>Location</td>
			<td>Reason</td>
		</tr>
		<%
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();
			Date d = new Date();
			c.setTime(d);
			String today = sdf.format(d);

			uname = session.getAttribute("user").toString();
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");
			st = con.createStatement();
			rs = st.executeQuery(
					"SELECT booking.bookingid,users.fname,users.lname,booking.date,booking.time,booking.status,booking.reason, "
							+ "doctordetails.location "
							+ "FROM `booking` INNER JOIN `users` INNER JOIN `doctordetails` "
							+ "ON booking.dname=users.uname and booking.dname=doctordetails.username "
							+ "WHERE booking.pname='" + uname
							+ "' and booking.date>DATE_SUB(NOW(),INTERVAL 1 DAY) and booking.status=1 "
							+ "ORDER BY booking.date");
			while (rs.next()) {
				out.println("<tr>");
				out.println("<td>" + rs.getString(1) + "</td>");
				out.println("<td>Dr." + rs.getString(2) + " " + rs.getString(3) + "</td>");

				String dateInString = rs.getString(4);
				SimpleDateFormat formatter = new SimpleDateFormat("EEEE, MMM dd, yyyy");
				Date date = sdf.parse(dateInString);
				out.println("<td>" + formatter.format(date) + "</td>");

				String timeInString = rs.getString(5);
				SimpleDateFormat sd = new SimpleDateFormat("HH:mm:ss");
				SimpleDateFormat formatter1 = new SimpleDateFormat("KK:mm a");
				Date current = sd.parse(timeInString);
				out.println("<td>" + formatter1.format(current) + "</td>");

				out.println("<td>" + rs.getString(8) + "</td>");

				out.println("<td>" + rs.getString(7) + "</td>");
				out.println("</tr>");
			}
		%>
	</table>
</body>
</html>