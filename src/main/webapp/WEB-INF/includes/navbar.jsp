<%-- Role-aware top navigation bar. --%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="role" value="${sessionScope.user.role}" />

<nav class="navbar">

	<%-- Brand --%>
	<c:choose>
		<c:when test="${role eq 'admin'}">
			<a href="${ctx}/admin" class="brand-link"> <img
				src="${ctx}/images/logo.png" width="220" height="58" alt="EcoSprout">
			</a>
		</c:when>
		<c:when test="${role eq 'vendor'}">
			<a href="${ctx}/vendor" class="brand-link"> <img
				src="${ctx}/images/logo.png" width="220" height="58" alt="EcoSprout">
			</a>
		</c:when>
		<c:when test="${role eq 'buyer'}">
			<a href="${ctx}/buyer" class="brand-link"> <img
				src="${ctx}/images/logo.png" width="220" height="58" alt="EcoSprout">
			</a>
		</c:when>
		<c:otherwise>
			<a href="${ctx}/" class="brand-link"> <img
				src="${ctx}/images/logo.png" width="220" height="58" alt="EcoSprout">
			</a>
		</c:otherwise>
	</c:choose>

	<%-- Role-specific links --%>
	<div class="nav-links">
		<c:choose>
			<c:when test="${role eq 'admin'}">
				<a href="${ctx}/admin">Dashboard</a>
				<a href="${ctx}/viewproducts">Products</a>
				<a href="${ctx}/manageusers">Users</a>
				<a href="${ctx}/reports">Reports</a>
				<a href="${ctx}/profile">Profile</a>
				<a href="${ctx}/about">About</a>
				<a href="${ctx}/contact">Contact</a>
				<a href="${ctx}/logout" class="logout">Logout</a>
			</c:when>
			<c:when test="${role eq 'vendor'}">
				<a href="${ctx}/vendor">Dashboard</a>
				<a href="${ctx}/addproduct">Add Product</a>
				<a href="${ctx}/vendororders">Orders</a>
				<a href="${ctx}/profile">Profile</a>
				<a href="${ctx}/about">About</a>
				<a href="${ctx}/contact">Contact</a>
				<a href="${ctx}/logout" class="logout">Logout</a>
			</c:when>
			<c:when test="${role eq 'buyer'}">
				<a href="${ctx}/buyer">Browse</a>
				<a href="${ctx}/myorders"> <img src="${ctx}/images/cart.png"
					alt="Cart" width="20" height="20"> My Orders
				</a>
				<a href="${ctx}/profile">Profile</a>
				<a href="${ctx}/about">About</a>
				<a href="${ctx}/contact">Contact</a>
				<a href="${ctx}/logout" class="logout">Logout</a>
			</c:when>
			<c:otherwise>
				<a href="${ctx}/">Home</a>
				<a href="${ctx}/about">About</a>
				<a href="${ctx}/contact">Contact</a>
				<a href="${ctx}/login">Login</a>
			</c:otherwise>
		</c:choose>
	</div>
</nav>
