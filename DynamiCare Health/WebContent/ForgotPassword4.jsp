<html>
<head>
<title>Forgot Password</title>
<style type="text/css">
body {
	background: #5252d4;
}

.form {
	background: #ffffff;
	color: white;
	font-family: Calibri;
	font-size: 18px;
	padding: 8px;
}

.title {
	background: #eb1736;
	color: white;
	padding: 14px;
	text-align: center;
	border-top-left-radius: 30px;
	border-top-right-radius: 30px;
}

.left {
	background: white;
	position: absolute;
	left: 0.6%;
	width: 97.6%;
	height: 20%;
	padding-left: 1%;
	border-right: 2.5px dashed white;
	border-bottom-left-radius: 30px;
	border-bottom-right-radius: 30px;
}

.centered {
	position: absolute;
	top: 42%;
	left: 0.6%;
	height: 8%;
	width: 98.7%;
}

.submit {
	background: #101357;
	color: white;
	height: 100%;
	font-size: 24px;
	position: relative;
	left: 38%;
	border: 2px solid #101357;
	width: 25%;
	top:2%;
	border-radius: 35px;
}

td {
	text-align: left;
	color: #eb1736;
	font-weight: bold;
}
</style>
</head>
<body>
<%
if (session.getAttribute("msg")!=null){
	String message=session.getAttribute("msg").toString();
	out.println("<script>alert(\""+message+"\")</script>");
}
%>
	<div class="title">
		<h2 style="font-family: Verdana">Enter New Password</h2>
		<hr>
	</div>
	<div class="form">
		<form action="ForgotPassword5.jsp" method="get" autocomplete="on">
			<div class="left">
				<table cellpadding="6">
					<tr>
						<td>User Name:</td>
						<td><input type="text" name="user" size="40"
							value="<%= session.getAttribute("uname")%>" readonly="readonly"
							style="color: #eb1736"></td>
					</tr>

					<tr>
						<td>Password:</td>
						<td><input type="password" name="pwd" size="40"></td>
					</tr>
					<tr>
						<td>Confirm Password:</td>
						<td><input type="password" name="cpwd" size="40"></td>
					</tr>
					</table>

			</div>
			<div class="centered">
				<input type="submit" value="SUBMIT" class="submit">
			</div>
		</form>
	</div>
</body>
</html>

