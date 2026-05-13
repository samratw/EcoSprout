<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="About Us" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/includes/head.jsp" %>
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<div class="page">
    <div style="max-width:900px; margin:0 auto;">

        <div class="card hero-card">
            <h1>About EcoSprout</h1>
            <p>Connecting local farmers with buyers across Nepal</p>
        </div>

        <div class="card">
            <h2>Our Mission</h2>
            <p>
                EcoSprout is an online agro-product marketplace that bridges the gap
                between local farmers and consumers. We provide a transparent, fair,
                and efficient platform where vendors can list their fresh produce and
                buyers can access quality agro-products directly from the source,
                eliminating unnecessary middlemen.
            </p>
        </div>

        <div class="card">
            <h2>What We Offer</h2>
            <div class="offer-grid">
                <div class="offer-tile">
                    <div class="offer-icon">&#x1F468;&#x200D;&#x1F33E;</div>
                    <h3>For Vendors</h3>
                    <p>List and manage your agro products, set prices, track inventory,
                       and reach buyers across Nepal.</p>
                </div>
                <div class="offer-tile">
                    <div class="offer-icon">&#x1F6D2;</div>
                    <h3>For Buyers</h3>
                    <p>Browse fresh products, search by category, wishlist your
                       favorites, and place orders easily.</p>
                </div>
                <div class="offer-tile">
                    <div class="offer-icon">&#x1F510;</div>
                    <h3>Secure Platform</h3>
                    <p>Role-based access control and admin verification ensure a
                       trusted marketplace environment.</p>
                </div>
                <div class="offer-tile">
                    <div class="offer-icon">&#x1F4CA;</div>
                    <h3>Admin Control</h3>
                    <p>Full administrative dashboard with user management, product
                       oversight, and order tracking.</p>
                </div>
            </div>
        </div>

        <div class="card">
            <h2>Technology Stack</h2>
            <p>
                EcoSprout is built using <strong>Java EE</strong> with
                <strong>JSP / Servlet</strong> following the
                <strong>MVC</strong> architecture, <strong>MySQL</strong> for
                persistence, and pure <strong>HTML &amp; CSS (Flexbox)</strong>
                for a responsive UI. The codebase follows best practices
                including prepared statements to prevent SQL injection,
                SHA-256 password hashing, session-based authentication,
                JSTL/EL views (no scriptlets), and a layered MVC structure
                (controller &rarr; service &rarr; DAO &rarr; model).
            </p>
        </div>

        <div style="text-align:center; margin-top:8px;">
            <a href="${ctx}/contact" class="btn btn-primary">Contact Us</a>
            <c:if test="${empty sessionScope.user}">
                <a href="${ctx}/login" class="btn btn-outline" style="margin-left:12px;">Get Started</a>
            </c:if>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
