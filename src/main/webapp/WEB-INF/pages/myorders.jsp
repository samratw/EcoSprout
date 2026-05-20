<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="My Orders" scope="request"/>
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
        <h1>My Orders</h1>
        <p>Your order history on EcoSprout.</p>
    </div>

    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <%-- Summary stats --%>
    <div class="stats-row">
        <div class="stat-card">
            <div class="stat-number">${orderCount}</div>
            <div class="stat-label">Total Orders</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">
                NPR&nbsp;<fmt:formatNumber value="${grandTotal}" minFractionDigits="2" maxFractionDigits="2"/>
            </div>
            <div class="stat-label">Lifetime Spend</div>
        </div>
    </div>

    <div class="card">
        <h2>Order History</h2>

        <c:choose>
            <c:when test="${empty orders}">
                <p style="color:var(--text-light);">
                    You haven&#x2019;t placed any orders yet.
                    <a href="${ctx}/buyer">Browse products</a>
                </p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Product</th>
                                <th>Qty</th>
                                <th>Total (NPR)</th>
                                <th>Location</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Review</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="o" items="${orders}">

                                <c:set var="alreadyReviewed" value="${not empty reviewedMap and reviewedMap[o.productId]}"/>

                                <tr>
                                    <td>
                                        <a href="${ctx}/orderdetail?id=${o.id}">#${o.id}</a>
                                    </td>
                                    <td>
                                        <a href="${ctx}/orderdetail?id=${o.id}"
                                           style="color:inherit; text-decoration:none;">
                                            <c:out value="${o.productName}"/>
                                        </a>
                                    </td>
                                    <td>${o.quantity}</td>
                                    <td>
                                        <fmt:formatNumber value="${o.totalPrice}"
                                                          minFractionDigits="2"
                                                          maxFractionDigits="2"/>
                                    </td>
                                    <td><c:out value="${o.deliveryLocation}"/></td>
                                    <td><span class="badge badge-${o.status}">${o.status}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty o.createdAt}">
                                                ${fn:substring(o.createdAt, 0, 10)}
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${alreadyReviewed}">
                                                <span class="star filled">&#9733;</span> Reviewed
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button" class="btn btn-primary btn-sm"
                                                        onclick="document.getElementById('rev-${o.id}').showModal()">
                                                    Write Review
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>

                                <%-- Review dialog (popup) shown only if not yet reviewed --%>
                                <c:if test="${not alreadyReviewed}">
                                    <dialog id="rev-${o.id}" class="order-dialog">
                                        <form action="${ctx}/reviews" method="post">
                                            <h2>Review &ndash; <c:out value="${o.productName}"/></h2>
                                            <p style="color:var(--text-light);">
                                                Share your thoughts on this product.
                                            </p>
                                            <input type="hidden" name="productId" value="${o.productId}">

                                            <div class="form-group">
                                                <label for="rate-${o.id}">Rating *</label>
                                                <select id="rate-${o.id}" name="rating" required>
                                                    <option value="">-- Select --</option>
                                                    <option value="5">&#9733;&#9733;&#9733;&#9733;&#9733; (5)</option>
                                                    <option value="4">&#9733;&#9733;&#9733;&#9733;&#9734; (4)</option>
                                                    <option value="3">&#9733;&#9733;&#9733;&#9734;&#9734; (3)</option>
                                                    <option value="2">&#9733;&#9733;&#9734;&#9734;&#9734; (2)</option>
                                                    <option value="1">&#9733;&#9734;&#9734;&#9734;&#9734; (1)</option>
                                                </select>
                                            </div>

                                            <div class="form-group">
                                                <label for="cmt-${o.id}">Comment *</label>
                                                <textarea id="cmt-${o.id}" name="comment" rows="3"
                                                          placeholder="What did you like or dislike?" required></textarea>
                                            </div>

                                            <div class="dialog-actions">
                                                <button type="button" class="btn btn-outline"
                                                        onclick="document.getElementById('rev-${o.id}').close()">
                                                    Cancel
                                                </button>
                                                <button type="submit" class="btn btn-primary">
                                                    Submit Review
                                                </button>
                                            </div>
                                        </form>
                                    </dialog>
                                </c:if>

                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <a href="${ctx}/buyer" class="btn btn-outline" style="margin-top:16px;">&larr; Continue Shopping</a>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
