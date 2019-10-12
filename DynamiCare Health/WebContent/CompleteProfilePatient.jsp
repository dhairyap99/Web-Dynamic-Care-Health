<html>
<head>
	<title>Other Details</title>
	<style type="text/css">
	body{
		background:  #5252d4;
	}
	.form{
		background: #ffffff;
		color: white;
		font-family: Calibri;
		font-size: 18px;
		padding: 8px;
	}
	.title{
		background: #eb1736;
		color: white;
		padding: 14px;
		text-align: center;
		border-top-left-radius:30px;		
		border-top-right-radius:30px;
	}
	.left{
		background: white;
		position: absolute;
		left:0.6%;
		width: 49%;
		height:63%;
		padding-left: 1%;
		border-right: 2.5px dashed white;
		border-bottom-left-radius:30px;
	}
	.right{
	color: #eb1736;
		background: white;
		position: absolute;
		left: 50.8%;
		width: 47.4%;
		height: 63%;
		padding-left: 1%;
		border-left: 2.5px dashed #eb1736;
		border-bottom-right-radius:30px;
	}

	.centered{
		position: absolute;
		top:83.5%;
		left:0.6%;
		height: 8%;
		width: 98.7%;
	}
	.submit{
		background: #101357;
		color: white;
		height: 100%;
		font-size: 24px;
		position: relative;
		left: 38%;
		border: 2px solid #101357;
		width: 25%;
		border-radius:35px;
	}

	td{
		text-align: left;
		color: #eb1736;
		font-weight: bold;
	}

</style>
</head>
<body>
<div class="title">
		<h2 style="font-family: Verdana">Build Profile</h2>
		<hr>
	</div>
	<div class="form">
		<form action = "Patient2.jsp" method="get" autocomplete = "on">
			<div class="left">
				<table cellpadding="6">
					<tr>
						<td>User Name:</td>
						<td><input type="text" name="user" size="40" value="<%= request.getParameter("uname")%>"  readonly="readonly" 
						style="color:#eb1736"></td>
					</tr> 

					<tr>
						<td>Height:</td>
						<td><input type="text" name="ht" placeholder="in ft" size="40"></td>
					</tr>
					<tr>
						<td>Weight:</td>
						<td><input type="text" name="wt" placeholder="in kg" size="40"></td>
					</tr>

					<tr>
						<td>Sex:</td>
						<td>
							<select name="sex">
								<option>Male</option>
								<option>Female</option>
								<option>Others</option>
							</select>
						</td>
					</tr>

					<tr>
						<td>Age:</td>
						<td><input type="text" name="age" placeholder="in yrs" size="40"></td>
					</tr>
					
					<tr>
						<td>Phone No.:</td>
						<td><input type="text" name="ph" size="40"></td>
					</tr>
				</table>
				<hr>
				<table cellpadding="6">
					<tr>
						<td>Family History:</td>         
						<td><input type="text" name="fhist" size="40"></td>
					</tr>

					<tr>
						<td>Allergy History:</td>         
						<td><input type="text" name="alhist" size="40"></td>
					</tr>

					<tr>
						<td>Major Illness:</td>         
						<td><input type="text" name="mil" size="40"></td>
					</tr>
				</table>
			</div>

			<div class="right">
				<h2>Emergency Contact No. 1</h2>
				<table cellpadding="6">
					<tr>
						<td>Name:</td>         
						<td><input type="text" name="ename1" size="40"></td>
					</tr>

					<tr>
						<td>Phone No.:</td>         
						<td><input type="text" name="eph1" size="40"></td>
					</tr>

					<tr>
						<td>Relation:</td>         
						<td><input type="text" name="rel1" size="40"></td>
					</tr>
				</table>
				<hr>

				<h2>Emergency Contact No. 2</h2>
				<table cellpadding="6">
					<tr>
						<td>Name:</td>         
						<td><input type="text" name="ename2" size="40"></td>
					</tr>

					<tr>
						<td>Phone No.:</td>         
						<td><input type="text" name="eph2" size="40"></td>
					</tr>

					<tr>
						<td>Relation:</td>         
						<td><input type="text" name="rel2" size="40"></td>
					</tr>
				</table>

			</div>
			<div class="centered">
				<input type = "submit" value = "SUBMIT" class="submit">
			</div>
		</form>
	</div>
</body>
</html>

