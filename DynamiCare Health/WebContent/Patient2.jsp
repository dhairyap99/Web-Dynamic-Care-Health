<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%!Connection con;
Statement st;
String pname,ht,wt,sex,age,ph,fhis,alhis,mil,ename1,ename2,eph1,eph2,rel1,rel2,blg;
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
	ht=request.getParameter("ht");
	wt=request.getParameter("wt");
	blg=request.getParameter("bg");
	sex=request.getParameter("sex");
	age=request.getParameter("age");
	ph=request.getParameter("ph");
	fhis=request.getParameter("fhist");
	alhis=request.getParameter("alhist");
	mil=request.getParameter("mil");
	ename1=request.getParameter("ename1");
	ename2=request.getParameter("ename2");
	eph1=request.getParameter("eph1");
	eph2=request.getParameter("eph2");
	rel1=request.getParameter("rel1");
	rel2=request.getParameter("rel2");
	


	int row=st.executeUpdate("insert into patientdetails values('"+pname+"','"+ht+"','"+wt+"','"+sex+"','"+age+"','"+ph+"','"+fhis+"','"
	+alhis+"','"+mil+"','"+blg+"')");

	int row1=st.executeUpdate("insert into patientcontacts values('"+pname+"','"+ename1+"','"+eph1+"','"+rel1+"','"+ename2+"','"+eph2+"','"
			+rel2+"')");
			
	st.close();

	con.close();

}
catch (Exception e) {
e.printStackTrace(response.getWriter());
}

%>
	<%@ include file="HomePagePatient.jsp"%>
</body>
</html>