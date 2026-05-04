<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - EcoSprout</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrap">
  <div class="auth-box">
    <div class="logo">
      <img src="${pageContext.request.contextPath}/images/authlogo.png" width="280" height="85" />
      <h1>Login to your account</h1>
    </div>

    <h2>Welcome Back</h2>

    <%
      String error   = (String) request.getAttribute("error");
      String success = (String) request.getAttribute("success");
    %>
    <% if (error != null) { %><div class="alert alert-error"><%= error %></div><% } %>
    <% if (success != null) { %><div class="alert alert-success"><%= success %></div><% } %>

    <form action="login" method="post">
      <div class="form-group">
        <label for="email">Email Address</label>
        <input type="email" id="email" name="email" placeholder="your@gmail.com" required>
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="••••••••" required>
      </div>
      <button type="submit" class="btn btn-primary btn-full" style="margin-top:8px;">Login</button>
    </form>

    <div class="auth-links">
      <p>Don't have an account? <a href="register">Register here</a></p>
      <p style="margin-top:8px;"><a href="about">About EcoSprout</a> | <a href="contact">Contact Us</a></p>
    </div>
  </div>
</div>
</body>
</html>
