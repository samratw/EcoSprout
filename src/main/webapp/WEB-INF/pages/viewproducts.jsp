<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="All Products" scope="request"/>
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
        <h1>All Products</h1>
        <p>View and manage all product listings on EcoSprout.</p>
    </div>

    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <div class="card">
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Price (NPR)</th>
                        <th>Qty</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td>${p.id}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty p.image}">
                                        <img src="${ctx}/images/${p.image}"
                                             class="thumb"
                                             alt="${p.name}">
                                    </c:when>
                                    <c:otherwise>&#x1F33E;</c:otherwise>
                                </c:choose>
                            </td>
                            <td><strong><c:out value="${p.name}"/></strong></td>
                            <td><c:out value="${p.category}"/></td>
                            <td>
                                <fmt:formatNumber value="${p.price}" minFractionDigits="2" maxFractionDigits="2"/>
                                / ${p.unit}
                            </td>
                            <td>${p.quantity}</td>
                            <td><span class="badge badge-${p.status}">${p.status}</span></td>
                            <td>
                                <a href="${ctx}/updateproduct?id=${p.id}" class="btn btn-warning btn-sm">Edit</a>
                                <a href="${ctx}/deleteproduct?id=${p.id}" class="btn btn-danger btn-sm"
                                   onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty products}">
                        <tr>
                            <td colspan="8" style="text-align:center; color:var(--text-light); padding:24px;">
                                No products listed yet.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <a href="${ctx}/admin" class="btn btn-outline" style="margin-top:16px;">&larr; Back to Dashboard</a>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
