<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="Update Product" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="homeUrl"
       value="${sessionScope.user.role eq 'admin' ? ctx.concat('/admin') : ctx.concat('/vendor')}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/includes/head.jsp" %>
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<div class="page">
    <div class="page-header">
        <h1>Update Product</h1>
        <p>Edit the product details below.</p>
    </div>

    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <c:choose>
        <c:when test="${not empty product}">
            <div class="card" style="max-width:680px;">
                <form action="${ctx}/updateproduct" method="post">
                    <input type="hidden" name="id" value="${product.id}">

                    <div class="form-group">
                        <label for="name">Product Name *</label>
                        <input type="text" id="name" name="name"
                               value="${product.name}" required>
                    </div>

                    <div class="form-row">
                        <%-- Categories from AppConfig via UpdateProductServlet --%>
                        <div class="form-group">
                            <label for="category">Category *</label>
                            <select id="category" name="category" required>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat}"
                                            <c:if test="${cat eq product.category}">selected</c:if>>
                                        ${cat}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <%-- Units from AppConfig via UpdateProductServlet --%>
                        <div class="form-group">
                            <label for="unit">Unit *</label>
                            <select id="unit" name="unit" required>
                                <c:forEach var="entry" items="${units}">
                                    <option value="${entry.key}"
                                            <c:if test="${entry.key eq product.unit}">selected</c:if>>
                                        ${entry.value}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="price">Price per Unit (NPR) *</label>
                            <input type="number" id="price" name="price"
                                   step="0.01" value="${product.price}" required>
                        </div>
                        <div class="form-group">
                            <label for="quantity">Quantity *</label>
                            <input type="number" id="quantity" name="quantity"
                                   value="${product.quantity}" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" rows="3"><c:out value="${product.description}"/></textarea>
                    </div>

                    <%-- Product statuses from AppConfig via UpdateProductServlet --%>
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" name="status">
                            <c:forEach var="entry" items="${productStatuses}">
                                <option value="${entry.key}"
                                        <c:if test="${entry.key eq product.status}">selected</c:if>>
                                    ${entry.value}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div style="display:flex; gap:12px; margin-top:8px;">
                        <button type="submit" class="btn btn-warning">Save Changes</button>
                        <a href="${homeUrl}" class="btn btn-outline">Cancel</a>
                    </div>
                </form>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-error">Product not found.</div>
            <a href="${homeUrl}" class="btn btn-outline">&larr; Back</a>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
