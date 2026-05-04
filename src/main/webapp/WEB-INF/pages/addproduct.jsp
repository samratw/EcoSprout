<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Product - EcoSprout</title>
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
  <div class="page-header">
    <h1>Add New Product</h1>
    <p>List a new agro product on EcoSprout.</p>
  </div>

  <% String error = (String) request.getAttribute("error"); %>
  <% if (error != null) { %><div class="alert alert-error"><%= error %></div><% } %>

  <div class="card" style="max-width:680px;">
    <form action="addproduct" method="post" enctype="multipart/form-data">

      <div class="form-group">
        <label>Product Name *</label>
        <input type="text" name="name" placeholder="e.g. Organic Tomatoes" required>
      </div>

      <div class="form-row">
        <%-- Category list pushed by AddProductServlet from AppConfig --%>
        <div class="form-group">
          <label>Category *</label>
          <select name="category" required>
            <option value="">-- Select Category --</option>
            <%
              List<String> categories = (List<String>) request.getAttribute("categories");
              if (categories != null) {
                for (String cat : categories) {
            %>
            <option value="<%= cat %>"><%= cat %></option>
            <% }} %>
          </select>
        </div>

        <%-- Unit map pushed by AddProductServlet from AppConfig --%>
        <div class="form-group">
          <label>Unit *</label>
          <select name="unit" required>
            <%
              Map<String, String> units = (Map<String, String>) request.getAttribute("units");
              if (units != null) {
                for (Map.Entry<String, String> entry : units.entrySet()) {
            %>
            <option value="<%= entry.getKey() %>"><%= entry.getValue() %></option>
            <% }} %>
          </select>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Price per Unit (NPR) *</label>
          <input type="number" name="price" min="0.01" step="0.01" placeholder="e.g. 120.00" required>
        </div>
        <div class="form-group">
          <label>Available Quantity *</label>
          <input type="number" name="quantity" min="0" placeholder="e.g. 50" required>
        </div>
      </div>

      <div class="form-group">
        <label>Description</label>
        <textarea name="description" rows="3"
                  placeholder="Describe your product, growing method, freshness, etc."></textarea>
      </div>

      <div class="form-group">
        <label>Product Image</label>
        <input type="file" name="image" accept="image/*">
        <small style="color:var(--text-light);">Max 5MB. JPG, PNG accepted.</small>
      </div>

      <div style="display:flex;gap:12px;margin-top:8px;">
        <button type="submit" class="btn btn-primary">Add Product</button>
        <a href="${sessionScope.user.role == 'admin' ? 'admin' : 'vendor'}" class="btn btn-outline">Cancel</a>
      </div>
    </form>
  </div>
</div>
<footer>&copy; 2026 EcoSprout</footer>
</body>
</html>
