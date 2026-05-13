<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="Vendor Dashboard" scope="request"/>
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
        <h1>Vendor Dashboard</h1>
        <p>Hello, <strong>${sessionScope.user.name}</strong> &ndash; manage your agro product listings.</p>
    </div>

    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <div style="margin-bottom:20px;">
        <a href="${ctx}/addproduct" class="btn btn-primary">&#x2795; Add New Product</a>
    </div>

    <c:choose>
        <c:when test="${empty products}">
            <div class="card center" style="padding:40px;">
                <p style="color:var(--text-light); font-size:1.1rem;">
                    You haven&#x2019;t listed any products yet.</p>
                <a href="${ctx}/addproduct" class="btn btn-primary" style="margin-top:16px;">
                    Add Your First Product</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="product-grid">
                <c:forEach var="p" items="${products}">
                    <div class="product-card">
                        <c:choose>
                            <c:when test="${not empty p.image}">
                                <img src="${ctx}/images/${p.image}" alt="${p.name}">
                            </c:when>
                            <c:otherwise>
                                <div class="product-placeholder">&#x1F33E;</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="pc-body">
                            <div class="pc-name"><c:out value="${p.name}"/></div>
                            <div class="pc-cat"><c:out value="${p.category}"/></div>
                            <div class="pc-price">
                                NPR
                                <fmt:formatNumber value="${p.price}" minFractionDigits="2" maxFractionDigits="2"/>
                                / ${p.unit}
                            </div>
                            <div class="pc-qty">
                                Stock: ${p.quantity} ${p.unit}
                            </div>
                            <span class="badge badge-${p.status}" style="margin-top:6px;">${p.status}</span>
                        </div>

                        <div class="pc-actions">
                            <a href="${ctx}/updateproduct?id=${p.id}" class="btn btn-warning btn-sm">Edit</a>
                            <a href="${ctx}/deleteproduct?id=${p.id}" class="btn btn-danger btn-sm"
                               onclick="return confirm('Delete this product?')">Delete</a>
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
