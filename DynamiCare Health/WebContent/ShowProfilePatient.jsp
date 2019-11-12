<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%!Connection con;
	Statement st;
	ResultSet rs;
	float weight, height, bmi;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Details</title>
<style>
h2 {
	position: absolute;
	left: 650px;
	top: 0px;
}

table {
	position: absolute;
	left: 650px;
	top: 85px;
}

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

form {
	position: absolute;
	top: 80%;
	color: black;
}

.button {
	color: white;
	background: #eb1736;
	border-radius: 30px;
	font-size: 20px;
	font-family: Verdana;;
	font-weight: bold;
	height: 100px;
	width: 260px;
	border: 2.5px solid #eb1736;
}

.button:hover {
	color: #eb1736;
	background: white;
}

.no-border {
	border: none;
}

img {
	height: 625px;
}
</style>
</head>
<body>
	<%
		String username = request.getParameter("uname");
		String b = request.getParameter("bid");
		DecimalFormat format = new DecimalFormat("#0.000");
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");
			st = con.createStatement();
			rs = st.executeQuery(
					"SELECT patientdetails.height, patientdetails.weight, patientdetails.sex,patientdetails.age, "
							+ "patientdetails.famhis,patientdetails.alhis,patientdetails.majil,users.fname,users.lname, patientdetails.bg, "
							+ "booking.date,booking.shift,booking.reason "
							+ "FROM patientdetails INNER JOIN users INNER JOIN booking "
							+ "ON patientdetails.username = users.uname AND users.uname=booking.pname "
							+ "WHERE booking.bookingid='" + b + "' AND patientdetails.username='" + username + "' "
							+ "LIMIT 1");

			while (rs.next()) {
				if (rs.getString(3).equals("Male")){
					out.println("<img src=\"images/bannermalepat.jpg\">");				
				}
				else{
					out.println("<img src=\"images/bannerfemalepat.jpg\">");	
				}
				out.println("<h2>" + rs.getString(8) + " " + rs.getString(9) + "</h2>");

				out.println("<table cellpadding='6'>");

				weight = Float.parseFloat(rs.getString(2));
				height = Float.parseFloat(rs.getString(1));

				out.println("<tr>");
				out.println("<td><b>Height: </b></td>");
				out.println("<td>" + height + "</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td><b>Weight: </b></td>");
				out.println("<td>" + weight + "</td>");
				out.println("</tr>");

				bmi = (weight) / (height * height);

				out.println("<tr>");
				out.println("<td><b>Body Mass Index: </b></td>");
				out.println("<td>" + format.format(bmi) + "</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td><b>Blood Group: </b></td>");
				out.println("<td>" + rs.getString(10) + "</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td><b>Age: </b></td>");
				out.println("<td>" + rs.getString(4) + "</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td><b>Family History: </b></td>");
				out.println("<td>" + rs.getString(5) + "</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td><b>Allergy History: </b></td>");
				out.println("<td>" + rs.getString(6) + "</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td><b>Major Illness: </b></td>");
				out.println("<td>" + rs.getString(7) + "</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td><b>Date: </b></td>");
				out.println("<td>" + rs.getString(11) + "</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td><b>Preferred Shift: </b></td>");
				String shift = rs.getString(12);
				out.println("<td>" + shift + "</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td><b>Reason: </b></td>");
				out.println("<td>" + rs.getString(13) + "</td>");
				out.println("</tr>");
				out.println("</table>");
	%>
	<button class="button" type="button" value="CONFIRM"
		style="position: absolute; top: 100px; left: 1050px;" id="confirm"
		data-toggle="modal" data-target="#myModal">CONFIRM</button>
	<button class="button" type="button" value="CANCEL"
		style="position: absolute; top: 420px; left: 1050px;"
		data-toggle="modal" data-target="#myModal1" id="cancel">CANCEL</button>


	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="background: #eb1736; color: white;">
					<h4 class="modal-title">Select Time:</h4>
				</div>
				<div class="modal-body no-border">
					<form action="ScheduleAppointment.jsp" action="get">
						<%
							switch (shift) {
									case "Morning":
										out.println("<input type='time' name='appt' min='09:00' max='12:00' required>");
										break;
									case "Afternoon":
										out.println("<input type='time' name='appt' min='12:00' max='16:00' required>");
										break;
									case "Evening":
										out.println("<input type='time' name='appt' min='16:00' max='19:00' required>");
										break;
									case "Night":
										out.println("<input type='time' name='appt' min='19:00' max='23:00' required>");
										break;
									}
						%>
						<input type="hidden" name="b" value=<%=b%>> <input
							type="submit" value="SUBMIT">
					</form>

				</div>
				<div class="modal-footer no-border">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						style="background: #eb1736; color: white;">Close</button>
				</div>
			</div>

		</div>
	</div>
	
	<div class="modal fade" id="myModal1" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="background: #eb1736; color: white;">
					<h4 class="modal-title">Cancel Appointment</h4>
				</div>
				<div class="modal-body no-border">
					<form action="CancelAppointment.jsp" action="get">
						<input type="hidden" name="b" value=<%=b%>> 
						Are You Sure?    
						<input type="submit" value="YES">
					</form>

				</div>
				<div class="modal-footer no-border">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						style="background: #eb1736; color: white;">Close</button>
				</div>
			</div>

		</div>
	</div>
	
	<%
		}
		} catch (Exception e) {
			out.println(e);
		}
	%>

</body>
</html>