<%@page import="java.security.MessageDigest"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%!Connection con;
	Statement st;
	ResultSet rs;%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Forgot Password</title>
</head>
<body>
	<%
		String uname = request.getParameter("user");
		String password = request.getParameter("pwd");
		String cpassword = request.getParameter("cpwd");
		
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
		String pass = buf.toString();

		byte[] unencodedPassword1 = cpassword.getBytes();
		MessageDigest md1 = null;
		try {
			md1 = MessageDigest.getInstance("MD5");
		} catch (Exception e) {
		}
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
		String cpass = buf1.toString();
		
		if (pass.equals(cpass)) {
			try {
				Class.forName("com.mysql.jdbc.Driver");

				con = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");

				st = con.createStatement();
				int row = st.executeUpdate("UPDATE `users` SET `pass`='" + pass + "' WHERE `uname`='" + uname + "'");

				out.println(pass.equals(cpass)+"\n");
				rs=st.executeQuery("SELECT `type` FROM `users` WHERE `uname`='"+uname+"'");
				
				while (rs.next()){
					if (rs.getString(1).equals("Patient")){
						session.setAttribute("msg","Password Updated Succesfully");
						session.setAttribute("user",uname);
						String redirectURL = "/DynamiCare_Health/HomePagePatient.jsp";
						response.sendRedirect(redirectURL);
					}
					else{
						session.setAttribute("msg","Password Updated Succesfully");
						session.setAttribute("user",uname);
						String redirectURL = "/DynamiCare_Health/HomePageDoctor.jsp";
						response.sendRedirect(redirectURL);
					}
				}

			} catch (Exception e) {
				out.println(e);
			}
		} else {
			String redirectURL = "/DynamiCare_Health/ForgotPassword4.jsp";
			session.setAttribute("msg", "Passwords don't match");
			session.setAttribute("uname", uname);
			response.sendRedirect(redirectURL);

		}
	%>
</body>
</html>