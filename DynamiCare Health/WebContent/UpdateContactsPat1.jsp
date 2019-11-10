<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%!Connection con;
Statement st;
String pname,ename1,ename2,eph1,eph2,rel1,rel2,blg,ph;
%>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<%
pname=request.getParameter("user");
ph=request.getParameter("ph");
ename1=request.getParameter("ename1");
ename2=request.getParameter("ename2");
eph1=request.getParameter("eph1");
eph2=request.getParameter("eph2");
rel1=request.getParameter("rel1");
rel2=request.getParameter("rel2");

try{
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");

	st=con.createStatement();
	
	int row=st.executeUpdate("UPDATE `patientcontacts` SET `ename1`='"+ename1+"',`eph1`='"+eph1+"',`erel1`='"+rel1
			+"',`ename2`='"+ename2+"',`eph2`='"+eph2+"',`erel2`='"+rel2+"' WHERE `username`='"+pname+"'");
	
	int row1=st.executeUpdate("UPDATE `patientdetails` SET `phone`='"+ph+"' WHERE `username`='"+pname+"'");
	
	String redirectURL = "/DynamiCare_Health/HomePagePatient.jsp?user="+pname;
	session.setAttribute("msg","Contacts Updated Successfully");
    response.sendRedirect(redirectURL);
}
catch(Exception e){
	out.println(e);
}
%>
</body>
</html>