const nav = document.getElementById('main-nav');
let lastScrollY = window.scrollY;

window.addEventListener('scroll', () => {
	const currentScrollY = window.scrollY;

  	if (currentScrollY > lastScrollY && currentScrollY > 80) 
	{
    	nav.classList.add('hidden');
  	} 
	else 
	{
    	nav.classList.remove('hidden');
  	}

  	if (currentScrollY > 10) 
	{
    	nav.classList.add('scrolled');
  	} 
	else 
	{
    	nav.classList.remove('scrolled');
  	}

  	lastScrollY = currentScrollY;
});

// Product Slider
let currentProduct = 0;
const slides = document.querySelectorAll('.product-slide');

function changeProduct(direction) {
  slides[currentProduct].classList.remove('active');
  currentProduct = (currentProduct + direction + slides.length) % slides.length;
  slides[currentProduct].classList.add('active');
}