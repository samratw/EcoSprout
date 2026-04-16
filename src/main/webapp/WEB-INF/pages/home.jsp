<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>
<html>
<head>
  <title>Home</title>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/home.css" />
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
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
   	<!-- Slider Section -->
   	<section class="slider" style="background-image : url('<%=request.getContextPath()%>/images/test 2.png')">
   		<div class="slider-text">
   			<h1>Heading Texts</h1>	
   		</div>
   		<div class="slider-bottom">
   			<img src="<%=request.getContextPath()%>/images/hills.png" alt="hills">
   		</div>
   	</section>
	
	<!-- Experience Section -->
	<section class="experience">
		<!-- Left Side -->
		<div class="experience-left">
			<img class="experience-deco" src="<%=request.getContextPath()%>/images/Test-img 6.png" alt="">
			<p class="experience-label">Experience</p>
			<h1 class="experience-heading">The Story Behind<br>Our Project </h1>
			<div class="experience-left-img">
				<img src="<%=request.getContextPath()%>/images/Test-img4.png" alt="Experience left"> 
			</div>
		</div>
		<!-- Right Side -->
		<div class="experience-right">
			<div class="experience-right-top">
				<img class="experience-photo" src="<%=request.getContextPath()%>/images/Test-Img5.png" alt="">
			</div> 
		<p class="experience-desc">
			Guided walking tour through the vineyards in the Valley of Gods and our Wineries.
      		Book your tour in advance (minimum 7 adults) which will take place on-site.
		</p>
		</div>
	</section>
	
	<!-- Product Section -->
	<section class="products">
		<button class="product-arrow product-arrow-left" onclick="changeProduct(-1)">&#8592</button>
		
		<div class="product-slide active">
			<div class="product-image">
				<img src="<%=request.getContextPath()%>/images/test-product1.jpg" alt="Product 1">
			</div>
			<div class="product-info">
				<p class="product-category">CATEGORY ONE</p>
				<h1 class="product-name">Product Name One</h1>
				<p class="product-desc">Lorem ipsum dolor sit amet, consectetur adipiscing elit,
        								sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
        		<a href="<%=request.getContextPath()%>/products" class="product-link">Browse More &#8594;</a>
			</div>
		</div>
		
		<div class="product-slide">
			<div class="product-image">
				<img src="<%=request.getContextPath()%>/images/test-product2.jpg" alt="Product 1">
			</div>
			<div class="product-info">
				<p class="product-category">CATEGORY TWO</p>
				<h1 class="product-name">Product Name Two</h1>
				<p class="product-desc">Lorem ipsum dolor sit amet, consectetur adipiscing elit,
        								sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
        		<a href="<%=request.getContextPath()%>/products" class="product-link">Browse More &#8594;</a>
			</div>
		</div>
		
		<button class="product-arrow product-arrow-right" onclick="changeProduct(1)">&#8594;</button>
	</section>
	<script src="<%=request.getContextPath()%>/js/nav.js"></script>
</body>
</html>