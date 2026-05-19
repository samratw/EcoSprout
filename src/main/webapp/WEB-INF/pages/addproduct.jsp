<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="Add Product" scope="request"/>
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

<div class="page page-narrow">
    <div class="page-header">
        <h1>Add New Product</h1>
        <p>List a new agro product on EcoSprout.</p>
    </div>

    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <div class="card card-narrow">
        <form action="${ctx}/addproduct" method="post" enctype="multipart/form-data">

            <div class="form-group">
                <label for="name">Product Name *</label>
                <input type="text" id="name" name="name"
                       placeholder="e.g. Organic Tomatoes" required>
            </div>

            <div class="form-row">
                <%-- Categories pushed by AddProductServlet from AppConfig --%>
                <div class="form-group">
                    <label for="category">Category *</label>
                    <select id="category" name="category" required>
                        <option value="">-- Select Category --</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat}">${cat}</option>
                        </c:forEach>
                    </select>
                </div>

                <%-- Units pushed by AddProductServlet from AppConfig --%>
                <div class="form-group">
                    <label for="unit">Unit *</label>
                    <select id="unit" name="unit" required>
                        <c:forEach var="entry" items="${units}">
                            <option value="${entry.key}">${entry.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="price">Price per Unit (NPR) *</label>
                    <input type="number" id="price" name="price"
                           min="0.01" step="0.01" placeholder="e.g. 120.00" required>
                </div>
                <div class="form-group">
                    <label for="quantity">Available Quantity *</label>
                    <input type="number" id="quantity" name="quantity"
                           min="0" placeholder="e.g. 50" required>
                </div>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="3"
                          placeholder="Describe your product, growing method, freshness, etc."></textarea>
            </div>

            <div class="form-group">
                <label for="image">Product Image</label>
                <input type="file" id="image" name="image" accept="image/*">
                <small style="color:var(--text-light);">Max 5MB. JPG, PNG accepted.</small>
            </div>

            <div class="form-buttons">
                <button type="submit" class="btn btn-primary">Add Product</button>
                <a href="${homeUrl}" class="btn btn-outline">Cancel</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
