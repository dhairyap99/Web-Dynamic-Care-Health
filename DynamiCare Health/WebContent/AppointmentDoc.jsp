<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
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
	background-color: #FFFFFF;
	text-align: center;
	padding-top: 20px;
	font-size: 30px;
	border: 1px solid black;
	border-radius: 25px;
}

a {
	color: white;
	text-decoration: none;
}
</style>
</head>
<body>
<%
if (session.getAttribute("msg")!=null){
	String message=session.getAttribute("msg").toString();
	out.println("<script>alert(\""+message+"\")</script>");
	session.removeAttribute("msg");
}
%>
	<h2 style="font-family: verdana">Confirm Appointment</h2>
	<div class="grid-container">
		<%
		rs=null;
			String docname = session.getAttribute("user").toString();
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");

				st = con.createStatement();

				rs = st.executeQuery("SELECT users.uname,users.fname,users.lname,patientdetails.sex,booking.date,booking.bookingid "
						+ "FROM `booking` JOIN `users` JOIN `patientdetails` "
						+ "ON booking.pname=users.uname and booking.pname=patientdetails.username "
						+ "WHERE booking.`dname`='"+docname+"' and booking.status=0 and booking.date>DATE_SUB(NOW(),INTERVAL 1 DAY) "
						+ "order by booking.date;");
				boolean empty=true;
				while (rs.next()) {
					empty=false;
		%>
		<div>
			<a href=<%="\"ShowProfilePatient.jsp?uname=" + rs.getString(1) + "&bid="+rs.getString(6)+"\""%>>
				<div style="background-color: green; color: white">
					<%= rs.getString(2) %>
					<%= rs.getString(3) %>
				</div> <%
							if (rs.getString(4).equals("Male")){ 
			out.println("<img src='images/profileMale.png' class='profile'/>");
		}
		else{
			out.println("<img src='images/profileFemale.png' class='profile'/>");
		}%>
			</a>
			<p style="font-style: oblique; font-size: 0.7em"><%= rs.getString(5) %></p>
		</div>
		<%}
				if (empty){
					String redirectURL = "/DynamiCare_Health/HomePageDoctor.jsp";
					session.setAttribute("user",docname);
					session.setAttribute("msg","No Pending Appointments");
				    response.sendRedirect(redirectURL);				    
				}
			} catch (Exception e) {
				out.println(e);
			}
		%>
	</div>
</body>
</html>