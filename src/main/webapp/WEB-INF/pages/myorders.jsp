<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                                <th>Status</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="o" items="${orders}">
                                <tr>
                                    <td>${o.id}</td>
                                    <td><c:out value="${o.productName}"/></td>
                                    <td>${o.quantity}</td>
                                    <td>
                                        <fmt:formatNumber value="${o.totalPrice}"
                                                          minFractionDigits="2"
                                                          maxFractionDigits="2"/>
                                    </td>
                                    <td><span class="badge badge-${o.status}">${o.status}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty o.createdAt}">
                                                ${fn:substring(o.createdAt, 0, 10)}
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
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
