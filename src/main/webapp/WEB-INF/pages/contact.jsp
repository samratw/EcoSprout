<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<c:set var="pageTitle" value="Contact Us" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/includes/head.jsp" %>
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<div class="page">
    <div style="max-width:760px; margin:0 auto;">

        <div class="page-header">
            <h1>Contact Us</h1>
            <p>We&#x2019;d love to hear from you. Send us a message and we&#x2019;ll
               respond within 24 hours.</p>
        </div>

        <%@ include file="/WEB-INF/includes/messages.jsp" %>

        <div class="info-grid">
            <div class="card center">
                <div class="info-icon"></div>
                <h3>Address</h3>
                <p>Kathmandu, Bagmati Province<br>Nepal</p>
            </div>
            <div class="card center">
                <div class="info-icon"></div>
                <h3>Email</h3>
                <p>support@ecosprout.com.np</p>
            </div>
            <div class="card center">
                <div class="info-icon"></div>
                <h3>Hours</h3>
                <p>Sun&ndash;Fri: 9 AM &ndash; 6 PM NPT</p>
            </div>
        </div>

        <div class="card">
            <h2>Send us a Message</h2>
            <form action="${ctx}/contact" method="post" style="margin-top:16px;">

                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Full Name *</label>
                        <input type="text" id="name" name="name"
                               placeholder="Your name" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email *</label>
                        <input type="email" id="email" name="email"
                               placeholder="your@email.com" required>
                    </div>
                </div>

                <%-- Subject list pushed by ContactServlet from AppConfig.CONTACT_SUBJECTS --%>
                <div class="form-group">
                    <label for="subject">Subject *</label>
                    <select id="subject" name="subject" required>
                        <option value="">-- Select Subject --</option>
                        <c:forEach var="s" items="${contactSubjects}">
                            <option value="${s}">${s}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="message">Message *</label>
                    <textarea id="message" name="message" rows="5"
                              placeholder="How can we help you?" required></textarea>
                </div>

                <button type="submit" class="btn btn-primary">Send Message</button>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>
