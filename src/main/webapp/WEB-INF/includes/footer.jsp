<%-- Common site footer. --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<footer class="site-footer">
    <div class="footer-grid">

        <div class="footer-col">
            <h4>EcoSprout</h4>
            <p>
                An online marketplace connecting local farmers in Nepal with
                buyers, eliminating middlemen and promoting sustainable
                agriculture.
            </p>
        </div>

        <div class="footer-col">
            <h4>Quick Links</h4>
            <ul>
                <li><a href="${ctx}/">Home</a></li>
                <li><a href="${ctx}/about">About Us</a></li>
                <li><a href="${ctx}/contact">Contact</a></li>
                <c:if test="${empty sessionScope.user}">
                    <li><a href="${ctx}/login">Login</a></li>
                    <li><a href="${ctx}/register">Register</a></li>
                </c:if>
                <c:if test="${not empty sessionScope.user}">
                    <li><a href="${ctx}/profile">My Profile</a></li>
                    <c:if test="${sessionScope.user.role eq 'buyer'}">
                        <li><a href="${ctx}/myorders">My Orders</a></li>
                    </c:if>
                </c:if>
            </ul>
        </div>

        <div class="footer-col">
            <h4>Reach Us</h4>
            <ul class="footer-contact">
                <li>Kathmandu, Bagmati, Nepal</li>
                <li>support@ecosprout.com.np</li>
                <li>Sun&ndash;Fri 9 AM &ndash; 6 PM NPT</li>
            </ul>
        </div>

    </div>

    <div class="footer-bottom">
        &copy; 2026 EcoSprout &ndash; Fresh Agro Products Marketplace. All rights reserved.
    </div>
</footer>
