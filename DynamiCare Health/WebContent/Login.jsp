<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.security.MessageDigest" %>
<%!Connection con;
Statement st;
ResultSet rs;
%>

<%
	try {
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");

	st=con.createStatement();
	
	String user=request.getParameter("user");
	String password=request.getParameter("password");
	
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
	
	rs=st.executeQuery("SELECT `pass`,`type` FROM `users` WHERE `uname`='"+user+"' LIMIT 1");
	
	while(rs.next()){
	if (rs.getString(1).equals(pass)){
		if (rs.getString(2).equals("Doctor")){%>
			<%@ include file="HomePageDoctor.jsp" %> 	
		<%}
		else {%>
			<%@ include file="HomePagePatient.jsp" %>
		<%}
		}
	else{%>
		<%= "Passwords don't Match" %>
	<%}
	}}
catch(Exception e){
out.println(e);
}%>