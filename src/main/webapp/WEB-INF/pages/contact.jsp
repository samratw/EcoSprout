<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Contact Us - EcoSprout</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav class="navbar">
  <img src="${pageContext.request.contextPath}/images/logo.png" width="250" height="65" />
  <nav>
    <a href="about">About</a>
    <a href="contact">Contact</a>
    <% if (session.getAttribute("user") != null) { %>
      <a href="logout" class="logout">Logout</a>
    <% } else { %>
      <a href="login">Login</a>
    <% } %>
  </nav>
</nav>

<div class="page">
  <div style="max-width:700px; margin:0 auto;">
    <div class="page-header">
      <h1>Contact Us</h1>
      <p>We'd love to hear from you. Send us a message and we'll respond within 24 hours.</p>
    </div>

    <% String success = (String) request.getAttribute("success"); %>
    <% if (success != null) { %><div class="alert alert-success"><%= success %></div><% } %>

    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px; margin-bottom:24px;">
      <div class="card" style="text-align:center;">
        <div style="font-size:2rem;">📍</div>
        <h3 style="color:var(--green-dark); margin:8px 0 4px;">Address</h3>
        <p style="font-size:0.9rem; color:var(--text-light);">Kathmandu, Bagmati Province<br>Nepal</p>
      </div>
      <div class="card" style="text-align:center;">
        <div style="font-size:2rem;">📧</div>
        <h3 style="color:var(--green-dark); margin:8px 0 4px;">Email</h3>
        <p style="font-size:0.9rem; color:var(--text-light);">support@ecosprout.com.np</p>
      </div>
      <div class="card" style="text-align:center;">
        <div style="font-size:2rem;">📞</div>
        <h3 style="color:var(--green-dark); margin:8px 0 4px;">Phone</h3>
        <p style="font-size:0.9rem; color:var(--text-light);">+977-1-XXXXXXX</p>
      </div>
      <div class="card" style="text-align:center;">
        <div style="font-size:2rem;">🕐</div>
        <h3 style="color:var(--green-dark); margin:8px 0 4px;">Hours</h3>
        <p style="font-size:0.9rem; color:var(--text-light);">Sun–Fri: 9AM – 6PM NPT</p>
      </div>
    </div>

    <div class="card">
      <h2>Send us a Message</h2>
      <form action="contact" method="post" style="margin-top:16px;">
        <div class="form-row">
          <div class="form-group">
            <label>Full Name *</label>
            <input type="text" name="name" placeholder="Your name" required>
          </div>
          <div class="form-group">
            <label>Email *</label>
            <input type="email" name="email" placeholder="your@email.com" required>
          </div>
        </div>

        <%-- Subject list pushed by ContactServlet from AppConfig.CONTACT_SUBJECTS --%>
        <div class="form-group">
          <label>Subject *</label>
          <select name="subject" required>
            <option value="">-- Select Subject --</option>
            <%
              List<String> subjects = (List<String>) request.getAttribute("contactSubjects");
              if (subjects != null) {
                for (String s : subjects) {
            %>
            <option value="<%= s %>"><%= s %></option>
            <% }} %>
          </select>
        </div>

        <div class="form-group">
          <label>Message *</label>
          <textarea name="message" rows="5"
                    placeholder="How can we help you?" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Send Message</button>
      </form>
    </div>
  </div>
</div>
<footer>&copy; 2026 EcoSprout | <a href="about">About</a></footer>
</body>
</html>
