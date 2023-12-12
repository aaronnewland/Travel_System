<!DOCTYPE html>
<html>
<style>
	.header {
		height: 50px;
	}

	.center {
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.align {
		margin-top: 10px;
		margin-left: 100px;
	}
</style>
	<head>
		<title>Login Form</title>
	</head>
	<body>
	<div class="center">
		<h2>
			Welcome, please log in to continue.
		</h2>
	</div>
	<div class="header"></div>
	<div class="center">
		<form action="checkLoginDetails.jsp" method="POST">
			Username: <input type="text" name="username"/> <br/>
			Password: <input type="password" name="password"/> <br/>
			<div class="align">
				<input type="submit" value="Submit"/>
			</div>
		</form>
	</div>
	</body>
</html>