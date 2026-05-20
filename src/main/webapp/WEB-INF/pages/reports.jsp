<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="Reports" scope="request"/>
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
        <h1>Reports &amp; Analytics</h1>
        <p>Insights into EcoSprout&#x2019;s catalogue, users, and orders.</p>
    </div>

    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <div class="stats-row">
        <div class="stat-card">
            <div class="stat-number">${totalProducts}</div>
            <div class="stat-label">Products</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">${totalOrders}</div>
            <div class="stat-label">Orders</div>
        </div>
    </div>

    <div class="two-col">

        <%-- Products by category --%>
        <div class="card">
            <div class="row-between">
                <h2>Products by Category</h2>
                <a href="${ctx}/downloadreport?type=products-by-category"
                   class="btn btn-outline btn-sm">Download CSV</a>
            </div>
            <c:choose>
                <c:when test="${empty productsByCategory}">
                    <p style="color:var(--text-light);">No products yet.</p>
                </c:when>
                <c:otherwise>
                    <table class="report-table">
                        <thead>
                            <tr><th>Category</th><th>Count</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${productsByCategory}">
                                <tr>
                                    <td><c:out value="${row.key}"/></td>
                                    <td>${row.value}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Orders by status --%>
        <div class="card">
            <div class="row-between">
                <h2>Orders by Status</h2>
                <a href="${ctx}/downloadreport?type=orders-by-status"
                   class="btn btn-outline btn-sm">Download CSV</a>
            </div>
            <c:choose>
                <c:when test="${empty ordersByStatus}">
                    <p style="color:var(--text-light);">No orders yet.</p>
                </c:when>
                <c:otherwise>
                    <table class="report-table">
                        <thead>
                            <tr><th>Status</th><th>Count</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${ordersByStatus}">
                                <tr>
                                    <td><span class="badge badge-${row.key}">${row.key}</span></td>
                                    <td>${row.value}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Users by role --%>
        <div class="card">
            <div class="row-between">
                <h2>Users by Role</h2>
                <a href="${ctx}/downloadreport?type=users-by-role"
                   class="btn btn-outline btn-sm">Download CSV</a>
            </div>
            <c:choose>
                <c:when test="${empty usersByRole}">
                    <p style="color:var(--text-light);">No users yet.</p>
                </c:when>
                <c:otherwise>
                    <table class="report-table">
                        <thead>
                            <tr><th>Role</th><th>Count</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${usersByRole}">
                                <tr>
                                    <td><span class="badge badge-approved">${row.key}</span></td>
                                    <td>${row.value}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Top 5 sellers --%>
        <div class="card">
            <div class="row-between">
                <h2>Top 5 Sellers</h2>
                <a href="${ctx}/downloadreport?type=top-sellers"
                   class="btn btn-outline btn-sm">Download CSV</a>
            </div>
            <c:choose>
                <c:when test="${empty topSellers}">
                    <p style="color:var(--text-light);">No sales recorded yet.</p>
                </c:when>
                <c:otherwise>
                    <table class="report-table">
                        <thead>
                            <tr><th>Product</th><th>Units Sold</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${topSellers}">
                                <tr>
                                    <td><c:out value="${row.name}"/></td>
                                    <td>${row.qty}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

    <a href="${ctx}/admin" class="btn btn-outline" style="margin-top:16px;">&larr; Back to Dashboard</a>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
