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
String pname,ht,wt,sex,age,fhis,alhis,mil,blg;
%>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<%
pname=request.getParameter("user");
ht=request.getParameter("ht");
wt=request.getParameter("wt");
blg=request.getParameter("bg");
sex=request.getParameter("sex");
age=request.getParameter("age");
fhis=request.getParameter("fhist");
alhis=request.getParameter("alhist");
mil=request.getParameter("mil");

try{
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");

	st=con.createStatement();
	
	int row=st.executeUpdate("UPDATE `patientdetails` SET `height`='"+ht+"',`weight`='"+wt+"',`sex`='"+sex+"',`age`='"+age
			+"',`famhis`='"+fhis+"',`alhis`='"+alhis+"',`majil`='"+mil+"',`bg`='"+blg+"' WHERE `username`='"+pname
			+"'");
	
	String redirectURL = "/DynamiCare_Health/HomePagePatient.jsp";
	session.setAttribute("user",pname);
	session.setAttribute("msg","Profile Updated Successfully");
    response.sendRedirect(redirectURL);
}
catch(Exception e){
	out.println(e);
}
%>
</body>
</html>