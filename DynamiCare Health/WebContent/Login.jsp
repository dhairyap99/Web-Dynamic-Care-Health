<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.security.MessageDigest"%>
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
	
	rs=st.executeQuery("SELECT "
			+"IFNULL((Select `pass` FROM users WHERE `uname`='"+user+"'),'Null'),"
			+"IFNULL((Select `type` FROM users WHERE `uname`='"+user+"'),'Null') LIMIT 1");
	
	while(rs.next()){
		if (rs.getString(1).equals(pass)){
		if (rs.getString(2).equals("Doctor")){%>
<%@ include file="HomePageDoctor.jsp"%>
<%}
		else {%>
<%@ include file="HomePagePatient.jsp"%>
<%}
		}
		else if(rs.getString(1).equals("Null")){
			String redirectURL = "/DynamiCare_Health/Login1.jsp";
			session.setAttribute("msg","User Doesn't Exist");
		    response.sendRedirect(redirectURL);
		}
	else{
		String redirectURL = "/DynamiCare_Health/Login1.jsp";
		session.setAttribute("msg","Passwords don't match");
	    response.sendRedirect(redirectURL);
	}
	}}
catch(Exception e){
out.println(e);
}%>