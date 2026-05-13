<%-- Render error / success / info alerts. --%>
<c:if test="${not empty requestScope.error}">
    <div class="alert alert-error">${requestScope.error}</div>
</c:if>
<c:if test="${not empty requestScope.success}">
    <div class="alert alert-success">${requestScope.success}</div>
</c:if>
<c:if test="${not empty requestScope.info}">
    <div class="alert alert-info">${requestScope.info}</div>
</c:if>

<%-- Session flash messages (consumed after display) --%>
<c:if test="${not empty sessionScope.orderSuccess}">
    <div class="alert alert-success">${sessionScope.orderSuccess}</div>
    <c:remove var="orderSuccess" scope="session"/>
</c:if>
<c:if test="${not empty sessionScope.orderError}">
    <div class="alert alert-error">${sessionScope.orderError}</div>
    <c:remove var="orderError" scope="session"/>
</c:if>
