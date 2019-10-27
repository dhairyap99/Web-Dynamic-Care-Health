<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="net.io.mail.Mailer"%>
    
<!DOCTYPE html>
<%!Connection con;
	Statement st;
	ResultSet rs;
	String u,mail,subject,msg;
	StringBuffer otp;%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Forgot Password</title>
</head>
<body>
<%
u=request.getParameter("uname");
session.setAttribute("uname",u);
try {
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");
	st = con.createStatement();
	rs=st.executeQuery("SELECT `mail` FROM `users` WHERE `uname`='"+u+"'");
	while(rs.next()){
		mail=rs.getString(1);
	}
}
catch(Exception e){
	out.println(e);
}

otp=new StringBuffer("");

for (int i=1;i<=4;i++){
	otp.append(((int)(Math.random()*9))+1);
}

session.setAttribute("otp",otp);

subject="Reset Password";
msg="Your OTP is "+otp;
Mailer.send(mail,subject,msg);

response.sendRedirect("ForgotPassword2.jsp");
%>

</body>
</html>