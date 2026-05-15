<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="Admin Dashboard" scope="request"/>
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
        <h1>Admin Dashboard</h1>
        <p>Welcome, <strong>${sessionScope.user.name}</strong> &ndash; manage EcoSprout from here.</p>
    </div>

    <%-- dbError is a separate alert (request-scope) handled here, plus generic messages --%>
    <c:if test="${not empty dbError}">
        <div class="alert alert-error">${dbError}</div>
    </c:if>
    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <%-- Stats Row --%>
    <div class="stats-row">
        <div class="stat-card">
            <div class="stat-number">${totalProducts}</div>
            <div class="stat-label">Total Products</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">${pendingUsers}</div>
            <div class="stat-label">Pending Approvals</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">${totalOrders}</div>
            <div class="stat-label">Total Orders</div>
        </div>
    </div>

    <div class="dashboard-layout">

        <%-- Admin Sidebar --%>
        <aside class="sidebar">
            <div class="side-card">
                <a href="${ctx}/addproduct">Add Product</a>
                <a href="${ctx}/viewproducts">View All Products</a>
                <a href="${ctx}/manageusers">Manage Users</a>
                <a href="${ctx}/about">About Page</a>
                <a href="${ctx}/contact">Contact</a>
                <a href="${ctx}/logout" style="color:var(--danger);">Logout</a>
            </div>
        </aside>

        <main class="main-content">
            <%-- Recent Orders --%>
            <div class="card">
                <h2>Recent Orders</h2>

                <c:choose>
                    <c:when test="${empty recentOrders}">
                        <p style="color:var(--text-light);">No orders placed yet.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Buyer</th>
                                        <th>Product</th>
                                        <th>Qty</th>
                                        <th>Total (NPR)</th>
                                        <th>Location</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="o" items="${recentOrders}">
                                        <tr>
                                            <td>${o.id}</td>
                                            <td><c:out value="${o.buyerName}"/></td>
                                            <td><c:out value="${o.productName}"/></td>
                                            <td>${o.quantity}</td>
                                            <td>
                                                <fmt:formatNumber value="${o.totalPrice}"
                                                                  type="number"
                                                                  minFractionDigits="2"
                                                                  maxFractionDigits="2"/>
                                            </td>
                                            <td><c:out value="${o.deliveryLocation}"/></td>
                                            <td>
                                                <span class="badge badge-${o.status}">${o.status}</span>
                                            </td>
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
        </main>
    </div>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
