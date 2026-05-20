<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="Contact Messages" scope="request"/>
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
        <h1>Contact Messages</h1>
        <p>All inquiries submitted through the public contact form.</p>
    </div>

    <%@ include file="/WEB-INF/includes/messages.jsp" %>

    <div class="stats-row">
        <div class="stat-card">
            <div class="stat-number">${totalContacts}</div>
            <div class="stat-label">Total Messages</div>
        </div>
    </div>

    <div class="card">
        <h2>Inbox</h2>

        <c:choose>
            <c:when test="${empty contacts}">
                <p style="color:var(--text-light);">No contact messages yet.</p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Subject</th>
                                <th>Message</th>
                                <th>Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${contacts}">
                                <tr>
                                    <td>${c.id}</td>
                                    <td><c:out value="${c.name}"/></td>
                                    <td><c:out value="${c.email}"/></td>
                                    <td><c:out value="${c.subject}"/></td>
                                    <td><c:out value="${c.message}"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty c.createdAt}">
                                                ${fn:substring(c.createdAt, 0, 10)}
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <form action="${ctx}/managecontacts" method="post"
                                              style="display:inline;">
                                            <input type="hidden" name="contactId" value="${c.id}">
                                            <button type="submit" class="btn btn-danger btn-sm"
                                                    onclick="return confirm('Delete this message?')">
                                                Delete
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <a href="${ctx}/admin" class="btn btn-outline" style="margin-top:16px;">&larr; Back to Dashboard</a>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
