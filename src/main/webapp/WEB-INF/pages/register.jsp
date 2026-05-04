<%@ page contentType="text/html;charset=UTF-8" import="java.util.*,com.ecosprout.model.UserModel" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register - EcoSprout</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrap">
  <div class="auth-box">
    <div class="logo">
      <img src="${pageContext.request.contextPath}/images/authlogo.png" width="280" height="85" />
      <h1>Create your account</h1>
    </div>

    <%
      String error       = (String)     request.getAttribute("error");
      UserModel formData = (UserModel)   request.getAttribute("formData");
      Map<String,String> roles = (Map<String,String>) request.getAttribute("roles");

      String prevName  = formData != null ? formData.getName()  : "";
      String prevEmail = formData != null ? formData.getEmail() : "";
      String prevPhone = formData != null ? formData.getPhone() : "";
      String prevRole  = formData != null ? formData.getRole()  : "";
    %>
    <% if (error != null) { %><div class="alert alert-error"><%= error %></div><% } %>

    <form action="register" method="post">
      <div class="form-group">
        <label>Full Name</label>
        <input type="text" name="name" placeholder="e.g. Anamika Bhattarai"
               value="<%= prevName %>" required>
      </div>
      <div class="form-group">
        <label>Email Address</label>
        <input type="email" name="email" placeholder="your@gmail.com"
               value="<%= prevEmail %>" required>
      </div>
      <div class="form-group">
        <label>Phone Number (10 digits)</label>
        <input type="text" name="phone" placeholder="98XXXXXXXX"
               maxlength="10" value="<%= prevPhone %>" required>
      </div>
      <div class="form-group">
        <label>Password (min 6 characters)</label>
        <input type="password" name="password" placeholder="••••••••" required>
      </div>

      <%-- Roles pushed by RegisterServlet from AppConfig.REGISTER_ROLES --%>
      <div class="form-group">
        <label>Register As</label>
        <select name="role" required>
          <option value="">-- Select Role --</option>
          <% if (roles != null) {
               for (Map.Entry<String,String> entry : roles.entrySet()) { %>
          <option value="<%= entry.getKey() %>"
                  <%= entry.getKey().equals(prevRole) ? "selected" : "" %>>
            <%= entry.getValue() %>
          </option>
          <% }} %>
        </select>
      </div>

      <button type="submit" class="btn btn-primary btn-full" style="margin-top:8px;">
        Create Account
      </button>
    </form>

    <div class="alert alert-info" style="margin-top:16px; font-size:0.85rem;">
      ℹ️ New accounts require admin approval before you can log in.
    </div>
    <div class="auth-links">
      <p>Already have an account? <a href="login">Login here</a></p>
    </div>
  </div>
</div>
</body>
</html>
