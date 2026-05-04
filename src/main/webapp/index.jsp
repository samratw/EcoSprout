<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Home - EcoSprout</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

<style>

/* HERO SECTION */
.hero {
	height: 80vh;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
	padding: 20px;
	/* BACKGROUND IMAGE */
	background: linear-gradient(rgba(45, 106, 79, 0.5),
		rgba(64, 145, 108, 0.5)),
		url("${pageContext.request.contextPath}/images/home.jpg");
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	color: white;
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
}

.hero h1 {
	font-size: 48px;
	margin-bottom: 10px;
}

.hero p {
	font-size: 18px;
	max-width: 600px;
	opacity: 0.9;
}

.hero .btn {
	margin-top: 20px;
	padding: 12px 24px;
	background: white;
	color: #2d6a4f;
	border: none;
	border-radius: 25px;
	cursor: pointer;
	font-weight: bold;
	text-decoration: none;
}

/* FEATURES */
.features {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 20px;
	padding: 50px;
}

.card {
	background: white;
	padding: 20px;
	border-radius: 12px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.card h3 {
	color: #2d6a4f;
}

/* FOOTER */
.footer {
	text-align: center;
	padding: 20px;
	background: #1b4332;
	color: white;
	margin-top: 20px;
}
</style>
</head>

<body>
	<!-- HERO -->
	<div class="hero">
		<h1>Welcome to</h1>
		<img src="${pageContext.request.contextPath}/images/logo.png"
			width="400" height="100" />
		<p>Grow smarter with sustainable agricultural solutions, modern
			tools, and eco-friendly innovation built for the future.</p>

		<a class="btn" href="<%=request.getContextPath()%>/register">
			Register To Explore Products </a>
	</div>

	<!-- FEATURES -->
	<div class="features">
		<div class="card">
			<h3>🌿 Organic Farming</h3>
			<p>High-quality eco-friendly farming products for better yield.</p>
		</div>

		<div class="card">
			<h3>🚀 Smart Tools</h3>
			<p>Modern tools that help farmers increase productivity easily.</p>
		</div>

		<div class="card">
			<h3>💧 Sustainable Growth</h3>
			<p>Focused on long-term environmental balance and success.</p>
		</div>
	</div>

	<div
		style="padding: 60px 20px; background: #f4f7f5; text-align: center;">

		<h2 style="color: #2d6a4f; font-size: 32px; margin-bottom: 15px;">
			Our Mission</h2>

		<p
			style="max-width: 900px; margin: auto; font-size: 17px; color: #333; line-height: 1.6;">
			EcoSprout is an online agro-product marketplace that bridges the gap
			between local farmers and consumers. We provide a transparent, fair,
			and efficient platform where vendors can list their fresh produce and
			buyers can access quality agro-products directly from the source -
			eliminating unnecessary middlemen.</p>

		<h2 style="color: #2d6a4f; font-size: 28px; margin-top: 40px;">
			What We Offer</h2>

		<div
			style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-top: 30px;">

			<div
				style="background: white; padding: 20px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);">
				<h3>🧑‍🌾 For Vendors</h3>
				<p>List and manage your agro products, set prices, track
					inventory, and reach buyers across Nepal.</p>
			</div>

			<div
				style="background: white; padding: 20px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);">
				<h3>🛒 For Buyers</h3>
				<p>Browse fresh products, search by category, wishlist your
					favorites, and place orders easily.</p>
			</div>

			<div
				style="background: white; padding: 20px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);">
				<h3>🔐 Secure Platform</h3>
				<p>Role-based access control and admin verification ensure a
					trusted marketplace environment.</p>
			</div>

			<div
				style="background: white; padding: 20px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);">
				<h3>📊 Admin Control</h3>
				<p>Full administrative dashboard with user management, product
					oversight, and order tracking.</p>
			</div>

		</div>

	</div>

	<!-- FOOTER -->
	<div class="footer">© 2026 EcoSprout. All rights reserved.</div>
</body>
</html>