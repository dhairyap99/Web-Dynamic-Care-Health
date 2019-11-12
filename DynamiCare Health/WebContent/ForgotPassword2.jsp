<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1"><link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<script type="text/javascript">
    $(window).on('load',function(){
        $('#myModal').modal('show');
    });
</script>
<title>Forgot Password</title>
</head>
<body>
<%
session.setAttribute("uname",session.getAttribute("uname"));
session.setAttribute("otp",session.getAttribute("otp"));
%>
<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="background: #eb1736; color: white;">
					<h4 class="modal-title">Enter OTP: </h4>
				</div>
				<div class="modal-body no-border">
					<form action="ForgotPassword3.jsp" method="get">
						<input type="text" size="60px" name="otp1"></input>
						<input
							type="submit" value="SUBMIT">
					</form>
				</div>
				<div class="modal-footer no-border">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						style="background: #eb1736; color: white;" onclick="window.location.href='Login1.jsp'">Close</button>
				</div>
			</div>

		</div>
	</div>
</body>
</html>