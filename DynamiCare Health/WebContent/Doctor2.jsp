<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%!Connection con;
Statement st;
String pname,sex,age,ph,edu,exp,spec,loc;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>

<body>
	<%
	try {
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");

	st=con.createStatement();

	pname=request.getParameter("user");
	sex=request.getParameter("sex");
	age=request.getParameter("age");
	ph=request.getParameter("ph");
	edu=request.getParameter("edu");
	spec=request.getParameter("spec");
	loc=request.getParameter("loc");
	exp=request.getParameter("exp");


	int row=st.executeUpdate("insert into doctordetails values('"+pname+"','"+sex+"','"+age+"','"+ph+"','"+edu+"','"+spec+"','"+loc+"','"
	+exp+"')");
			
	st.close();

	con.close();

}
catch (Exception e) {
e.printStackTrace(response.getWriter());
}

%>	


	<%@ include file="HomePageDoctor.jsp"%>
		</body>
		</html>