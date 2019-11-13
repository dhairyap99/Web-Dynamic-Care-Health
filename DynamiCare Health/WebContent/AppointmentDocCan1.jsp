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
<style type="text/css">
body {
	font-family: Verdana;
	font-size:20px;
}
</style>
<title>Cancel Appointment</title>
</head>
<body>
<%
String uname=session.getAttribute("user").toString();
session.setAttribute("user", uname);
%>
<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="background: #eb1736; color: white;">
					<h4 class="modal-title">Cancel Appointment: </h4>
				</div>
				<div class="modal-body no-border">
					<form action="AppointmentDocCan2.jsp" action="get">
						<input type="hidden" name="b" value=<%=request.getParameter("bid")%>> 
						Are You Sure? &nbsp;&nbsp;&nbsp;  
						<input type="submit" value="YES">
					</form>

				</div>
				<div class="modal-footer no-border">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						style="background: #eb1736; color: white;" onclick="window.location.href='AppointmentDocCan.jsp'">Close</button>
				</div>
			</div>

		</div>
	</div>
</body>
</html>