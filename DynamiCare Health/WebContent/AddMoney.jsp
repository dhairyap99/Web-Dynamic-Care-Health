<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%!Connection con;
	Statement st;
	ResultSet rs;
	float money, balance;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
	<%
		money = Float.valueOf(request.getParameter("money"));
		String uname = session.getAttribute("user").toString();
		session.setAttribute("user", uname);
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");

			st = con.createStatement();

			rs = st.executeQuery("SELECT `money` FROM `wallet` WHERE `username`='" + uname + "'");

			while (rs.next()) {
				balance = Float.valueOf(rs.getString(1));
			}

			money += balance;

			int row = st.executeUpdate("UPDATE `wallet` SET `money`=" + money + " WHERE `username`='" + uname + "'");

		} catch (Exception e) {
			out.println(e);
		}

		String redirectURL = "/DynamiCare_Health/Payments.jsp";
		response.sendRedirect(redirectURL);
	%>
</body>
</html>