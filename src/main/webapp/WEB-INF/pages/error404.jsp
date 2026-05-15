<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="404 Not Found" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/includes/head.jsp" %>
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<div class="page" style="text-align:center; padding-top:80px;">
    <div style="font-size:5rem;"></div>
    <h1 style="font-size:3rem; color:var(--green-dark);">404</h1>
    <h2 style="color:var(--text-light); font-weight:400;">Page Not Found</h2>
    <p style="color:var(--text-light); margin:16px 0 24px;">
        The page you&#x2019;re looking for doesn&#x2019;t exist or has been moved.
    </p>
    <a href="javascript:history.back()" class="btn btn-outline" style="margin-right:12px;">&larr; Go Back</a>
    <a href="${ctx}/" class="btn btn-primary">Home</a>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
