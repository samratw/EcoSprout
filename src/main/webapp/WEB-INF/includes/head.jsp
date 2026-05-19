<%-- Common <head>content. Set ${pageTitle} before including. --%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>
    <c:choose>
        <c:when test="${not empty pageTitle}">${pageTitle} - EcoSprout</c:when>
        <c:otherwise>EcoSprout</c:otherwise>
    </c:choose>
</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
