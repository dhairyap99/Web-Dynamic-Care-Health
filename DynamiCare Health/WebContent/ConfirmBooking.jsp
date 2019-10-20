<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet" %>
<%@page import="javax.servlet.http.HttpServlet" %>
<%@page import="net.io.mail.Mailer" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%!Connection con;
	Statement st,st1;
	ResultSet rs;
	String p,t,r,date,f,l,u;
	StringBuffer bookingid;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<%
f=session.getAttribute("fname").toString();
l=session.getAttribute("lname").toString();
try{
	Class.forName("com.mysql.jdbc.Driver");

	con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
	
	st=con.createStatement();
	
	p=request.getParameter("patient");
	t=request.getParameter("time");
	r=request.getParameter("reas");
	date=request.getParameter("date");
	
	String characters="QWERTYUIOPASDFGHJKLZXCVBNM";
	bookingid=new StringBuffer("");
	
	for (int i=1;i<=3;i++){
		bookingid.append(characters.charAt((int)(Math.random()*26)));
	}
	
	for (int i=4;i<=9;i++){
		bookingid.append((int)(Math.random()*9));
	}
	
	st1=con.createStatement();
	rs=st1.executeQuery("SELECT uname FROM `users` WHERE `fname`='"+f+"' and `lname`='"+l+"' limit 1");
	
	while(rs.next())
	{
		u=rs.getString(1);
	}
	String b=bookingid.toString();
	int row=st.executeUpdate("INSERT INTO `booking`(`bookingid`, `pname`, `dname`, `date`, `shift`, `reason`) VALUES ('"
	+b+"','"+p+"','"+u+"','"+date+"','"+t+"','"+r+"')");
	out.println("Inserted Successfully");
}
catch(Exception e){
	out.println(e);
}
%>
</body>
</html>