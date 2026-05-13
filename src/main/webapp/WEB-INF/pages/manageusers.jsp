<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="Manage Users" scope="request"/>
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
        <h1>Manage Users</h1>
        <p>Approve or reject vendor and buyer registrations.</p>
    </div>

    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <div class="card">
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td>${u.id}</td>
                            <td><c:out value="${u.name}"/></td>
                            <td><c:out value="${u.email}"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty u.phone}"><c:out value="${u.phone}"/></c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td><span class="badge badge-approved">${u.role}</span></td>
                            <td><span class="badge badge-${u.status}">${u.status}</span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.status eq 'pending'}">
                                        <form action="${ctx}/manageusers" method="post" style="display:inline;">
                                            <input type="hidden" name="userId" value="${u.id}">
                                            <button name="action" value="approve" class="btn btn-success btn-sm">Approve</button>
                                            <button name="action" value="reject"  class="btn btn-danger  btn-sm">Reject</button>
                                        </form>
                                    </c:when>
                                    <c:when test="${u.status eq 'approved' and u.role ne 'admin'}">
                                        <form action="${ctx}/manageusers" method="post" style="display:inline;">
                                            <input type="hidden" name="userId" value="${u.id}">
                                            <button name="action" value="reject" class="btn btn-warning btn-sm">Revoke</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color:var(--text-light);">&mdash;</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty users}">
                        <tr>
                            <td colspan="7" style="text-align:center; color:var(--text-light); padding:24px;">
                                No users found.
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
