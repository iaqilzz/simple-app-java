<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // get session
    String _navRole = (session != null) ? (String) session.getAttribute("role") : null;
    String _navName = (session != null) ? (String) session.getAttribute("userName") : null;
    boolean _navIsOwner = "1".equals(_navRole);

    // current page
    String _uri = request.getRequestURI();
%>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <span class="navbar-brand">
            <span class="brand-icon"><i class="fa-solid fa-leaf"></i></span>
            BLOOMCART
        </span>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <!-- sale -->
                <li class="nav-item">
                    <a class="nav-link <%= _uri.endsWith("sale.jsp") ? "active" : "" %>" href="sale.jsp">
                        <i class="fa-solid fa-cart-shopping"></i> Sale
                    </a>
                </li>
                
                <!-- owner only -->
                <% if (_navIsOwner) { %>
                <li class="nav-item">
                    <a class="nav-link <%= _uri.endsWith("product.jsp") ? "active" : "" %>" href="product.jsp">
                        <i class="fa-solid fa-seedling"></i> Product
                    </a>
                </li>
                <% } %>
                
                <!-- customer -->
                <li class="nav-item">
                    <a class="nav-link <%= _uri.endsWith("customer.jsp") ? "active" : "" %>" href="customer.jsp">
                        <i class="fa-solid fa-users"></i> Customer
                    </a>
                </li>
                
                <!-- owner only -->
                <% if (_navIsOwner) { %>
                <li class="nav-item">
                    <a class="nav-link <%= _uri.endsWith("create-staff.jsp") ? "active" : "" %>" href="create-staff.jsp">
                        <i class="fa-solid fa-user-tie"></i> Staff
                    </a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link <%= _uri.endsWith("report.jsp") ? "active" : "" %>" href="report.jsp">
                        <i class="fa-solid fa-chart-bar"></i> Report
                    </a>
                </li>
                <% } %>
                
                <!-- badge -->
                <li class="nav-item ms-2">
                    <% if (_navIsOwner) { %>
                    <span class="role-badge owner-badge"><i class="fa-solid fa-crown"></i> <%= _navName != null ? _navName : "Owner" %> &middot; Owner</span>
                    <% } else { %>
                    <span class="role-badge staff-badge"><i class="fa-solid fa-user-tie"></i> <%= _navName != null ? _navName : "Staff" %> &middot; Staff</span>
                    <% } %>
                </li>
                
                <!-- logout -->
                <li class="nav-item ms-1">
                    <a class="nav-link logout-link" href="LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
