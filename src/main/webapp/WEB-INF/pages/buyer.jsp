<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="Browse Products" scope="request"/>
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
        <h1>Browse Agro Products</h1>
        <p>Welcome, <strong>${sessionScope.user.name}</strong> &ndash;
           discover fresh products from local vendors.</p>
    </div>

    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <%-- Wishlist indicator --%>
    <div class="row-between" style="margin-bottom:16px;">
        <span style="color:var(--text-light);">
            <span class="heart filled">&hearts;</span>
            Wishlist: <strong>${wishCount} item(s)</strong>
        </span>
        <a href="${ctx}/buyer?showWishlist=1" class="btn btn-outline btn-sm">View Wishlist</a>
    </div>

    <%-- Search Bar --%>
    <form action="${ctx}/buyer" method="get" class="search-bar">
        <input type="text" name="search"
               placeholder="Search by product name or category..."
               value="${param.search}">
        <button type="submit" class="btn btn-primary">Search</button>
        <c:if test="${not empty param.search}">
            <a href="${ctx}/buyer" class="btn btn-outline">Clear</a>
        </c:if>
    </form>

    <%-- Wishlist-filtered view notice --%>
    <c:if test="${showWishlist}">
        <div class="alert alert-info">
            Showing your wishlist (<c:out value="${fn:length(products)}"/> items).
            <a href="${ctx}/buyer">Browse all products</a>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty products}">
            <div class="card center" style="padding:40px;">
                <p style="font-size:1.2rem; color:var(--text-light);">No products found.</p>
                <c:if test="${showWishlist}">
                    <p>Your wishlist is empty.
                        <a href="${ctx}/buyer">Browse products</a></p>
                </c:if>
            </div>
        </c:when>
        <c:otherwise>
            <div class="product-grid">
                <c:forEach var="p" items="${products}">

                    <c:set var="inWishlist" value="${not empty wishlistMap and wishlistMap[p.id]}"/>

                    <div class="product-card">

                        <%-- Image links to product detail page --%>
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
                            <div class="row-between">
                                <%-- Name links to product detail page --%>
                                <a href="${ctx}/product?id=${p.id}" class="pc-name-link">
                                    <div class="pc-name"><c:out value="${p.name}"/></div>
                                </a>

                                <%-- Heart icon toggles wishlist --%>
                                <form action="${ctx}/wishlist" method="post" style="margin:0;">
                                    <input type="hidden" name="productId" value="${p.id}">
                                    <button type="submit"
                                            class="wishlist-btn ${inWishlist ? 'active' : ''}"
                                            title="${inWishlist ? 'Remove from wishlist' : 'Add to wishlist'}">
                                        <c:choose>
                                            <c:when test="${inWishlist}">
                                                <span class="heart filled">&hearts;</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="heart">&hearts;</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </button>
                                </form>
                            </div>

                            <div class="pc-cat"><c:out value="${p.category}"/></div>
                            <div class="pc-price">
                                NPR
                                <fmt:formatNumber value="${p.price}" minFractionDigits="2" maxFractionDigits="2"/>
                                / ${p.unit}
                            </div>
                            <div class="pc-qty">
                                Available: ${p.quantity} ${p.unit}
                            </div>

                            <%-- Star rating --%>
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
                                <a href="${ctx}/reviews?productId=${p.id}">
                                    ${p.reviewCount} review<c:if test="${p.reviewCount ne 1}">s</c:if>
                                </a>
                            </div>

                            <c:if test="${not empty p.description}">
                                <p class="pc-desc">
                                    <c:choose>
                                        <c:when test="${fn:length(p.description) gt 60}">
                                            <c:out value="${fn:substring(p.description, 0, 60)}"/>...
                                        </c:when>
                                        <c:otherwise>
                                            <c:out value="${p.description}"/>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </c:if>
                        </div>

                        <%-- Order section: button opens dialog --%>
                        <c:choose>
                            <c:when test="${p.quantity gt 0}">
                                <div style="padding:0 14px 14px;">
                                    <button type="button" class="btn btn-primary btn-sm btn-full"
                                            onclick="document.getElementById('dlg-${p.id}').showModal()">
                                        Order Now
                                    </button>
                                </div>

                                <%-- Per-product order dialog --%>
                                <dialog id="dlg-${p.id}" class="order-dialog">
                                    <form action="${ctx}/placeorder" method="post">
                                        <h2>Place Order</h2>
                                        <p>You are ordering
                                            <strong><c:out value="${p.name}"/></strong>.</p>

                                        <input type="hidden" name="productId" value="${p.id}">

                                        <div class="form-group">
                                            <label for="qty-${p.id}">Quantity *</label>
                                            <input type="number" id="qty-${p.id}" name="quantity"
                                                   min="1" max="${p.quantity}" value="1" required>
                                            <small style="color:var(--text-light);">
                                                Up to ${p.quantity} ${p.unit} available
                                            </small>
                                        </div>

                                        <div class="form-group">
                                            <label for="loc-${p.id}">Delivery Location *</label>
                                            <textarea id="loc-${p.id}" name="deliveryLocation" rows="3"
                                                      placeholder="Street, ward, city, landmark..." required></textarea>
                                        </div>

                                        <div class="dialog-actions">
                                            <button type="button" class="btn btn-outline"
                                                    onclick="document.getElementById('dlg-${p.id}').close()">
                                                Cancel
                                            </button>
                                            <button type="submit" class="btn btn-primary">
                                                Confirm Order
                                            </button>
                                        </div>
                                    </form>
                                </dialog>
                            </c:when>
                            <c:otherwise>
                                <div style="padding:0 14px 14px;">
                                    <span class="badge badge-rejected">Out of Stock</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
