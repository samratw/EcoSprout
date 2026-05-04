<%@ page contentType="text/html;charset=UTF-8" import="com.ecosprout.model.UserModel,java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Users - EcoSprout</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav class="navbar">
  <a href="admin" class="brand">🌱 Eco<span>Sprout</span></a>
  <nav>
    <a href="admin">Dashboard</a><a href="viewproducts">Products</a>
    <a href="manageusers">Users</a><a href="logout" class="logout">Logout</a>
  </nav>
</nav>
<div class="page">
  <div class="page-header">
    <h1>Manage Users</h1>
    <p>Approve or reject vendor and buyer registrations.</p>
  </div>

  <% String error = (String) request.getAttribute("error");
     if (error != null) { %><div class="alert alert-error"><%= error %></div><% } %>

  <div class="card">
    <div class="table-wrap">
    <table>
      <tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Role</th><th>Status</th><th>Action</th></tr>
      <%
        List<UserModel> users = (List<UserModel>) request.getAttribute("users");
        if (users != null) {
          for (UserModel u : users) {
      %>
      <tr>
        <td><%= u.getId() %></td>
        <td><%= u.getName() %></td>
        <td><%= u.getEmail() %></td>
        <td><%= u.getPhone() != null ? u.getPhone() : "-" %></td>
        <td><span class="badge badge-approved"><%= u.getRole() %></span></td>
        <td><span class="badge badge-<%= u.getStatus() %>"><%= u.getStatus() %></span></td>
        <td>
          <% if ("pending".equals(u.getStatus())) { %>
          <form action="manageusers" method="post" style="display:inline;">
            <input type="hidden" name="userId" value="<%= u.getId() %>">
            <button name="action" value="approve" class="btn btn-success btn-sm">Approve</button>
            <button name="action" value="reject"  class="btn btn-danger  btn-sm">Reject</button>
          </form>
          <% } else if ("approved".equals(u.getStatus()) && !"admin".equals(u.getRole())) { %>
          <form action="manageusers" method="post" style="display:inline;">
            <input type="hidden" name="userId" value="<%= u.getId() %>">
            <button name="action" value="reject" class="btn btn-warning btn-sm">Revoke</button>
          </form>
          <% } else { %>
          <span style="color:var(--text-light);">—</span>
          <% } %>
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
