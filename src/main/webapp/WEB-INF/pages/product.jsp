<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="${not empty product ? product.name : 'Product'}" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/includes/head.jsp" %>
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<div class="page">

    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <c:choose>
        <c:when test="${empty product}">
            <div class="alert alert-error">Product not found.</div>
            <a href="${ctx}/buyer" class="btn btn-outline">Back to Products</a>
        </c:when>
        <c:otherwise>

            <%-- Hero: image + summary --%>
            <div class="product-detail">
                <div class="pd-image">
                    <c:choose>
                        <c:when test="${not empty product.image}">
                            <img src="${ctx}/images/${product.image}" alt="${product.name}">
                        </c:when>
                        <c:otherwise>
                            <div class="product-placeholder">No image</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="pd-info">
                    <h1><c:out value="${product.name}"/></h1>
                    <p class="pd-cat"><c:out value="${product.category}"/></p>

                    <p class="pd-price">
                        NPR
                        <fmt:formatNumber value="${product.price}" minFractionDigits="2" maxFractionDigits="2"/>
                        <span class="pd-unit">&ndash; per ${product.unit}</span>
                    </p>

                    <p class="pd-rating">
                        <c:forEach var="i" begin="1" end="5">
                            <c:choose>
                                <c:when test="${i le product.avgRating}">
                                    <span class="star filled">&#9733;</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="star">&#9734;</span>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <strong>
                            <fmt:formatNumber value="${product.avgRating}" minFractionDigits="1" maxFractionDigits="1"/>
                        </strong>
                        / 5 &ndash; ${product.reviewCount} review<c:if test="${product.reviewCount ne 1}">s</c:if>
                    </p>

                    <p class="pd-stock">
                        <c:choose>
                            <c:when test="${product.quantity gt 0}">
                                <strong>Available:</strong> ${product.quantity} ${product.unit}
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-rejected">Out of Stock</span>
                            </c:otherwise>
                        </c:choose>
                    </p>

                    <c:if test="${not empty product.description}">
                        <h3>Description</h3>
                        <p><c:out value="${product.description}"/></p>
                    </c:if>

                    <%-- Buyer action buttons --%>
                    <c:if test="${sessionScope.user.role eq 'buyer'}">
                        <div class="pd-actions">

                            <%-- Wishlist toggle --%>
                            <form action="${ctx}/wishlist" method="post" style="display:inline;">
                                <input type="hidden" name="productId" value="${product.id}">
                                <button type="submit" class="btn btn-outline ${inWishlist ? 'active' : ''}">
                                    <c:choose>
                                        <c:when test="${inWishlist}">
                                            <span class="heart filled">&hearts;</span> Saved
                                        </c:when>
                                        <c:otherwise>
                                            <span class="heart">&hearts;</span> Add to Wishlist
                                        </c:otherwise>
                                    </c:choose>
                                </button>
                            </form>

                            <%-- Order button opens the dialog --%>
                            <c:if test="${product.quantity gt 0}">
                                <button type="button" class="btn btn-primary"
                                        onclick="document.getElementById('orderDialog').showModal()">
                                    Order Now
                                </button>
                            </c:if>
                        </div>
                    </c:if>

                    <%-- Guests: prompt to log in before ordering --%>
                    <c:if test="${empty sessionScope.user}">
                        <div class="pd-actions">
                            <a href="${ctx}/login" class="btn btn-primary">Login to Order</a>
                            <a href="${ctx}/register" class="btn btn-outline">Register</a>
                        </div>
                    </c:if>
                </div>
            </div>

            <%-- Order dialog (popup) --%>
            <c:if test="${sessionScope.user.role eq 'buyer' and product.quantity gt 0}">
                <dialog id="orderDialog" class="order-dialog">
                    <form action="${ctx}/placeorder" method="post">
                        <h2>Place Order</h2>
                        <p>You are ordering <strong><c:out value="${product.name}"/></strong>.</p>

                        <input type="hidden" name="productId" value="${product.id}">

                        <div class="form-group">
                            <label for="dlg-qty">Quantity *</label>
                            <input type="number" id="dlg-qty" name="quantity"
                                   min="1" max="${product.quantity}" value="1" required>
                            <small style="color:var(--text-light);">
                                Up to ${product.quantity} ${product.unit} available
                            </small>
                        </div>

                        <div class="form-group">
                            <label for="dlg-loc">Delivery Location *</label>
                            <textarea id="dlg-loc" name="deliveryLocation" rows="3"
                                      placeholder="Street, ward, city, landmark..." required></textarea>
                        </div>

                        <div class="dialog-actions">
                            <button type="button" class="btn btn-outline"
                                    onclick="document.getElementById('orderDialog').close()">
                                Cancel
                            </button>
                            <button type="submit" class="btn btn-primary">Confirm Order</button>
                        </div>
                    </form>
                </dialog>
            </c:if>

            <%-- Reviews --%>
            <div class="card" style="margin-top:24px;">
                <h2>
                    <span class="star filled">&#9733;</span> Reviews
                    (${product.reviewCount})
                </h2>

                <%-- Reviews can only be posted from My Orders (after purchase) --%>
                <c:if test="${sessionScope.user.role eq 'buyer'}">
                    <p style="color:var(--text-light); font-size:0.9rem;">
                        Want to leave a review? Open
                        <a href="${ctx}/myorders">My Orders</a> and review
                        any product you have purchased.
                    </p>
                    <hr style="margin:12px 0; border:none; border-top:1px solid var(--green-light);">
                </c:if>

                <c:choose>
                    <c:when test="${empty reviews}">
                        <p style="color:var(--text-light);">
                            No reviews yet &ndash; be the first to share your thoughts.
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

            <a href="${ctx}/buyer" class="btn btn-outline" style="margin-top:16px;">
                &larr; Back to Products
            </a>

        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
