<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<style>
body { font-family: Arial; background:#f5f5f5; }
.container { width:300px; margin:100px auto; padding:20px; background:white; border-radius:8px; }
input,button { width:100%; padding:10px; margin:5px 0; }
button { background:green; color:white; border:none; }
</style>
</head>
<body>

<div class="container">
<h2>Login</h2>

<%
String error = (String) request.getAttribute("error");
if(error != null){
%>
<p style="color:red;"><%= error %></p>
<% } %>

<form action="login" method="post">
<input type="email" name="email" placeholder="Email" required>
<input type="password" name="password" placeholder="Password" required>
<button>Login</button>
</form>

<p>Don't have account? <a href="register">Register</a></p>

</div>
</body>
</html>