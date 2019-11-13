<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.io.mail.Mailer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%!Connection con;
	Statement st,st1;
	ResultSet rs;
	String df,dl,mail,subject,msg;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
	<%
		String uname = session.getAttribute("dname").toString();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");

			st = con.createStatement();

			int row = st.executeUpdate("UPDATE `doctordetails` SET `verified`=true WHERE `username`='"+uname+"'");
			
			st1=con.createStatement();
			
			rs=st.executeQuery("SELECT `fname`, `lname`, `mail` FROM `users` WHERE `uname`='"+uname+"'");
			
			while(rs.next()){
				df=rs.getString(1);
				dl=rs.getString(2);
				mail=rs.getString(3);
			}

		} catch (Exception e) {
			out.println(e);
		}

		subject="Account has been verified";
		msg="Dear "+df+" "+dl+",";
		msg+="\nCongratulations, your account has been verified.";
		Mailer.send(mail,subject,msg);

		session.setAttribute("msg",subject);
		String redirectURL = "/DynamiCare_Health/HomePageAdmin.jsp";
		response.sendRedirect(redirectURL);
	%>
</body>
</html>