<%@ page contentType="text/html;charset=UTF-8" import="java.util.*,com.ecosprout.model.ProductModel" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update Product - EcoSprout</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav class="navbar">
  <a href="${sessionScope.user.role == 'admin' ? 'admin' : 'vendor'}" class="brand">🌱 Eco<span>Sprout</span></a>
  <nav>
    <a href="${sessionScope.user.role == 'admin' ? 'admin' : 'vendor'}">Dashboard</a>
    <a href="logout" class="logout">Logout</a>
  </nav>
</nav>
<div class="page">
  <div class="page-header"><h1>Update Product</h1><p>Edit the product details below.</p></div>

  <%
    String error       = (String)       request.getAttribute("error");
    ProductModel p     = (ProductModel) request.getAttribute("product");
    List<String> cats  = (List<String>) request.getAttribute("categories");
    Map<String,String> units    = (Map<String,String>) request.getAttribute("units");
    Map<String,String> statuses = (Map<String,String>) request.getAttribute("productStatuses");
  %>
  <% if (error != null) { %><div class="alert alert-error"><%= error %></div><% } %>

  <% if (p != null) { %>
  <div class="card" style="max-width:680px;">
    <form action="updateproduct" method="post">
      <input type="hidden" name="id" value="<%= p.getId() %>">

      <div class="form-group">
        <label>Product Name *</label>
        <input type="text" name="name" value="<%= p.getName() %>" required>
      </div>

      <div class="form-row">
        <%-- Categories from AppConfig via UpdateProductServlet --%>
        <div class="form-group">
          <label>Category *</label>
          <select name="category" required>
            <% if (cats != null) { for (String cat : cats) { %>
            <option value="<%= cat %>" <%= cat.equals(p.getCategory()) ? "selected" : "" %>><%= cat %></option>
            <% }} %>
          </select>
        </div>

        <%-- Units from AppConfig via UpdateProductServlet --%>
        <div class="form-group">
          <label>Unit *</label>
          <select name="unit" required>
            <% if (units != null) { for (Map.Entry<String,String> e : units.entrySet()) { %>
            <option value="<%= e.getKey() %>" <%= e.getKey().equals(p.getUnit()) ? "selected" : "" %>>
              <%= e.getValue() %>
            </option>
            <% }} %>
          </select>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Price per Unit (NPR) *</label>
          <input type="number" name="price" step="0.01" value="<%= p.getPrice() %>" required>
        </div>
        <div class="form-group">
          <label>Quantity *</label>
          <input type="number" name="quantity" value="<%= p.getQuantity() %>" required>
        </div>
      </div>

      <div class="form-group">
        <label>Description</label>
        <textarea name="description" rows="3"><%= p.getDescription() != null ? p.getDescription() : "" %></textarea>
      </div>

      <%-- Product statuses from AppConfig via UpdateProductServlet --%>
      <div class="form-group">
        <label>Status</label>
        <select name="status">
          <% if (statuses != null) { for (Map.Entry<String,String> e : statuses.entrySet()) { %>
          <option value="<%= e.getKey() %>" <%= e.getKey().equals(p.getStatus()) ? "selected" : "" %>>
            <%= e.getValue() %>
          </option>
          <% }} %>
        </select>
      </div>

      <div style="display:flex;gap:12px;margin-top:8px;">
        <button type="submit" class="btn btn-warning">Save Changes</button>
        <a href="${sessionScope.user.role == 'admin' ? 'admin' : 'vendor'}" class="btn btn-outline">Cancel</a>
      </div>
    </form>
  </div>
  <% } else { %>
  <div class="alert alert-error">Product not found.</div>
  <% } %>
</div>
<footer>&copy; 2026 EcoSprout</footer>
</body>
</html>
