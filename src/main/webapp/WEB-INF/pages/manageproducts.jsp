<!DOCTYPE html>
<html>
<head>
    <title>Manage Products</title>
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
    
    <div class="main">
    <h1>Manage Products</h1>

    <!-- Add Product Form -->
    <form action="ProductServlet" method="post">
        <input type="text" name="name" placeholder="Product Name" required>
        <input type="number" name="price" placeholder="Price" required>
        <input type="number" name="quantity" placeholder="Quantity" required>
        <button type="submit">Add Product</button>
    </form>

    <!-- Product Table -->
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price</th>
            <th>Action</th>
        </tr>
        <tr>
            <td>1</td>
            <td>Potato</td>
            <td>50</td>
            <td>
                <button>Edit</button>
                <button>Delete</button>
            </td>
        </tr>
    </table>
</div>
</div>

</body>
</html>