<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="Product Reviews" scope="request"/>
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
        <h1>Reviews</h1>
        <c:if test="${not empty product}">
            <p>What buyers think of <strong><c:out value="${product.name}"/></strong>.</p>
        </c:if>
    </div>

    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <c:choose>
        <c:when test="${empty product}">
            <div class="alert alert-error">Product not found.</div>
            <a href="${ctx}/buyer" class="btn btn-outline">Back to Products</a>
        </c:when>
        <c:otherwise>

            <div class="two-col">

                <%-- Product card summary --%>
                <div class="card">
                    <h2><c:out value="${product.name}"/></h2>
                    <p style="color:var(--text-light);">
                        Category: <c:out value="${product.category}"/>
                    </p>
                    <p>
                        Price: NPR
                        <fmt:formatNumber value="${product.price}" minFractionDigits="2" maxFractionDigits="2"/>
                        / ${product.unit}
                    </p>
                    <p>
                        Average rating:
                        <strong>
                            <fmt:formatNumber value="${product.avgRating}" minFractionDigits="1" maxFractionDigits="1"/>
                        </strong>
                        / 5 &nbsp;
                        (${product.reviewCount} review<c:if test="${product.reviewCount ne 1}">s</c:if>)
                    </p>
                    <p>
                        <a href="${ctx}/buyer" class="btn btn-outline btn-sm">Back to Products</a>
                    </p>
                </div>

                <%-- Reviews can only be posted from My Orders (after purchase) --%>
                <c:if test="${sessionScope.user.role eq 'buyer'}">
                    <div class="card">
                        <h2>Leave a Review</h2>
                        <p style="color:var(--text-light);">
                            Reviews are only accepted from buyers who have purchased the product.
                            Open <a href="${ctx}/myorders">My Orders</a> to review any item you
                            have already ordered.
                        </p>
                    </div>
                </c:if>
            </div>

            <%-- Existing reviews --%>
            <div class="card">
                <h2>All Reviews</h2>

                <c:choose>
                    <c:when test="${empty reviews}">
                        <p style="color:var(--text-light);">
                            No reviews yet. Be the first to share your thoughts.
                        </p>
                    </c:when>
                    <c:otherwise>
                        <ul class="review-list">
                            <c:forEach var="r" items="${reviews}">
                                <li class="review-item">
                                    <div class="review-head">
                                        <strong><c:out value="${r.buyerName}"/></strong>
                                        <span class="review-stars">
                                            <c:forEach var="i" begin="1" end="5">
                                                <c:choose>
                                                    <c:when test="${i le r.rating}">
                                                        <span class="star filled">&#9733;</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="star">&#9734;</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            (${r.rating}/5)
                                        </span>
                                        <span class="review-date">
                                            <c:if test="${not empty r.createdAt}">
                                                &ndash; ${fn:substring(r.createdAt, 0, 10)}
                                            </c:if>
                                        </span>
                                    </div>
                                    <p><c:out value="${r.comment}"/></p>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </div>

        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
