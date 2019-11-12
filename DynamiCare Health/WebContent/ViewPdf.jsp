<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Report</title>
</head>
<body>
<%
String bid=request.getParameter("bid");
InputStream in=null;
Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs=null;
ServletOutputStream sos;

response.setContentType("application/pdf");

response.setHeader("Content-disposition","inline; filename=test.pdf" );

sos=response.getOutputStream();
try{
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");
	
	pstmt=con.prepareStatement("SELECT `reportpdf` FROM `report` WHERE `bookingid`='"+bid+"'");
	
	rs=pstmt.executeQuery();
	
	while (rs.next()){
		in=rs.getBinaryStream(1);
	}
	
	int available1 = in.available();
	byte[] bt = new byte[available1];
	in.read(bt);
	
	sos.write(bt);
	sos.flush();
	sos.close();
}
catch(Exception e){
	out.println(e);
}
%>
</body>
</html>