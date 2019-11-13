<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Login Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- MATERIAL DESIGN ICONIC FONT -->
<link rel="stylesheet"
	href="fonts/material-design-iconic-font/css/material-design-iconic-font.min.css">
<!-- STYLE CSS -->
<link rel="stylesheet" href="css/style.css">
<style>
a {
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>
	<%
	if (session.getAttribute("msg")!=null){
	String message=session.getAttribute("msg").toString();
	out.println("<script>alert(\""+message+"\")</script>");
	session.removeAttribute("msg");
	}
	%>
	<div class="wrapper"
		style="background-image: url('images/bg_registration.jpg');">
		<div class="inner">
			<div class="image-holder">
				<img src="images/s_cross.png" align="" alt="cross">
			</div>
			<form action="Login.jsp">
				<h3>Already a member!</h3>
				<div class="form-wrapper">
					<input type="text" placeholder="Username" class="form-control"
						name="user"> <i class="zmdi zmdi-account"></i>
				</div>
				<div class="form-wrapper">
					<input type="password" placeholder="Password" class="form-control"
						name="password"> <i class="zmdi zmdi-lock"></i>
				</div>
				<button>
					Log in <i class="zmdi zmdi-arrow-right"></i>
				</button>
				
				<a href="ForgotPassword.jsp"><h4 align="middle">Forgot Password ?</h4></a><br>
				<h4 align="middle">Sign-up Instead ?</h4>
				<button formaction="SignUpPatient.html">
					Sign-up <i class="zmdi zmdi-arrow-right"></i>
				</button>
			</form>
		</div>
	</div>
</body>
</html>