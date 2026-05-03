<!DOCTYPE html>
<html>
<head>
<title>Register</title>
<style>
body { font-family: Arial; }
.container { width:300px; margin:80px auto; }
</style>
</head>
<body>

<div class="container">
<h2>Register</h2>

<%
String error = (String) request.getAttribute("error");
if(error != null){
%>
<p style="color:red;"><%= error %></p>
<% } %>

<form action="register" method="post">

<input type="text" name="name" placeholder="Name" required><br>
<input type="email" name="email" placeholder="Email" required><br>
<input type="password" name="password" placeholder="Password" required><br>

<select name="role" required>
<option value="">Select Role</option>
<option value="buyer">Buyer</option>
<option value="vendor">Vendor</option>
</select>

<button>Register</button>
</form>

<p><a href="login">Back to Login</a></p>
</div>

</body>
</html>