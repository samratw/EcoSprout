<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="Products" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/includes/head.jsp" %>
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<div class="page">
    <div class="page-header">
        <h1>Browse Our Products</h1>
        <p>Fresh agro products from local vendors across Nepal.
           <c:if test="${empty sessionScope.user}">
               <a href="${ctx}/login">Log in</a> or
               <a href="${ctx}/register">register</a> to place an order.
           </c:if>
        </p>
    </div>

    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <%-- Search Bar --%>
    <form action="${ctx}/products" method="get" class="search-bar">
        <input type="text" name="search"
               placeholder="Search by product name or category..."
               value="${param.search}">
        <button type="submit" class="btn btn-primary">Search</button>
        <c:if test="${not empty param.search}">
            <a href="${ctx}/products" class="btn btn-outline">Clear</a>
        </c:if>
    </form>

    <c:choose>
        <c:when test="${empty products}">
            <div class="card center" style="padding:40px;">
                <p style="font-size:1.2rem; color:var(--text-light);">No products found.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="product-grid">
                <c:forEach var="p" items="${products}">
                    <div class="product-card">

                        <a href="${ctx}/product?id=${p.id}" class="pc-img-link">
                            <c:choose>
                                <c:when test="${not empty p.image}">
                                    <img src="${ctx}/images/${p.image}" alt="${p.name}">
                                </c:when>
                                <c:otherwise>
                                    <div class="product-placeholder">No image</div>
                                </c:otherwise>
                            </c:choose>
                        </a>

                        <div class="pc-body">
                            <a href="${ctx}/product?id=${p.id}" class="pc-name-link">
                                <div class="pc-name"><c:out value="${p.name}"/></div>
                            </a>
                            <div class="pc-cat"><c:out value="${p.category}"/></div>
                            <div class="pc-price">
                                NPR
                                <fmt:formatNumber value="${p.price}" minFractionDigits="2" maxFractionDigits="2"/>
                                / ${p.unit}
                            </div>
                            <div class="pc-qty">
                                Available: ${p.quantity} ${p.unit}
                            </div>

                            <div class="pc-rating">
                                <span class="stars">
                                    <c:forEach var="i" begin="1" end="5">
                                        <c:choose>
                                            <c:when test="${i le p.avgRating}">
                                                <span class="star filled">&#9733;</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="star">&#9734;</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </span>
                                <strong>
                                    <fmt:formatNumber value="${p.avgRating}" minFractionDigits="1" maxFractionDigits="1"/>
                                </strong>
                                &ndash;
                                <a href="${ctx}/product?id=${p.id}">
                                    ${p.reviewCount} review<c:if test="${p.reviewCount ne 1}">s</c:if>
                                </a>
                            </div>
                        </div>

                        <%-- Guests must log in before ordering --%>
                        <div style="padding:0 14px 14px;">
                            <a href="${ctx}/login" class="btn btn-primary btn-sm btn-full">
                                Login to Order
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
