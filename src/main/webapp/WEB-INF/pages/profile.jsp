<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="My Profile" scope="request"/>
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
        <h1>My Profile</h1>
        <p>View and edit your personal information.</p>
    </div>

    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <div class="two-col">

        <%-- Profile details --%>
        <div class="card">
            <h2>Personal Information</h2>

            <div class="profile-summary">
                <div class="profile-avatar">
                    <c:out value="${fn:substring(profile.name, 0, 1)}"/>
                </div>
                <div>
                    <div class="profile-name"><c:out value="${profile.name}"/></div>
                    <div class="profile-meta">
                        <span class="badge badge-approved">${profile.role}</span>
                        <span class="badge badge-${profile.status}">${profile.status}</span>
                    </div>
                </div>
            </div>

            <form action="${ctx}/profile" method="post" style="margin-top:18px;">
                <input type="hidden" name="action" value="profile">

                <div class="form-group">
                    <label for="name">Full Name *</label>
                    <input type="text" id="name" name="name"
                           value="${profile.name}" required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address (read-only)</label>
                    <input type="email" id="email" value="${profile.email}" readonly>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number (10 digits) *</label>
                    <input type="text" id="phone" name="phone"
                           value="${profile.phone}" maxlength="10" required>
                </div>

                <button type="submit" class="btn btn-primary">Save Changes</button>
            </form>
        </div>

        <%-- Change password --%>
        <div class="card">
            <h2>Change Password</h2>
            <p style="color:var(--text-light); font-size:0.9rem;">
                Use a strong password (minimum 6 characters).
            </p>

            <form action="${ctx}/profile" method="post" style="margin-top:14px;">
                <input type="hidden" name="action" value="password">

                <div class="form-group">
                    <label for="currentPassword">Current Password *</label>
                    <input type="password" id="currentPassword" name="currentPassword" required>
                </div>
                <div class="form-group">
                    <label for="newPassword">New Password *</label>
                    <input type="password" id="newPassword" name="newPassword"
                           minlength="6" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm New Password *</label>
                    <input type="password" id="confirmPassword" name="confirmPassword"
                           minlength="6" required>
                </div>

                <button type="submit" class="btn btn-warning">Update Password</button>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
