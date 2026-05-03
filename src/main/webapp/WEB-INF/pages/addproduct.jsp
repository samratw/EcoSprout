<!DOCTYPE html>
<html>
<head>
<title>Add Product</title>
</head>
<body>

<h2>Add Product</h2>

<%
String error = (String) request.getAttribute("error");
if(error != null){
%>
<p style="color:red;"><%= error %></p>
<% } %>

<form action="addproduct" method="post" enctype="multipart/form-data">

<input type="text" name="name" placeholder="Product Name" required><br>
<input type="text" name="category" placeholder="Category" required><br>

<input type="file" name="image" required><br>

<button>Add Product</button>

</form>

<br>
<a href="admin">Back</a>

</body>
</html>