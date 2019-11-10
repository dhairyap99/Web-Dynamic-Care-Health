<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%!
Connection con;
Statement st;
ResultSet rs;
String pname,sex,age,ph,edu,exp,spec,loc,ch;
String sh[];
String shifts;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<%
pname=request.getParameter("user");
sex=request.getParameter("sex");
age=request.getParameter("age");
ph=request.getParameter("ph");
edu=request.getParameter("edu");
spec=request.getParameter("spec");
loc=request.getParameter("loc");
exp=request.getParameter("exp");
ch=request.getParameter("cha");

sh = request.getParameterValues("shift");
if (sh != null && sh.length != 0) {
	shifts=Arrays.asList(sh).toString().substring(1).replace("]", "");
}

try{
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");

	st=con.createStatement();
	
	int row=st.executeUpdate("UPDATE `doctordetails` SET `sex`='"+sex+"', `age`='"+age+"', `phone`='"+ph+"', `education`='"+edu
			+"', `specification`='"+spec+"', `location`='"+loc+"',`experience`='"+exp+"',`charges`='"+ch+"',`shifts`='"+shifts
			+"' WHERE `username`='"+pname+"'");
	
	String redirectURL = "/DynamiCare_Health/HomePageDoctor.jsp?user="+pname;
	session.setAttribute("msg","Profile Updated Successfully");
    response.sendRedirect(redirectURL);
}
catch(Exception e){
	out.println(e);
}
%>
</body>
</html>