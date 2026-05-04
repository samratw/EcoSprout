<%@ page contentType="text/html;charset=UTF-8" import="com.ecosprout.model.*,java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - EcoSprout</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<nav class="navbar">
  <img src="${pageContext.request.contextPath}/images/logo.png" width="250" height="65" />
  <nav>
    <a href="admin">Dashboard</a>
    <a href="viewproducts">Products</a>
    <a href="manageusers">Users</a>
    <a href="about">About</a>
    <a href="logout" class="logout">Logout</a>
  </nav>
</nav>

<div class="page">
  <div class="page-header">
    <h1>Admin Dashboard</h1>
    <p>Welcome, <strong>${sessionScope.user.name}</strong> - manage EcoSprout from here.</p>
  </div>

  <% String dbError = (String) request.getAttribute("dbError"); %>
  <% if (dbError != null) { %><div class="alert alert-error"><%= dbError %></div><% } %>

  <!-- Stats Row -->
  <div class="stats-row">
    <div class="stat-card">
      <div class="stat-number">${totalProducts}</div>
      <div class="stat-label">Total Products</div>
    </div>
    <div class="stat-card">
      <div class="stat-number">${pendingUsers}</div>
      <div class="stat-label">Pending Approvals</div>
    </div>
    <div class="stat-card">
      <div class="stat-number">${totalOrders}</div>
      <div class="stat-label">Total Orders</div>
    </div>
  </div>

  <div class="dashboard-layout">
    <div class="sidebar">
      <div class="side-card">
        <a href="addproduct">➕ Add Product</a>
        <a href="viewproducts">📦 View All Products</a>
        <a href="manageusers">👥 Manage Users</a>
        <a href="about">ℹ️ About Page</a>
        <a href="contact">📬 Contact</a>
        <a href="logout" style="color:var(--danger);">🚪 Logout</a>
      </div>
    </div>

    <div class="main-content">
      <!-- Recent Orders -->
      <div class="card">
        <h2>Recent Orders</h2>
        <%
          List<com.ecosprout.model.OrderModel> orders =
              (List<com.ecosprout.model.OrderModel>) request.getAttribute("recentOrders");
        %>
        <% if (orders == null || orders.isEmpty()) { %>
          <p style="color:var(--text-light);">No orders placed yet.</p>
        <% } else { %>
          <div class="table-wrap">
          <table>
            <tr>
              <th>#</th><th>Buyer</th><th>Product</th><th>Qty</th><th>Total (NPR)</th><th>Status</th><th>Date</th>
            </tr>
            <% for (com.ecosprout.model.OrderModel o : orders) { %>
            <tr>
              <td><%= o.getId() %></td>
              <td><%= o.getBuyerName() %></td>
              <td><%= o.getProductName() %></td>
              <td><%= o.getQuantity() %></td>
              <td><%= String.format("%.2f", o.getTotalPrice()) %></td>
              <td><span class="badge badge-<%= o.getStatus() %>"><%= o.getStatus() %></span></td>
              <td><%= o.getCreatedAt() != null ? o.getCreatedAt().substring(0,10) : "-" %></td>
            </tr>
            <% } %>
          </table>
          </div>
        <% } %>
      </div>
    </div>
  </div>
</div>

<footer>
  &copy; 2026 EcoSprout — Fresh Agro Products Marketplace |
  <a href="about">About</a> | <a href="contact">Contact</a>
</footer>
</body>
</html>
