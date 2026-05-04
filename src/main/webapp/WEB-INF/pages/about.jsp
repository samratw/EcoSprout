<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>About Us - EcoSprout</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav class="navbar">
  <img src="${pageContext.request.contextPath}/images/logo.png" width="250" height="65" />
  <nav>
    <a href="about">About</a><a href="contact">Contact</a>
    <% if (session.getAttribute("user") != null) { %><a href="logout" class="logout">Logout</a><% } else { %><a href="login">Login</a><% } %>
  </nav>
</nav>

<div class="page">
  <div style="max-width:800px; margin:0 auto;">

    <div class="card" style="text-align:center; padding:48px 32px; background:linear-gradient(135deg, var(--green-dark), var(--green-mid)); color:white;">
      <h1 style="font-size:2.2rem; margin:16px 0 8px; color:white;">About EcoSprout</h1>
      <p style="font-size:1.1rem; opacity:0.9;">Connecting local farmers with buyers across Nepal</p>
    </div>

    <div class="card">
      <h2>Our Mission</h2>
      <p style="line-height:1.8; color:var(--text-light); margin-top:8px;">
        EcoSprout is an online agro-product marketplace that bridges the gap between local farmers and consumers.
        We provide a transparent, fair, and efficient platform where vendors can list their fresh produce
        and buyers can access quality agro-products directly from the source - eliminating unnecessary middlemen.
      </p>
    </div>

    <div class="card">
      <h2>What We Offer</h2>
      <div style="display:grid; grid-template-columns:1fr 1fr; gap:16px; margin-top:12px;">
        <div style="padding:16px; background:var(--green-pale); border-radius:var(--radius);">
          <div style="font-size:1.5rem;">🧑‍🌾</div>
          <h3 style="color:var(--green-dark); margin:8px 0 4px;">For Vendors</h3>
          <p style="font-size:0.9rem; color:var(--text-light);">List and manage your agro products, set prices, track inventory, and reach buyers across Nepal.</p>
        </div>
        <div style="padding:16px; background:var(--green-pale); border-radius:var(--radius);">
          <div style="font-size:1.5rem;">🛒</div>
          <h3 style="color:var(--green-dark); margin:8px 0 4px;">For Buyers</h3>
          <p style="font-size:0.9rem; color:var(--text-light);">Browse fresh products, search by category, wishlist your favorites, and place orders easily.</p>
        </div>
        <div style="padding:16px; background:var(--green-pale); border-radius:var(--radius);">
          <div style="font-size:1.5rem;">🔐</div>
          <h3 style="color:var(--green-dark); margin:8px 0 4px;">Secure Platform</h3>
          <p style="font-size:0.9rem; color:var(--text-light);">Role-based access control and admin verification ensure a trusted marketplace environment.</p>
        </div>
        <div style="padding:16px; background:var(--green-pale); border-radius:var(--radius);">
          <div style="font-size:1.5rem;">📊</div>
          <h3 style="color:var(--green-dark); margin:8px 0 4px;">Admin Control</h3>
          <p style="font-size:0.9rem; color:var(--text-light);">Full administrative dashboard with user management, product oversight, and order tracking.</p>
        </div>
      </div>
    </div>

    <div class="card">
      <h2>Technology Stack</h2>
      <p style="color:var(--text-light); margin-top:8px; line-height:1.8;">
        EcoSprout is built using <strong>Java EE</strong> with <strong>JSP/Servlet</strong> (MVC architecture),
        <strong>MySQL</strong> for data storage, and pure <strong>HTML/CSS</strong> with Flexbox for a responsive UI.
        The system follows best practices including prepared statements to prevent SQL injection,
        SHA-256 password hashing, and session-based authentication.
      </p>
    </div>

    <div style="text-align:center; margin-top:8px;">
      <a href="contact" class="btn btn-primary">Contact Us</a>
      <a href="login"   class="btn btn-outline" style="margin-left:12px;">Get Started</a>
    </div>
  </div>
</div>
<footer>&copy; 2026 EcoSprout - <a href="contact">Contact</a></footer>
</body>
</html>
