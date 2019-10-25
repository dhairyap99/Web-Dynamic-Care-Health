<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.DecimalFormat"%>
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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
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
	top: 20%;
	width: 680px;
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
	top: 125px;
	left: 50%;
	width: 670px;
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
	width: 98.5%;
	border-top-left-radius: 30px;
	border-top-right-radius: 30px;
	position: absolute;
	margin-top: 2px;
	margin-left: 8px;
	border-bottom: 2.5px solid white;
}

td b {
	text-decoration: underline;
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
	color: #eb1736;
	background: white;
	border-radius: 30px;
	font-size: 20px;
	font-family: Verdana;;
	font-weight: bold;
	height: 100px;
	width: 260px;
	border: 2.5px solid #eb1736;
}

.no-border{
  border:none;
}
</style>
</head>
<body>
	<div class="title">
		<h2 style="font-family: Verdana">Complete Details</h2>
		<hr>
	</div>

	<%
		String username=request.getParameter("uname");
		String b=request.getParameter("bid");
		DecimalFormat format = new DecimalFormat("#0.000");
		try {
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
		st=con.createStatement();
		rs=st.executeQuery("SELECT patientdetails.height, patientdetails.weight, patientdetails.sex,patientdetails.age, "
				+"patientdetails.famhis,patientdetails.alhis,patientdetails.majil,users.fname,users.lname, patientdetails.bg, "
				+"booking.date,booking.shift,booking.reason "
				+"FROM patientdetails INNER JOIN users INNER JOIN booking "
				+"ON patientdetails.username = users.uname AND users.uname=booking.pname "
				+"WHERE booking.bookingid='"+b+"' AND patientdetails.username='"+username+"' "
				+"LIMIT 1");
		
		while(rs.next())
		{
			out.println("<div class='left'>");
			out.println("<table cellpadding='6'>");
				out.println("<tr>");
					out.println("<td><b>Name: </b></td>");
					out.println("<td>"+rs.getString(8)+" "+rs.getString(9)+"</td>");
				out.println("</tr>");
				
				weight = Float.parseFloat(rs.getString(2));	
				height = Float.parseFloat(rs.getString(1));	
				
				out.println("<tr>");
					out.println("<td><b>Height: </b></td>");
					out.println("<td>"+height+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
					out.println("<td><b>Weight: </b></td>");
					out.println("<td>"+weight+"</td>");
				out.println("</tr>");
				
				bmi = (weight)/(height*height);
				
				out.println("<tr>");
					out.println("<td><b>Body Mass Index: </b></td>");
					out.println("<td>"+format.format(bmi)+"</td>");
				out.println("</tr>");
				

				out.println("<tr>");
					out.println("<td><b>Blood Group: </b></td>");
					out.println("<td>"+rs.getString(10)+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
				out.println("<td><b>Sex: </b></td>");
				out.println("<td>"+rs.getString(3)+"</td>");
				out.println("</tr>");
			
				out.println("<tr>");
				out.println("<td><b>Age: </b></td>");
				out.println("<td>"+rs.getString(4)+"</td>");
				out.println("</tr>");
				out.println("</table>");
				out.println("</div>");
				
				out.println("<div class='right'>");
				out.println("<table cellpadding='6'>");
					out.println("<tr>");
					out.println("<td><b>Family History: </b></td>");
					out.println("<td>"+rs.getString(5)+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
					out.println("<td><b>Allergy History: </b></td>");
					out.println("<td>"+rs.getString(6)+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
					out.println("<td><b>Major Illness: </b></td>");
					out.println("<td>"+rs.getString(7)+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
				out.println("<td><b>Date: </b></td>");
				out.println("<td>"+rs.getString(11)+"</td>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<td><b>Preferred Shift: </b></td>");
			String shift=rs.getString(12);
			out.println("<td>"+shift+"</td>");
		out.println("</tr>");
		
		out.println("<tr>");
		out.println("<td><b>Reason: </b></td>");
		out.println("<td>"+rs.getString(13)+"</td>");
		out.println("</tr>");
			out.println("</table>");
			out.println("</div>");%>
	<button class="button" type="button" value="CONFIRM"
		style="position: absolute; top: 500px; left: 200px;" id="confirm"
		data-toggle="modal" data-target="#myModal">CONFIRM</button>
	<button class="button" type="button" value="CANCEL"
		style="position: absolute; top: 500px; left: 900px;"
		onclick="location.href='CancelAppointment.jsp?b=<%=b%>'" id="cancel">CANCEL</button>


	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="background: #eb1736;color: white;">
					<h4 class="modal-title">Select Time:</h4>
				</div>
				<div class="modal-body no-border">
					<form action="ScheduleAppointment.jsp" action="get">
						<%		
				switch(shift){
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
				}%>
						<input type="hidden" name="b" value=<%=b%>> 
						<input type="submit" value="SUBMIT" >
					</form>

				</div>
				<div class="modal-footer no-border">
					<button type="button" class="btn btn-default" data-dismiss="modal" style="background: #eb1736;color: white;">Close</button>
				</div>
			</div>

		</div>
	</div>
	<%}
	}
	catch(Exception e){
	out.println(e);
}
%>

</body>
</html>