<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="Login" scope="request"/>
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
            <h1>Login to your account</h1>
        </div>

        <h2>Welcome Back</h2>

        <%@ include file="/WEB-INF/includes/messages.jsp" %>

        <form action="${ctx}/login" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email"
                       placeholder="your@gmail.com"
                       value="${emailPrev}" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"
                       placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;"
                       minlength="6" required>
            </div>
            <button type="submit" class="btn btn-primary btn-full" style="margin-top:8px;">
                Login
            </button>
        </form>

        <div class="auth-links">
            <p>Don&#x2019;t have an account?
                <a href="${ctx}/register">Register here</a></p>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
