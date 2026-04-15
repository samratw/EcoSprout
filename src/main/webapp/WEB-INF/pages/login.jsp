<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
	<title>Login</title>
  	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/signup.css">
  	<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;500&display=swap" rel="stylesheet">
</head>
<body>

  	<div class="signup-page">

	<!-- Left: Form -->
    <div class="signup-left">
    	<div class="signup-brand">ECOSPROUT</div>
      	<div class="signup-box">
        	<h2 class="signup-title">LOGIN</h2>

        	<% if (request.getAttribute("error") != null) { %><div class="signup-error"><%= request.getAttribute("error") %></div><% } %>

        	<form action="<%=request.getContextPath()%>/loginpage" method="post">
          		<div class="form-group">
            		<label>EMAIL</label>
            		<input type="email" name="email" placeholder="Enter your email" required>
          		</div>
          		<div class="form-group">
            		<label>PASSWORD</label>
            		<input type="password" name="password" placeholder="Enter your password" required>
          		</div>
        		
        		<div class="form-options">
        			<label class="remember-me">
        				<input type="checkbox" name="rememberMe">
        				<span>Remember me</span>
        			</label>
        			<a href="<%=request.getContextPath()%>/forgotpassword" class="forgot-password">Forgot Password?</a>
        		</div>
        		
        		<button type="submit" class="signup-btn-submit">Login</button>
        	</form>

        	<div class="login-divider">
        		<span>OR</span>
        	</div>
        	
        	<p class="login-register">Don't have an account?
        		<a href="<%=request.getContextPath()%>/signuppage">Register Now</a></p>
      	</div>
    </div>

    <!-- Right: Image -->
	<div class="signup-right">
      <img src="<%=request.getContextPath()%>/images/test-product2.jpg" alt="">
    </div>

	</div>

</body>
</html>