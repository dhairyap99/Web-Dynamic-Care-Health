<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.DecimalFormat" %>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%!Connection con;
	Statement st;
	ResultSet rs;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Wallet</title>
<style>

.left {
	color: #eb1736;
	background: white;
	position: absolute;
	left: 0.6%;
	width: 97.4%;
	height: 100px;
	padding-left: 1%;
	border: 2.5px solid #eb1736;
	font-size: 30px;
	font-family: Verdana;
	text-align:center;
}


.title {
	background: #eb1736;
	color: white;
	padding: 14px;
	text-align: center;
	border-top-left-radius: 30px;
	border-top-right-radius: 30px;
}

.position{
position:relative;
top: 25%;
}
</style>
</head>
<body>

	<div class="title">
		<h2 style="font-family: Verdana">Current Balance</h2><hr>
	</div>
	<div class="left">
	<%
		String uname = session.getAttribute("user").toString();
		session.setAttribute("user", uname);
		DecimalFormat format = new DecimalFormat("#0.00");
		try {
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");

		st=con.createStatement();
		
		rs=st.executeQuery("SELECT `money` FROM `wallet` WHERE `username`='"+uname+"'");
		
		while(rs.next()){
			out.println("<span class=\"position\"><b>Balance:</b> <i>Rs. "+format.format(Double.valueOf(rs.getString(1).toString()))+"</i></span>");
		}
	}
	catch(Exception e){
		out.println(e);
	}
	%>
	<form action="AddMoney.jsp" action="get">
		<input type="number" name="money" step="0.01" min="10">
		<input type="submit" value="Add Money">
	</form>
	
	</div>
</body>
</html>