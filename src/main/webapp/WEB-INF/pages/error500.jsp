<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>500 Server Error - EcoSprout</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"></head>
<body>
<nav class="navbar"><a href="login" class="brand">🌱 Eco<span>Sprout</span></a></nav>
<div class="page" style="text-align:center; padding-top:80px;">
  <div style="font-size:5rem;">⚠️</div>
  <h1 style="font-size:3rem; color:var(--danger);">500</h1>
  <h2 style="color:var(--text-light); font-weight:400;">Internal Server Error</h2>
  <p style="color:var(--text-light); margin:16px 0 24px;">Something went wrong on our end. Please try again later.</p>
  <a href="javascript:history.back()" class="btn btn-outline" style="margin-right:12px;">← Go Back</a>
  <a href="login" class="btn btn-primary">Home</a>
</div>
<footer>&copy; 2026 EcoSprout</footer>
</body></html>
