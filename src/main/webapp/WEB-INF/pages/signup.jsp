<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Sign Up</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/signup.css">
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;500&display=swap"
	rel="stylesheet">
</head>
<body>

	<div class="signup-page">

		<!-- Left: Form -->
		<div class="signup-left">
			<div class="signup-brand">ECOSPROUT</div>
			<div class="signup-box">
				<h2 class="signup-title">REGISTER</h2>

				<%
				if (request.getAttribute("error") != null) {
				%><div class="signup-error"><%=request.getAttribute("error")%></div>
				<%
				}
				%>

				<form action="<%=request.getContextPath()%>/signuppage"
					method="post">
					<div class="form-group">
						<label>USERNAME</label> <input type="tteext" name="username"
							placeholder="Enter your username" required>
					</div>
					<div class="form-group">
						<label>EMAIL</label> <input type="email" name="email"
							placeholder="Enter your email" required>
					</div>
					<div class="form-group">
						<label for="userType">ACCOUNT TYPE</label> <select name="userType"
							required>
							<option value="" disabled selected>Select your role</option>
							<option value="Customer">Customer</option>
							<option value="Vendor">Vendor</option>
						</select>
					</div>
					<div class="form-group">
						<label>PASSWORD</label> <input type="password" name="password"
							placeholder="Enter your password" required>
					</div>
					<div class="form-group">
						<label>RE-TYPE PASSWORD</label> <input type="password"
							name="rePassword" placeholder="Re-type your password" required>
					</div>
					<button type="submit" class="signup-btn-submit">Create
						Account</button>
				</form>

				<p class="signup-login">
					Already have an account? <a
						href="<%=request.getContextPath()%>/loginpage">Login</a>
				</p>
			</div>
		</div>

		<!-- Right: Image -->
		<div class="signup-right">
			<img src="<%=request.getContextPath()%>/images/test-product2.jpg"
				alt="">
		</div>

	</div>

</body>
</html>