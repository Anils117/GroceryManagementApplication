<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Grocery Store - Fresh Food Delivered</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-shopping-basket me-2"></i>
                Fresh Grocery
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products">
                            <i class="fas fa-store me-1"></i>Shop
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/test-payment">
                            <i class="fas fa-credit-card me-1"></i>Test Payment
                        </a>
                    </li>
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                    <i class="fas fa-shopping-cart me-1"></i>Cart
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/order-history">
                                    <i class="fas fa-history me-1"></i>Orders
                                </a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user me-1"></i>${sessionScope.userName}
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt me-1"></i>Logout</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="fas fa-sign-in-alt me-1"></i>Login
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/register">
                                    <i class="fas fa-user-plus me-1"></i>Register
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section bg-light py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold text-success mb-3">
                        Fresh Groceries Delivered to Your Door
                    </h1>
                    <p class="lead mb-4">
                        Shop from our wide selection of fresh fruits, vegetables, dairy products, and more. 
                        Get everything you need delivered fresh and fast!
                    </p>
                    <div class="d-flex gap-3">
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-success btn-lg">
                            <i class="fas fa-shopping-basket me-2"></i>Start Shopping
                        </a>
                        <c:if test="${sessionScope.user == null}">
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-success btn-lg">
                                <i class="fas fa-user-plus me-2"></i>Sign Up
                            </a>
                        </c:if>
                    </div>
                </div>
                <div class="col-lg-6 text-center">
                    <img src="https://via.placeholder.com/500x400?text=Fresh+Groceries" 
                         alt="Fresh Groceries" class="img-fluid rounded shadow">
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-12">
                    <h2 class="fw-bold mb-3">Why Choose Fresh Grocery?</h2>
                    <p class="text-muted">We make grocery shopping easy, convenient, and affordable</p>
                </div>
            </div>
            
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="text-center p-4">
                        <div class="feature-icon bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" 
                             style="width: 80px; height: 80px;">
                            <i class="fas fa-leaf fa-2x"></i>
                        </div>
                        <h4>Fresh & Organic</h4>
                        <p class="text-muted">
                            Hand-picked fresh produce and organic products sourced directly from trusted farms.
                        </p>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="text-center p-4">
                        <div class="feature-icon bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" 
                             style="width: 80px; height: 80px;">
                            <i class="fas fa-truck fa-2x"></i>
                        </div>
                        <h4>Fast Delivery</h4>
                        <p class="text-muted">
                            Quick and reliable delivery service. Get your groceries delivered within hours.
                        </p>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="text-center p-4">
                        <div class="feature-icon bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" 
                             style="width: 80px; height: 80px;">
                            <i class="fas fa-dollar-sign fa-2x"></i>
                        </div>
                        <h4>Best Prices</h4>
                        <p class="text-muted">
                            Competitive prices with regular discounts and special offers for our customers.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Categories Section -->
    <section class="bg-light py-5">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-12">
                    <h2 class="fw-bold mb-3">Shop by Category</h2>
                    <p class="text-muted">Browse our wide range of fresh products</p>
                </div>
            </div>
            
            <div class="row g-4">
                <div class="col-md-3 col-sm-6">
                    <div class="card h-100 border-0 shadow-sm category-card">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-apple-alt fa-3x text-success mb-3"></i>
                            <h5 class="card-title">Fruits & Vegetables</h5>
                            <p class="card-text text-muted">Fresh, organic produce</p>
                            <a href="${pageContext.request.contextPath}/products?category=Fruits%20%26%20Vegetables" 
                               class="btn btn-outline-success">Shop Now</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3 col-sm-6">
                    <div class="card h-100 border-0 shadow-sm category-card">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-cheese fa-3x text-success mb-3"></i>
                            <h5 class="card-title">Dairy & Eggs</h5>
                            <p class="card-text text-muted">Fresh dairy products</p>
                            <a href="${pageContext.request.contextPath}/products?category=Dairy%20%26%20Eggs" 
                               class="btn btn-outline-success">Shop Now</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3 col-sm-6">
                    <div class="card h-100 border-0 shadow-sm category-card">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-drumstick-bite fa-3x text-success mb-3"></i>
                            <h5 class="card-title">Meat & Seafood</h5>
                            <p class="card-text text-muted">Premium quality meats</p>
                            <a href="${pageContext.request.contextPath}/products?category=Meat%20%26%20Seafood" 
                               class="btn btn-outline-success">Shop Now</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3 col-sm-6">
                    <div class="card h-100 border-0 shadow-sm category-card">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-bread-slice fa-3x text-success mb-3"></i>
                            <h5 class="card-title">Bakery</h5>
                            <p class="card-text text-muted">Fresh baked goods</p>
                            <a href="${pageContext.request.contextPath}/products?category=Bakery" 
                               class="btn btn-outline-success">Shop Now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-shopping-basket me-2"></i>Fresh Grocery</h5>
                    <p class="text-muted">Your trusted partner for fresh, quality groceries delivered right to your doorstep.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="text-muted mb-0">&copy; 2024 Fresh Grocery. All rights reserved.</p>
                    <p class="text-muted">
                        <a href="${pageContext.request.contextPath}/admin/login" class="text-light text-decoration-none">
                            <i class="fas fa-user-shield me-1"></i>Admin Login
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>