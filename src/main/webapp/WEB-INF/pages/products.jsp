<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>EcoSprout</title>
    <link rel="stylesheet" href="css/products.css">
    <link rel="stylesheet" href="css/home.css">
</head>
<body>

<nav id="main-nav">
  	<!-- logo /left side -->
  		<div class="nav-logo">
  			Ecosprout
  		</div>
  	
  		<!-- Center/Nav links -->
		<div class="nav-links">  
			<ul>
				<li>
					<a href="<%=request.getContextPath()%>/homepage">
					<img src="<%=request.getContextPath()%>/images/home-1-svgrepo-com.svg" alt="Home" width="20px" height="20px">
						Home
					</a>
				</li>
				<li>
					<a href="<%=request.getContextPath()%>/products">
					<img src="<%=request.getContextPath()%>/images/cart-svgrepo-com.svg" alt="Shop" width="20px" height="20px">
					Products
					</a>
				</li>
				<li>
					<a href="<%=request.getContextPath()%>/aboutuspage">
					<img src="<%=request.getContextPath()%>/images/profile-about-mobile-ui-svgrepo-com.svg" alt="About" width="20px" height="20px">
						About Us
					</a>
				</li>
				<li>	
					<a href="<%=request.getContextPath()%>/contactspage">
					<img src="<%=request.getContextPath()%>/images/contact.svg" alt="Contact" width="20px" height="20px">
						Contact
					</a>
				</li>
			</ul>
		</div>
	
		<!-- Right Side: Cart + Profile -->
		<div class="nav-icons">
			<a href="<%=request.getContextPath()%>/cartpage" class="cart-btn" title="Cart">
				<img src="<%=request.getContextPath()%>/images/cart-svgrepo-com.svg" alt="cart" width="20px" height="20px">
			</a>
		</div>
		<div class="profile-wrapper">
			<button class="icon-btn" onclick="toggleProfileMenu()">
				<img src="<%=request.getContextPath()%>/images/profile-about-mobile-ui-svgrepo-com.svg" alt="profile" width="20px" height="20px">
			</button>
		</div>
	</nav>

<!-- Search Bar -->
<div class="search-container">
    <input type="text" placeholder="Search products...">
    <button>Search</button>
</div>

<!-- Product Section -->
<div class="container">
    <h1>Fresh EcoSprout Products</h1>

    <div class="product-grid">

        <!-- Product Card -->
        <div class="card">
            <img src="images/tomato.jpg" alt="Tomato">
            <h3>Fresh Tomatoes</h3>
            <p class="price">Rs. 80/kg</p>
            <p class="stock">In Stock</p>
            <button>Add to Cart</button>
        </div>

        <div class="card">
            <img src="images/rice.jpg" alt="Rice">
            <h3>Organic Rice</h3>
            <p class="price">Rs. 120/kg</p>
            <p class="stock">In Stock</p>
            <button>Add to Cart</button>
        </div>

        <div class="card">
            <img src="images/potato.jpg" alt="Potato">
            <h3>Potatoes</h3>
            <p class="price">Rs. 50/kg</p>
            <p class="stock">Out of Stock</p>
            <button disabled>Unavailable</button>
        </div>

    </div>
</div>

</body>
</html>