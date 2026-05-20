<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="Order Details" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/includes/head.jsp" %>
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<div class="page page-narrow">

    <div class="page-header">
        <h1>Order Details</h1>
        <c:if test="${not empty order}">
            <p>Order #${order.id} placed on
                <c:if test="${not empty order.createdAt}">
                    ${fn:substring(order.createdAt, 0, 10)}
                </c:if>.
            </p>
        </c:if>
    </div>

    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <c:choose>
        <c:when test="${empty order}">
            <p style="color:var(--text-light);">No order to display.</p>
            <a href="${ctx}/" class="btn btn-outline">Home</a>
        </c:when>
        <c:otherwise>

            <div class="card card-narrow">

                <h2>Summary</h2>
                <table class="report-table">
                    <tr><th>Order #</th>     <td>${order.id}</td></tr>
                    <tr><th>Product</th>     <td><c:out value="${order.productName}"/></td></tr>
                    <tr><th>Quantity</th>    <td>${order.quantity}</td></tr>
                    <tr><th>Total (NPR)</th>
                        <td>
                            <fmt:formatNumber value="${order.totalPrice}"
                                              minFractionDigits="2"
                                              maxFractionDigits="2"/>
                        </td>
                    </tr>
                    <tr><th>Delivery Location</th>
                        <td><c:out value="${order.deliveryLocation}"/></td>
                    </tr>
                    <tr><th>Current Status</th>
                        <td><span class="badge badge-${order.status}">${order.status}</span></td>
                    </tr>
                    <tr><th>Placed On</th>
                        <td>
                            <c:choose>
                                <c:when test="${not empty order.createdAt}">${order.createdAt}</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>

                <c:if test="${sessionScope.user.role ne 'buyer'}">
                    <h2 style="margin-top:18px;">Buyer</h2>
                    <p><c:out value="${order.buyerName}"/></p>
                </c:if>

                <c:if test="${sessionScope.user.role ne 'vendor'}">
                    <h2 style="margin-top:18px;">Vendor</h2>
                    <p><c:out value="${order.vendorName}"/></p>
                </c:if>
            </div>

            <%-- Status update form (admin and vendor only) --%>
            <c:if test="${canEdit}">
                <div class="card card-narrow">
                    <h2>Update Status</h2>
                    <form action="${ctx}/orderdetail" method="post">
                        <input type="hidden" name="id" value="${order.id}">

                        <div class="form-group">
                            <label for="status">New status</label>
                            <select id="status" name="status" required>
                                <c:forEach var="entry" items="${orderStatuses}">
                                    <option value="${entry.key}"
                                            <c:if test="${entry.key eq order.status}">selected</c:if>>
                                        ${entry.value}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-buttons">
                            <button type="submit" class="btn btn-primary">Save Status</button>
                        </div>
                    </form>
                </div>
            </c:if>

            <%-- Review prompt for buyer --%>
            <c:if test="${sessionScope.user.role eq 'buyer'}">
                <div class="card card-narrow">
                    <h2>Your Review</h2>
                    <c:choose>
                        <c:when test="${alreadyReviewed}">
                            <p style="color:var(--text-light);">
                                You have already reviewed this product.
                                <a href="${ctx}/reviews?productId=${order.productId}">View reviews</a>.
                            </p>
                        </c:when>
                        <c:otherwise>
                            <form action="${ctx}/reviews" method="post">
                                <input type="hidden" name="productId" value="${order.productId}">

                                <div class="form-group">
                                    <label for="rating">Rating *</label>
                                    <select id="rating" name="rating" required>
                                        <option value="">-- Select --</option>
                                        <option value="5">&#9733;&#9733;&#9733;&#9733;&#9733; (5)</option>
                                        <option value="4">&#9733;&#9733;&#9733;&#9733;&#9734; (4)</option>
                                        <option value="3">&#9733;&#9733;&#9733;&#9734;&#9734; (3)</option>
                                        <option value="2">&#9733;&#9733;&#9734;&#9734;&#9734; (2)</option>
                                        <option value="1">&#9733;&#9734;&#9734;&#9734;&#9734; (1)</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="comment">Comment *</label>
                                    <textarea id="comment" name="comment" rows="3"
                                              placeholder="Share your experience..." required></textarea>
                                </div>

                                <div class="form-buttons">
                                    <button type="submit" class="btn btn-primary">Submit Review</button>
                                </div>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <%-- Back link --%>
            <div class="form-buttons">
                <c:choose>
                    <c:when test="${sessionScope.user.role eq 'admin'}">
                        <a href="${ctx}/admin" class="btn btn-outline">&larr; Back to Dashboard</a>
                    </c:when>
                    <c:when test="${sessionScope.user.role eq 'vendor'}">
                        <a href="${ctx}/vendororders" class="btn btn-outline">&larr; Back to Orders</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${ctx}/myorders" class="btn btn-outline">&larr; Back to My Orders</a>
                    </c:otherwise>
                </c:choose>
            </div>

        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
