<%@ page contentType="text/html;charset=UTF-8" import="com.ecosprout.model.ProductModel,java.util.*" session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Browse Products - EcoSprout</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav class="navbar">
  <img src="${pageContext.request.contextPath}/images/logo.png" width="250" height="65" />
  <nav>
    <a href="buyer">Browse</a>
    <a href="about">About</a>
    <a href="contact">Contact</a>
    <a href="logout" class="logout">Logout</a>
  </nav>
</nav>

<div class="page">
  <div class="page-header">
    <h1>Browse Agro Products</h1>
    <p>Welcome, <strong>${sessionScope.user.name}</strong> - discover fresh products from local vendors.</p>
  </div>

  <%
    String orderSuccess = (String) session.getAttribute("orderSuccess");
    String orderError   = (String) session.getAttribute("orderError");
    if (orderSuccess != null) { session.removeAttribute("orderSuccess"); }
    if (orderError   != null) { session.removeAttribute("orderError");   }
    String searchError = (String) request.getAttribute("error");
  %>
  <% if (orderSuccess != null) { %><div class="alert alert-success"><%= orderSuccess %></div><% } %>
  <% if (orderError   != null) { %><div class="alert alert-error">  <%= orderError   %></div><% } %>
  <% if (searchError  != null) { %><div class="alert alert-error">  <%= searchError  %></div><% } %>

  <!-- Wishlist indicator -->
  <%
    Set<Integer> wishlist = (Set<Integer>) session.getAttribute("wishlist");
    if (wishlist == null) { wishlist = new HashSet<>(); session.setAttribute("wishlist", wishlist); }
    int wishCount = wishlist.size();
  %>
  <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px; flex-wrap:wrap; gap:10px;">
    <span style="color:var(--text-light);">❤️ Wishlist: <strong><%= wishCount %> item(s)</strong></span>
    <a href="buyer?showWishlist=1" class="btn btn-outline btn-sm">View Wishlist</a>
  </div>

  <!-- Search Bar -->
  <form action="buyer" method="get" class="search-bar">
    <input type="text" name="search" placeholder="Search by product name or category..."
           value="${param.search}">
    <button type="submit" class="btn btn-primary">Search</button>
    <% if (request.getParameter("search") != null && !request.getParameter("search").isEmpty()) { %>
      <a href="buyer" class="btn btn-outline">Clear</a>
    <% } %>
  </form>

  <%
    // Show wishlist filtered view
    boolean showWishlist = "1".equals(request.getParameter("showWishlist"));
    List<ProductModel> allProducts = (List<ProductModel>) request.getAttribute("products");
    List<ProductModel> displayProducts = new ArrayList<>();

    if (allProducts != null) {
      for (ProductModel p : allProducts) {
        if (!showWishlist || wishlist.contains(p.getId())) {
          displayProducts.add(p);
        }
      }
    }

    if (showWishlist) {
  %><div class="alert alert-info">Showing your wishlist (<%= displayProducts.size() %> items). <a href="buyer">Browse all products</a></div><% } %>

  <% if (displayProducts.isEmpty()) { %>
  <div class="card" style="text-align:center; padding:40px;">
    <p style="font-size:1.2rem; color:var(--text-light);">🌾 No products found.</p>
    <% if (showWishlist) { %><p>Your wishlist is empty. <a href="buyer">Browse products</a></p><% } %>
  </div>
  <% } else { %>
  <div class="product-grid">
    <% for (ProductModel p : displayProducts) {
         boolean inWishlist = wishlist.contains(p.getId()); %>
    <div class="product-card">
      <% if (p.getImage() != null) { %>
        <img src="${pageContext.request.contextPath}/images/<%= p.getImage() %>" alt="<%= p.getName() %>">
      <% } else { %>
        <div style="height:160px;background:var(--green-light);display:flex;align-items:center;justify-content:center;font-size:2.5rem;">🌾</div>
      <% } %>
      <div class="pc-body">
        <div style="display:flex;justify-content:space-between;align-items:start;">
          <div class="pc-name"><%= p.getName() %></div>
          <form action="wishlist" method="post" style="margin:0;">
            <input type="hidden" name="productId" value="<%= p.getId() %>">
            <button type="submit" class="wishlist-btn <%= inWishlist ? "active" : "" %>"
                    title="<%= inWishlist ? "Remove from wishlist" : "Add to wishlist" %>">
              <%= inWishlist ? "❤️" : "🤍" %>
            </button>
          </form>
        </div>
        <div class="pc-cat"><%= p.getCategory() %></div>
        <div class="pc-price">NPR <%= String.format("%.2f", p.getPrice()) %> / <%= p.getUnit() %></div>
        <div class="pc-qty">Available: <%= p.getQuantity() %> <%= p.getUnit() %></div>
        <% if (p.getDescription() != null && !p.getDescription().isEmpty()) { %>
          <p style="font-size:0.82rem;color:var(--text-light);margin-top:6px;"><%= p.getDescription().length() > 60 ? p.getDescription().substring(0,60)+"..." : p.getDescription() %></p>
        <% } %>
      </div>
      <% if (p.getQuantity() > 0) { %>
      <div style="padding:0 14px 14px;">
        <form action="placeorder" method="post" style="display:flex;gap:8px;align-items:center;">
          <input type="hidden" name="productId" value="<%= p.getId() %>">
          <input type="number" name="quantity" min="1" max="<%= p.getQuantity() %>" value="1"
                 style="width:70px;padding:6px;border:1px solid var(--border);border-radius:6px;font-size:0.9rem;">
          <button type="submit" class="btn btn-primary btn-sm">Order</button>
        </form>
      </div>
      <% } else { %>
      <div style="padding:0 14px 14px;"><span class="badge badge-rejected">Out of Stock</span></div>
      <% } %>
    </div>
    <% } %>
  </div>
  <% } %>
</div>
<footer>&copy; 2026 EcoSprout | <a href="about">About</a> | <a href="contact">Contact</a></footer>
</body>
</html>
