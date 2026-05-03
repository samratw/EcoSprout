<%@ page import="com.ecosprout.model.ProductModel" %>
<!DOCTYPE html>
<html>
<head>
<title>Update Product</title>
</head>
<body>

<h2>Update Product</h2>

<%
ProductModel p = (ProductModel) request.getAttribute("product");
%>

<form action="updateProduct" method="post">

<input type="hidden" name="id" value="<%= p.getId() %>">

<input type="text" name="name" value="<%= p.getName() %>" required><br>
<input type="text" name="category" value="<%= p.getCategory() %>" required><br>

<button>Update</button>

</form>

</body>
</html>