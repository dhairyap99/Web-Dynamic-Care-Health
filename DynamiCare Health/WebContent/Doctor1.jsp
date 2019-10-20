<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
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
	Statement st;
	String first, last, user, password, cpassword, email;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
	<% 
try{
	Class.forName("com.mysql.jdbc.Driver");

	con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
	
	st=con.createStatement();
	
	first=request.getParameter("fname");
	last=request.getParameter("lname");
	email=request.getParameter("mail");
	user=request.getParameter("uname");
	password=request.getParameter("pwd");
	cpassword=request.getParameter("cpwd");
	
	byte[] unencodedPassword = password.getBytes();
	MessageDigest md = null;
	try {
	md = MessageDigest.getInstance("MD5");
	} catch (Exception e) {
		System.out.println(e);
	}
	md.reset();
	md.update(unencodedPassword);
	
	byte[] encodedPassword = md.digest();
	StringBuffer buf = new StringBuffer();
	for (int i = 0; i < encodedPassword.length; i++) {
	if (((int) encodedPassword[i] & 0xff) < 0x10) {
	buf.append("0");
	}
	buf.append(Long.toString((int) encodedPassword[i] & 0xff, 16));
	}
	String pass=buf.toString();
	
	byte[] unencodedPassword1 = cpassword.getBytes();
	MessageDigest md1 = null;
	try {
	md1 = MessageDigest.getInstance("MD5");
	} catch (Exception e) {}
	md1.reset();
	md1.update(unencodedPassword1);
	byte[] encodedPassword1 = md1.digest();
	StringBuffer buf1 = new StringBuffer();
	for (int i = 0; i < encodedPassword1.length; i++) {
	if (((int) encodedPassword1[i] & 0xff) < 0x10) {
	buf1.append("0");
	}
	buf1.append(Long.toString((int) encodedPassword1[i] & 0xff, 16));
	}
	String cpass=buf1.toString();	
	if (pass.equals(cpass)){
		out.println("<script>");
		out.println("var otp = prompt(\"Enter OTP\", \"\");")
		out.println("</script>");
		
		int code=0;
	    for (int i=0;i<4;i++){
	    int random = (int )(Math.random() * 9);
	    code=(code*10)+random;
	    }
	    
	    String subject="Welcome to DynamiCare Health Community";
	    String msg="Your OTP is "+code;
	    Mailer.send(email, subject, msg); 
		  
	    
	    if (random==otp){
		int row=st.executeUpdate("insert into users values('"+first+"','"+last+"','"+email+"','"+user+"','"+pass+"','Doctor')");%>
	<%@ include file="CompleteProfileDoctor.jsp"%>
	<%}
	    else{
	    	String redirectURL = "/DynamiCare_Health/SignUpDoctor.jsp";
			session.setAttribute("msg","Wrong OTP");
		    response.sendRedirect(redirectURL);
	    }
	    }
	else{
		String redirectURL = "/DynamiCare_Health/SignUpDoctor.jsp";
		session.setAttribute("msg","Passwords don't match");
	    response.sendRedirect(redirectURL);
	}
	st.close();
	con.close();	
}
catch(java.sql.SQLIntegrityConstraintViolationException exp){

	String redirectURL = "/DynamiCare_Health/SignUpDoctor.jsp";
	session.setAttribute("msg","User name already exists");
    response.sendRedirect(redirectURL);
}
catch(Exception e){
	e.printStackTrace(response.getWriter());
}
%>