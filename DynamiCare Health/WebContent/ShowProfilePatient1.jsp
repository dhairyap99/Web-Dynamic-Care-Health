<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
 <%@page import="java.text.DecimalFormat" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%!
Connection con;
Statement st;
ResultSet rs;
float weight,height,bmi;
String bid;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Details</title>
<style>
h2 {
	position: absolute;
	left: 650px;
	top: 0px;
}

table {
	position: absolute;
	left: 650px;
	top: 85px;
}

body {
	font-size: 20px;
	font-family: Verdana;
}

td b {
	color: #5252d4;
}

td {
	padding: 10px;
}

form {
	position: absolute;
	top: 80%;
	color: black;
}

.button {
	color: white;
	background: #eb1736;
	border-radius: 30px;
	font-size: 20px;
	font-family: Verdana;;
	font-weight: bold;
	height: 100px;
	width: 260px;
	border: 2.5px solid #eb1736;
}

.button:hover {
	color: #eb1736;
	background: white;
}

.no-border {
	border: none;
}

img {
	height: 625px;
}
</style>
</head>
<body>

	<%
		String username=request.getParameter("uname");
		DecimalFormat format = new DecimalFormat("#0.000");
		try {
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC","root","");
		st=con.createStatement();
		rs=st.executeQuery("SELECT patientdetails.height, patientdetails.weight, patientdetails.sex, patientdetails.age, "
		+"patientdetails.famhis,patientdetails.alhis,patientdetails.majil,users.fname,users.lname, patientdetails.bg "
		+"FROM patientdetails INNER JOIN users "
		+"ON patientdetails.username = users.uname "
		+"WHERE patientdetails.username='"+username+"' limit 1");
		
		while(rs.next())
		{if (rs.getString(3).equals("Male")){
			out.println("<img src=\"images/bannermalepat.jpg\">");				
		}
		else{
			out.println("<img src=\"images/bannerfemalepat.jpg\">");	
		}
		out.println("<h2>" + rs.getString(8) + " " + rs.getString(9) + "</h2>");

			out.println("<table cellpadding='6'>");
				
				weight = Float.parseFloat(rs.getString(2));	
				height = Float.parseFloat(rs.getString(1));	
				
				out.println("<tr>");
					out.println("<td><b>Height: </b></td>");
					out.println("<td>"+height+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
					out.println("<td><b>Weight: </b></td>");
					out.println("<td>"+weight+"</td>");
				out.println("</tr>");
				
				bmi = (weight)/(height*height);
				
				out.println("<tr>");
					out.println("<td><b>Body Mass Index: </b></td>");
					out.println("<td>"+format.format(bmi)+"</td>");
				out.println("</tr>");
				

				out.println("<tr>");
					out.println("<td><b>Blood Group: </b></td>");
					out.println("<td>"+rs.getString(10)+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
					out.println("<td><b>Age: </b></td>");
					out.println("<td>"+rs.getString(4)+"</td>");
				out.println("</tr>");
								
				out.println("<tr>");
					out.println("<td><b>Family History: </b></td>");
					out.println("<td>"+rs.getString(5)+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
					out.println("<td><b>Allergy History: </b></td>");
					out.println("<td>"+rs.getString(6)+"</td>");
				out.println("</tr>");
				
				out.println("<tr>");
					out.println("<td><b>Major Illness: </b></td>");
					out.println("<td>"+rs.getString(7)+"</td>");
				out.println("</tr>");
			out.println("</table>");
		}
	}
	catch(Exception e){
	out.println(e);
}
		session.setAttribute("docname",session.getAttribute("docname"));
		bid=request.getParameter("bid");
		
%>

<button class="button" type="button" value="VIEW" onclick="location.href='ViewDiagnosis.jsp?u=<%=username%>'"
		style="position: absolute; top: 470px; left: 500px;" 
		id="view">VIEW DIAGNOSIS</button>
<button class="button" type="button" value="VIEW" onclick="location.href='Diagnose.jsp?u=<%=username%>&bid=<%= bid %>'"
		style="position: absolute; top: 470px; left: 775px;" 
		id="view">DIAGNOSE</button>
<button class="button" type="button" value="VIEW" onclick="location.href='ViewContacts.jsp?u=<%=username%>'"
		style="position: absolute; top: 470px; left: 1050px;" 
		id="view">VIEW CONTACTS</button>
</body>
</html>