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
<title>DynamiCare Health</title>
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

.body{
position:relative;
top: 45px;
}

.topnav {
	overflow: hidden;
	background-color: #333;
	position:absolute;
	top:0px;
	left:0px;
	width:100%;
}

.topnav a {
	float: left;
	color: #f2f2f2;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
	font-size: 17px;
}

.topnav a:hover {
	background-color: #ddd;
	color: black;
}

.topnav a.active {
	background-color: #4CAF50;
	color: white;
}
</style>
</head>
<body>
<center>
		<div class="topnav">			
				<a href="" class="active"> DC-Health</a>
				<a href="Logout.jsp" style="float:right;">Logout</a>
		</div>
	</center>

<%
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
if (session.getAttribute("user")==null){
response.sendRedirect("Login1.jsp");	
}
if (session.getAttribute("msg")!=null){
	String message=session.getAttribute("msg").toString();
	out.println("<script>alert(\""+message+"\")</script>");
	session.removeAttribute("msg");
}
	%>
<div class="body">
	<h2 style="font-family: verdana">Verify Doctors</h2>
	<div class="grid-container">
		<%
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");

				st = con.createStatement();

				rs = st.executeQuery("SELECT `doctordetails`.`username`,`doctordetails`.`sex`,`users`.`fname`,`users`.`lname`,`doctordetails`.`specification` "
						+"FROM `doctordetails` INNER JOIN `users` "
						+"ON `doctordetails`.`username`=`users`.`uname` "
						+"WHERE `doctordetails`.verified=false "
						+"ORDER BY `users`.`fname`");
				while (rs.next()) {
		%>
		<div>
			<a href=<%="\"ShowProfileDoctor1.jsp?uname=" + rs.getString(1) +"\""%>>
				<div style="background-color: green; color: white">
					<%= rs.getString(3) %>
					<%= rs.getString(4) %>
				</div> <%
							if (rs.getString(2).equals("Male")){ 
			out.println("<img src='images/doctorMale.png' class='profile'/>");
		}
		else{
			out.println("<img src='images/doctorFemale.png' class='profile'/>");
		}%>	
			<p style="font-style: oblique; font-size: 0.7em;color:black;"><%= rs.getString(5) %></p>
			</a>
		</div>
		<%}
			} catch (Exception e) {
				out.println(e);
			}
		%>
	</div>
	</div>
</body>
</html>