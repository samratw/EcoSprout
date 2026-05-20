<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>

<c:set var="pageTitle" value="Home" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/includes/head.jsp" %>
</head>

<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<!-- =========================================================
     HERO SECTION
========================================================= -->
<section class="hero"
style="
background:
linear-gradient(rgba(22,56,35,0.70),rgba(45,106,79,0.65)),
url('${ctx}/images/farm-bg.jpg') center/cover no-repeat;
">

    <div class="hero-content">
        <span class="hero-badge">🌱 Nepal's Smart Agro Marketplace</span>

        <h1>
            Fresh From Farms <br>
            Directly To Your Home
        </h1>

        <p>
            Buy fresh vegetables, organic fruits, seeds, fertilizers,
            and farming tools from trusted local farmers and vendors.
            Sustainable farming for a healthier tomorrow.
        </p>

        <div class="hero-buttons">

            <c:choose>

                <c:when test="${empty sessionScope.user}">
                    <a class="btn btn-light" href="${ctx}/register">
                        Explore Marketplace
                    </a>

                    <a class="btn btn-outline-light" href="${ctx}/login">
                        Login
                    </a>
                </c:when>

                <c:when test="${sessionScope.user.role eq 'buyer'}">
                    <a class="btn btn-light" href="${ctx}/buyer">
                        Shop Products
                    </a>
                </c:when>

                <c:when test="${sessionScope.user.role eq 'vendor'}">
                    <a class="btn btn-light" href="${ctx}/vendor">
                        Vendor Dashboard
                    </a>
                </c:when>

                <c:when test="${sessionScope.user.role eq 'admin'}">
                    <a class="btn btn-light" href="${ctx}/admin">
                        Admin Dashboard
                    </a>
                </c:when>

            </c:choose>

        </div>

    </div>
</section>

<!-- =========================================================
     TRUST / STATS SECTION
========================================================= -->
<section class="stats-section">

    <div class="stat-box">
        <h2>500+</h2>
        <p>Organic Products</p>
    </div>

    <div class="stat-box">
        <h2>120+</h2>
        <p>Trusted Farmers</p>
    </div>

    <div class="stat-box">
        <h2>10k+</h2>
        <p>Happy Customers</p>
    </div>

    <div class="stat-box">
        <h2>24/7</h2>
        <p>Customer Support</p>
    </div>

</section>

<!-- =========================================================
     FEATURED CATEGORIES
========================================================= -->
<section class="home-section">

    <div class="section-title">
        <h2>Featured Categories</h2>
        <p>Fresh and eco-friendly agricultural products</p>
    </div>

    <div class="category-grid">

        <div class="category-card">
            <img src="${ctx}/images/vegetables.jpg" alt="Vegetables">

            <div class="category-overlay">
                <h3>Fresh Vegetables</h3>
                <p>Farm fresh seasonal vegetables directly from growers.</p>
            </div>
        </div>

        <div class="category-card">
            <img src="${ctx}/images/fruits.jpg" alt="Fruits">

            <div class="category-overlay">
                <h3>Organic Fruits</h3>
                <p>Naturally grown healthy and fresh fruits.</p>
            </div>
        </div>

        <div class="category-card">
            <img src="${ctx}/images/seeds.jpg" alt="Seeds">

            <div class="category-overlay">
                <h3>Premium Seeds</h3>
                <p>High quality seeds for better farming productivity.</p>
            </div>
        </div>

        <div class="category-card">
            <img src="${ctx}/images/tools.jpg" alt="Tools">

            <div class="category-overlay">
                <h3>Farming Tools</h3>
                <p>Modern tools for smart and sustainable agriculture.</p>
            </div>
        </div>

    </div>

</section>

<!-- =========================================================
     WHY CHOOSE US
========================================================= -->
<section class="why-us">

    <div class="section-title light">
        <h2>Why Choose EcoSprout?</h2>
        <p>Modern farming solutions with trusted quality</p>
    </div>

    <div class="why-grid">

        <div class="why-card">
            <div class="why-icon">🌿</div>
            <h3>100% Organic</h3>
            <p>
                Eco-friendly and healthy products directly sourced from farms.
            </p>
        </div>

        <div class="why-card">
            <div class="why-icon">🚚</div>
            <h3>Fast Delivery</h3>
            <p>
                Quick and reliable delivery service across Nepal.
            </p>
        </div>

        <div class="why-card">
            <div class="why-icon">🔒</div>
            <h3>Secure Platform</h3>
            <p>
                Safe transactions and verified vendors for trusted shopping.
            </p>
        </div>

        <div class="why-card">
            <div class="why-icon">💚</div>
            <h3>Support Farmers</h3>
            <p>
                Empowering local farmers and sustainable agricultural growth.
            </p>
        </div>

    </div>

</section>

<!-- =========================================================
     BANNER SECTION
========================================================= -->
<section class="banner-section">

    <div class="banner-content">

        <div class="banner-text">
            <span>Fresh Harvest 2026</span>

            <h2>
                Healthy Food Starts With
                Healthy Farming
            </h2>

            <p>
                Join thousands of customers who trust EcoSprout for
                quality agro-products and sustainable farming solutions.
            </p>

            <a href="${ctx}/products" class="btn btn-success">
                Shop Now
            </a>
        </div>

        <div class="banner-image">
            <img src="${ctx}/images/farmer.png" alt="Farmer">
        </div>

    </div>

</section>

<!-- =========================================================
     GALLERY SECTION
========================================================= -->
<section class="gallery-section">

    <div class="section-title">
        <h2>Farm Life Gallery</h2>
        <p>Beautiful moments from sustainable farming</p>
    </div>

    <div class="gallery-grid">

        <img src="${ctx}/images/gallery1.jpg" alt="">
        <img src="${ctx}/images/gallery2.jpg" alt="">
        <img src="${ctx}/images/gallery3.jpg" alt="">
        <img src="${ctx}/images/gallery4.jpg" alt="">
        <img src="${ctx}/images/gallery5.jpg" alt="">
        <img src="${ctx}/images/gallery6.jpg" alt="">

    </div>

</section>

<!-- =========================================================
     CTA SECTION
========================================================= -->
<section class="cta-section">

    <h2>Start Growing With EcoSprout Today</h2>

    <p>
        Discover fresh products, trusted farmers, and sustainable farming solutions.
    </p>

    <a href="${ctx}/register" class="btn btn-light">
        Join EcoSprout
    </a>

</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>