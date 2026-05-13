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

<%-- Hero Section --%>
<section class="hero" style="background:linear-gradient(rgba(45,106,79,0.55),rgba(64,145,108,0.55)),url('${ctx}/images/home.jpg') center/cover no-repeat;">
    <h1>Welcome to</h1>
    <img src="${ctx}/images/logo.png" width="400" height="100" alt="EcoSprout">
    <p>Grow smarter with sustainable agricultural solutions, modern tools,
       and eco-friendly innovation built for the future.</p>

    <c:choose>
        <c:when test="${empty sessionScope.user}">
            <a class="btn btn-light" href="${ctx}/register">Register To Explore Products</a>
        </c:when>
        <c:when test="${sessionScope.user.role eq 'buyer'}">
            <a class="btn btn-light" href="${ctx}/buyer">Browse Products</a>
        </c:when>
        <c:when test="${sessionScope.user.role eq 'vendor'}">
            <a class="btn btn-light" href="${ctx}/vendor">Vendor Dashboard</a>
        </c:when>
        <c:when test="${sessionScope.user.role eq 'admin'}">
            <a class="btn btn-light" href="${ctx}/admin">Admin Dashboard</a>
        </c:when>
    </c:choose>
</section>

<%-- Features --%>
<section class="features">
    <div class="card">
        <h3>Organic Farming</h3>
        <p>High-quality eco-friendly farming products for better yield.</p>
    </div>
    <div class="card">
        <h3>Smart Tools</h3>
        <p>Modern tools that help farmers increase productivity easily.</p>
    </div>
    <div class="card">
        <h3>Sustainable Growth</h3>
        <p>Focused on long-term environmental balance and success.</p>
    </div>
</section>

<%-- Mission band --%>
<section class="mission-band">
    <h2>Our Mission</h2>
    <p>
        EcoSprout is an online agro-product marketplace that bridges the gap
        between local farmers and consumers. We provide a transparent, fair,
        and efficient platform where vendors can list their fresh produce and
        buyers can access quality agro-products directly from the source &mdash;
        eliminating unnecessary middlemen.
    </p>

    <h2>What We Offer</h2>
    <div class="offer-grid">
        <div class="card">
            <h3>For Vendors</h3>
            <p>List and manage your agro products, set prices, track inventory,
               and reach buyers across Nepal.</p>
        </div>
        <div class="card">
            <h3>For Buyers</h3>
            <p>Browse fresh products, search by category, wishlist your
               favorites, and place orders easily.</p>
        </div>
        <div class="card">
            <h3>Secure Platform</h3>
            <p>Role-based access control and admin verification ensure a
               trusted marketplace environment.</p>
        </div>
        <div class="card">
            <h3>Admin Control</h3>
            <p>Full administrative dashboard with user management, product
               oversight, and order tracking.</p>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
