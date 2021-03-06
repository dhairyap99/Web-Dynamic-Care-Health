<html>
<head>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="SignUpPage.css">
<title>Sign Up</title>
</head>
<body>
	<%
	String message=session.getAttribute("msg").toString();
	out.println("<script>alert(\""+message+"\")</script>");
	session.removeAttribute("msg");
	%>
	<div class="wrapper"
		style="background-image: url('images/bg_registration.jpg');">

		<div class="container register">
			<div class="row">
				<div class="col-md-4 register-left">
					<img src="images/s_cross.png" align="center" alt="cross">
				</div>
				<div class="col-md-8 register-right">
					<ul class="nav nav-tabs nav-justified" id="myTab" role="tablist">
						<li class="nav-item"><a class="nav-link active"
							id="patient-tab" data-toggle="tab" href="SignUpPatient.html"
							role="tab" aria-controls="home" aria-selected="true">Patient</a></li>
						<li class="nav-item"><a class="nav-link" id="doctor-tab"
							data-toggle="tab" href="SignUpDoctor.html" role="tab"
							aria-controls="profile" aria-selected="false">Doctor</a></li>
					</ul>
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade show active" id="home" role="tabpanel"
							aria-labelledby="patient-tab">
							<h3 class="register-heading">Sign Up as a Patient</h3>

							<form class="row register-form" action="Patient1.jsp"
								method="get">
								<div class="col-md-6">

									<div class="form-group">
										<input type="text" class="form-control"
											placeholder="First Name" value="" name="fname" tabindex="1" required="required"/>
									</div>
									<div class="form-group">
										<input type="email" class="form-control"
											placeholder="Email Id" value="" name="mail" tabindex="3" required="required"/>
									</div>
									<div class="form-group">
										<input type="password" class="form-control"
											placeholder="Password" value="" name="pwd" tabindex="5" required="required"/>
									</div>

								</div>
								<div class="col-md-6">
									<div class="form-group">
										<input type="text" class="form-control"
											placeholder="Last Name" value="" name="lname" tabindex="2" required="required"/>
									</div>
									<div class="form-group">
										<input type="text" class="form-control"
											placeholder="User Name" value="" name="uname" tabindex="4" required="required"/>
									</div>

									<div class="form-group">
										<input type="password" class="form-control"
											placeholder="Confirm Password" value="" name="cpwd" tabindex="6" required="required"/>
									</div>

								</div>

								<input type="submit" class="btnRegister" value="Register" tabindex="7"/>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>