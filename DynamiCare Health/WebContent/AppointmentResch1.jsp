<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%@page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<%!Connection con;
	Statement st,st1;
	ResultSet rs,rs1;
	String date,max,docname,sh;
	String[] shifts;
%>
<head>
<meta charset="ISO-8859-1"><link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<script type="text/javascript">
    $(window).on('load',function(){
        $('#myModal').modal('show');
    });
</script>
<title>Reschedule Appointment</title>
</head>
<body>
<%
String uname=session.getAttribute("user").toString();
session.setAttribute("user", uname);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
try {
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");
	st = con.createStatement();
	rs=st.executeQuery("SELECT `dname`,`date` FROM `booking` WHERE `bookingid`='"+request.getParameter("bid")+"'");
	while(rs.next()){
		docname=rs.getString(1);
		date=rs.getString(2);
	}
	
	st1=con.createStatement();
	rs1=st1.executeQuery("SELECT `shifts` FROM `doctordetails` WHERE `username`='"+docname+"'");
	while (rs1.next()){
		sh=rs1.getString(1);
	}
	shifts=sh.split(",");
}
catch (Exception e){
	out.println(e);
}
Calendar c = Calendar.getInstance();
c.setTime(sdf.parse(date));
c.add(Calendar.DATE, 7);
max=sdf.format(c.getTime());

%>
<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog"  style="width:1250px;">
			<div class="modal-content">
				<div class="modal-header" style="background: #eb1736; color: white;">
					<h4 class="modal-title">Reschedule Appointment: </h4>
				</div>
				<div class="modal-body no-border">
					<form action="AppointmentResch2.jsp" action="get">
					<table cellpadding="6">
					<tr>
						<td> Enter Date:</td>
						<td><input type="date" name="d" min=<%= date %> max=<%= max %>></td>
					</tr>
					<tr>
					<td>Time Slots:</td>
					<td>Morning (9:00 AM to 12:00 PM)</td><td></td><td></td>
					<td>Afternoon (12:00 PM to 4:00 PM)</td>
					</tr>
					<tr>
					<td></td>
					<td>Evening (4:00 PM to 7:00 PM)</td><td></td><td></td>
					<td>Night (7:00 PM to 11:00 PM)</td>
					</tr>
					<tr>
						<td>Preferred Time:</td>
						<% for (String x:shifts){%>							
						<td><input type="radio" name="t" value=<%= x %>><%= x %></td>							
							<%}%>
					</tr>
					
					</table>
						<input type="hidden" name="b" value=<%=request.getParameter("bid")%>>  
						 
						<input type="submit" value="Submit">
					</form>

				</div>
				<div class="modal-footer no-border">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						style="background: #eb1736; color: white;" onclick="window.location.href='AppointmentResch.jsp'">Close</button>
				</div>
			</div>

		</div>
	</div>
</body>
</html>