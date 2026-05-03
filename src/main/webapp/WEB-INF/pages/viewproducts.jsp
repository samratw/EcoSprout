<%@ page import="java.util.*,com.ecosprout.model.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Products</title>
</head>
<body>

<h2>All Products</h2>

<%
List<ProductModel> list = (List<ProductModel>) request.getAttribute("products");

if(list != null){
    for(ProductModel p : list){
%>

<div style="border:1px solid #ccc; padding:10px; margin:10px;">
<h3><%= p.getName() %></h3>
<p>Category: <%= p.getCategory() %></p>

<img src="images/<%= p.getImage() %>" width="120">
<br>

<a href="updateProduct?id=<%= p.getId() %>">Edit</a>

</div>

<%
    }
}
%>

<a href="admin">Back</a>

</body>
</html>