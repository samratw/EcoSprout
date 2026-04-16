<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - EcoSprout</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>

<div class="container">

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>EcoSprout</h2>
        <ul>
            <li><a href="admin">Dashboard</a></li>
            <li><a href="manageproducts">Manage Products</a></li>
            <li><a href="manageusers">Manage Users</a></li>
            <li><a href="orders">Orders</a></li>
            <li><a href="reports">Reports</a></li>
            <li><a href="LogoutServlet">Logout</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main">

        <!-- Topbar -->
        <div class="topbar">
            <h1>Welcome, Admin</h1>
        </div>

        <!-- Cards -->
        <div class="cards">
            <div class="card">
                <h3>Total Products</h3>
                <p>120</p>
            </div>
            <div class="card">
                <h3>Total Users</h3>
                <p>80</p>
            </div>
            <div class="card">
                <h3>Total Orders</h3>
                <p>45</p>
            </div>
            <div class="card">
                <h3>Revenue</h3>
                <p>Rs.1500</p>
            </div>
        </div>

        <!-- Table Section -->
        <div class="table-section">
            <h2>Recent Orders</h2>

            <table>
                <tr>
                    <th>ID</th>
                    <th>Customer</th>
                    <th>Product</th>
                    <th>Status</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>Ram</td>
                    <td>Tomatoes</td>
                    <td>Delivered</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Sita</td>
                    <td>Rice</td>
                    <td>Pending</td>
                </tr>
            </table>
        </div>

    </div>
</div>

</body>
</html>