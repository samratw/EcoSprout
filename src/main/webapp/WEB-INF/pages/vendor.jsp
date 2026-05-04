<%@ page contentType="text/html;charset=UTF-8"
	import="com.ecosprout.model.ProductModel,java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Vendor Dashboard - EcoSprout</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<nav class="navbar">
		<img src="${pageContext.request.contextPath}/images/logo.png" width="250" height="65" />
		<nav>
			<a href="vendor">My Dashboard</a> <a href="addproduct">Add
				Product</a> <a href="about">About</a> <a href="contact">Contact</a> <a
				href="logout" class="logout">Logout</a>
		</nav>
	</nav>

	<div class="page">
		<div class="page-header">
			<h1>Vendor Dashboard</h1>
			<p>
				Hello, <strong>${sessionScope.user.name}</strong> - manage your agro
				product listings.
			</p>
		</div>

		<%
		String error = (String) request.getAttribute("error");
		if (error != null) {
		%><div class="alert alert-error"><%=error%></div>
		<%
		}
		%>

		<div style="margin-bottom: 20px;">
			<a href="addproduct" class="btn btn-primary">➕ Add New Product</a>
		</div>

		<%
		List<ProductModel> products = (List<ProductModel>) request.getAttribute("products");
		if (products == null || products.isEmpty()) {
		%>
		<div class="card" style="text-align: center; padding: 40px;">
			<p style="color: var(--text-light); font-size: 1.1rem;">You
				haven't listed any products yet.</p>
			<a href="addproduct" class="btn btn-primary"
				style="margin-top: 16px;">Add Your First Product</a>
		</div>
		<%
		} else {
		%>
		<div class="product-grid">
			<%
			for (ProductModel p : products) {
			%>
			<div class="product-card">
				<%
				if (p.getImage() != null) {
				%>
				<img
					src="${pageContext.request.contextPath}/images/<%= p.getImage() %>"
					alt="<%= p.getName() %>">
				<%
				} else {
				%>
				<div
					style="height: 160px; background: var(--green-light); display: flex; align-items: center; justify-content: center; font-size: 2.5rem;">🌾</div>
				<%
				}
				%>
				<div class="pc-body">
					<div class="pc-name"><%=p.getName()%></div>
					<div class="pc-cat"><%=p.getCategory()%></div>
					<div class="pc-price">
						NPR
						<%=String.format("%.2f", p.getPrice())%>
						/
						<%=p.getUnit()%></div>
					<div class="pc-qty">
						Stock:
						<%=p.getQuantity()%>
						<%=p.getUnit()%></div>
					<span class="badge badge-<%=p.getStatus()%>"
						style="margin-top: 6px;"><%=p.getStatus()%></span>
				</div>
				<div class="pc-actions">
					<a href="updateproduct?id=<%=p.getId()%>"
						class="btn btn-warning btn-sm">Edit</a> <a
						href="deleteproduct?id=<%=p.getId()%>"
						class="btn btn-danger btn-sm"
						onclick="return confirm('Delete this product?')">Delete</a>
				</div>
			</div>
			<%
			}
			%>
		</div>
		<%
		}
		%>
	</div>
	<footer>
		&copy; 2026 EcoSprout | <a href="about">About</a> | <a href="contact">Contact</a>
	</footer>
</body>
</html>
