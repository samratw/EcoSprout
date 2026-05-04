<%@ page contentType="text/html;charset=UTF-8" import="com.ecosprout.model.ProductModel,java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>All Products - EcoSprout</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav class="navbar">
  <a href="admin" class="brand">🌱 Eco<span>Sprout</span></a>
  <nav>
    <a href="admin">Dashboard</a><a href="manageusers">Users</a>
    <a href="addproduct">Add Product</a><a href="logout" class="logout">Logout</a>
  </nav>
</nav>
<div class="page">
  <div class="page-header"><h1>All Products</h1><p>View and manage all product listings on EcoSprout.</p></div>

  <% String error = (String) request.getAttribute("error");
     if (error != null) { %><div class="alert alert-error"><%= error %></div><% } %>

  <div class="card">
    <div class="table-wrap">
    <table>
      <tr><th>ID</th><th>Image</th><th>Name</th><th>Category</th><th>Price (NPR)</th><th>Qty</th><th>Status</th><th>Actions</th></tr>
      <%
        List<ProductModel> products = (List<ProductModel>) request.getAttribute("products");
        if (products != null) {
          for (ProductModel p : products) {
      %>
      <tr>
        <td><%= p.getId() %></td>
        <td>
          <% if (p.getImage() != null) { %>
            <img src="${pageContext.request.contextPath}/images/<%= p.getImage() %>"
                 style="width:50px;height:40px;object-fit:cover;border-radius:4px;">
          <% } else { %> 🌾 <% } %>
        </td>
        <td><strong><%= p.getName() %></strong></td>
        <td><%= p.getCategory() %></td>
        <td><%= String.format("%.2f", p.getPrice()) %> / <%= p.getUnit() %></td>
        <td><%= p.getQuantity() %></td>
        <td><span class="badge badge-<%= p.getStatus() %>"><%= p.getStatus() %></span></td>
        <td>
          <a href="updateproduct?id=<%= p.getId() %>" class="btn btn-warning btn-sm">Edit</a>
          <a href="deleteproduct?id=<%= p.getId() %>" class="btn btn-danger btn-sm"
             onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
        </td>
      </tr>
      <% }} %>
    </table>
    </div>
  </div>
  <a href="admin" class="btn btn-outline">← Back to Dashboard</a>
</div>
<footer>&copy; 2026 EcoSprout</footer>
</body>
</html>
