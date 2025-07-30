<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - Fresh Grocery Store</title>
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/">
                            <i class="fas fa-home me-1"></i>Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/products">
                            <i class="fas fa-store me-1"></i>Shop
                        </a>
                    </li>
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                    <i class="fas fa-shopping-cart me-1"></i>Cart
                                    <c:if test="${sessionScope.cartItemCount > 0}">
                                        <span class="badge bg-warning text-dark">${sessionScope.cartItemCount}</span>
                                    </c:if>
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

    <div class="container py-4">
        <!-- Page Header -->
        <div class="row mb-4">
            <div class="col-12">
                <h1 class="display-5 fw-bold text-success mb-2">
                    <i class="fas fa-store me-2"></i>Our Products
                </h1>
                <p class="text-muted">Discover fresh, quality groceries for your everyday needs</p>
            </div>
        </div>

        <!-- Search and Filter Section -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <form method="get" action="${pageContext.request.contextPath}/products" class="row g-3">
                            <div class="col-md-6">
                                <label for="search" class="form-label">
                                    <i class="fas fa-search me-1"></i>Search Products
                                </label>
                                <input type="text" class="form-control" id="search" name="search" 
                                       value="${searchTerm}" placeholder="Search for products...">
                            </div>
                            <div class="col-md-4">
                                <label for="category" class="form-label">
                                    <i class="fas fa-filter me-1"></i>Category
                                </label>
                                <select class="form-select" id="category" name="category">
                                    <option value="">All Categories</option>
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat}" ${selectedCategory eq cat ? 'selected' : ''}>
                                            ${cat}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2 d-flex align-items-end">
                                <button type="submit" class="btn btn-success w-100">
                                    <i class="fas fa-search me-1"></i>Search
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Products Grid -->
        <div class="row">
            <c:choose>
                <c:when test="${not empty products}">
                    <c:forEach var="product" items="${products}">
                        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                            <div class="card product-card h-100 shadow-sm">
                                <div class="card-img-top position-relative">
                                    <img src="${product.imageUrl}" alt="${product.name}" 
                                         class="product-image w-100" loading="lazy">
                                    <c:if test="${product.stockQuantity <= 5 && product.stockQuantity > 0}">
                                        <span class="badge bg-warning position-absolute top-0 start-0 m-2">
                                            Low Stock
                                        </span>
                                    </c:if>
                                    <c:if test="${product.stockQuantity == 0}">
                                        <span class="badge bg-danger position-absolute top-0 start-0 m-2">
                                            Out of Stock
                                        </span>
                                    </c:if>
                                </div>
                                
                                <div class="card-body d-flex flex-column">
                                    <div class="mb-2">
                                        <span class="badge bg-light text-dark">${product.category}</span>
                                    </div>
                                    
                                    <h5 class="card-title text-truncate" title="${product.name}">
                                        ${product.name}
                                    </h5>
                                    
                                    <p class="card-text text-muted small flex-grow-1">
                                        ${product.description}
                                    </p>
                                    
                                    <div class="mt-auto">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <div>
                                                <span class="product-price">${product.formattedPrice}</span>
                                            </div>
                                            <div class="text-end">
                                                <c:choose>
                                                    <c:when test="${product.stockQuantity > 0}">
                                                        <small class="product-stock">
                                                            <i class="fas fa-check-circle text-success me-1"></i>
                                                            ${product.stockQuantity} in stock
                                                        </small>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <small class="out-of-stock">
                                                            <i class="fas fa-times-circle me-1"></i>
                                                            Out of stock
                                                        </small>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        
                                        <c:choose>
                                            <c:when test="${sessionScope.user != null}">
                                                <c:choose>
                                                    <c:when test="${product.stockQuantity > 0}">
                                                        <form method="post" action="${pageContext.request.contextPath}/cart" class="d-flex gap-2">
                                                            <input type="hidden" name="action" value="add">
                                                            <input type="hidden" name="productId" value="${product.productId}">
                                                            <input type="number" name="quantity" value="1" min="1" max="${product.stockQuantity}" 
                                                                   class="form-control form-control-sm" style="width: 70px;">
                                                            <button type="submit" class="btn btn-success btn-sm flex-grow-1">
                                                                <i class="fas fa-cart-plus me-1"></i>Add to Cart
                                                            </button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-secondary btn-sm w-100" disabled>
                                                            <i class="fas fa-ban me-1"></i>Out of Stock
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-success btn-sm w-100">
                                                    <i class="fas fa-sign-in-alt me-1"></i>Login to Buy
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="text-center py-5">
                            <i class="fas fa-search fa-3x text-muted mb-3"></i>
                            <h3 class="text-muted">No Products Found</h3>
                            <p class="text-muted">
                                <c:choose>
                                    <c:when test="${not empty searchTerm || not empty selectedCategory}">
                                        Try adjusting your search criteria or <a href="${pageContext.request.contextPath}/products">view all products</a>
                                    </c:when>
                                    <c:otherwise>
                                        No products are currently available.
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Results Info -->
        <c:if test="${not empty products}">
            <div class="row mt-4">
                <div class="col-12">
                    <div class="d-flex justify-content-between align-items-center">
                        <p class="text-muted mb-0">
                            Showing ${products.size()} product(s)
                            <c:if test="${not empty searchTerm}">
                                for "<strong>${searchTerm}</strong>"
                            </c:if>
                            <c:if test="${not empty selectedCategory && selectedCategory ne 'All'}">
                                in category "<strong>${selectedCategory}</strong>"
                            </c:if>
                        </p>
                        <c:if test="${not empty searchTerm || not empty selectedCategory}">
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary btn-sm">
                                <i class="fas fa-times me-1"></i>Clear Filters
                            </a>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-shopping-basket me-2"></i>Fresh Grocery</h5>
                    <p class="text-muted">Your trusted partner for fresh, quality groceries delivered right to your doorstep.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="text-muted mb-0">&copy; 2024 Fresh Grocery. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-submit form on category change
        document.getElementById('category').addEventListener('change', function() {
            this.form.submit();
        });

        // Update cart count in navigation (if needed)
        function updateCartCount() {
            // This would be called after adding items to cart
            // Implementation depends on how you handle cart updates
        }
    </script>
</body>
</html>