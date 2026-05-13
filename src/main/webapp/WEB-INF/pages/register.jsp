<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="Register" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/includes/head.jsp" %>
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<div class="auth-wrap">
    <div class="auth-box">
        <div class="logo">
            <img src="${ctx}/images/authlogo.png" width="280" height="85" alt="EcoSprout">
            <h1>Create your account</h1>
        </div>

        <%@ include file="/WEB-INF/includes/messages.jsp" %>

        <form action="${ctx}/register" method="post">

            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name"
                       placeholder="e.g. Anamika Bhattarai"
                       value="${formData.name}" required>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email"
                       placeholder="your@gmail.com"
                       value="${formData.email}" required>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number (10 digits)</label>
                <input type="text" id="phone" name="phone"
                       placeholder="98XXXXXXXX" maxlength="10"
                       value="${formData.phone}" required>
            </div>

            <div class="form-group">
                <label for="password">Password (min 6 characters)</label>
                <input type="password" id="password" name="password"
                       placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;" required>
            </div>

            <%-- Roles pushed by RegisterServlet from AppConfig.REGISTER_ROLES --%>
            <div class="form-group">
                <label for="role">Register As</label>
                <select id="role" name="role" required>
                    <option value="">-- Select Role --</option>
                    <c:forEach var="entry" items="${roles}">
                        <option value="${entry.key}"
                                <c:if test="${entry.key eq formData.role}">selected</c:if>>
                            ${entry.value}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <button type="submit" class="btn btn-primary btn-full" style="margin-top:8px;">
                Create Account
            </button>
        </form>

        <div class="auth-links">
            <p>Already have an account?
                <a href="${ctx}/login">Login here</a></p>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
