<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product != null ? 'Edit Product' : 'Add New Product'} - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Admin Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-user-shield me-2"></i>Admin Panel
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/" target="_blank">
                    <i class="fas fa-external-link-alt me-1"></i>View Store
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block admin-sidebar">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users me-2"></i>Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/products">
                                <i class="fas fa-box me-2"></i>Products
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas ${product != null ? 'fa-edit' : 'fa-plus'} me-2"></i>
                        ${product != null ? 'Edit Product' : 'Add New Product'}
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Back to Products
                        </a>
                    </div>
                </div>

                <!-- Error Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Product Form -->
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card admin-card">
                            <div class="card-header">
                                <h5 class="mb-0">Product Information</h5>
                            </div>
                            <div class="card-body">
                                <form method="post" action="${pageContext.request.contextPath}/admin/products" id="productForm">
                                    <input type="hidden" name="action" value="${product != null ? 'update' : 'save'}">
                                    <c:if test="${product != null}">
                                        <input type="hidden" name="productId" value="${product.productId}">
                                    </c:if>

                                    <!-- Product Name -->
                                    <div class="mb-3">
                                        <label for="name" class="form-label">
                                            <i class="fas fa-tag me-1"></i>Product Name *
                                        </label>
                                        <input type="text" class="form-control" id="name" name="name" 
                                               value="${product != null ? product.name : name}" 
                                               required placeholder="Enter product name" maxlength="100">
                                        <div class="form-text">Enter a clear, descriptive product name</div>
                                    </div>

                                    <!-- Product Description -->
                                    <div class="mb-3">
                                        <label for="description" class="form-label">
                                            <i class="fas fa-align-left me-1"></i>Description *
                                        </label>
                                        <textarea class="form-control" id="description" name="description" 
                                                  rows="4" required placeholder="Enter product description" 
                                                  maxlength="500">${product != null ? product.description : description}</textarea>
                                        <div class="form-text">Provide detailed information about the product</div>
                                    </div>

                                    <div class="row">
                                        <!-- Category -->
                                        <div class="col-md-6 mb-3">
                                            <label for="category" class="form-label">
                                                <i class="fas fa-list me-1"></i>Category *
                                            </label>
                                            <select class="form-select" id="category" name="category" required>
                                                <option value="">Select Category</option>
                                                <option value="Fruits" ${(product != null && product.category == 'Fruits') || category == 'Fruits' ? 'selected' : ''}>
                                                    🍎 Fruits
                                                </option>
                                                <option value="Vegetables" ${(product != null && product.category == 'Vegetables') || category == 'Vegetables' ? 'selected' : ''}>
                                                    🥕 Vegetables
                                                </option>
                                                <option value="Dairy" ${(product != null && product.category == 'Dairy') || category == 'Dairy' ? 'selected' : ''}>
                                                    🥛 Dairy
                                                </option>
                                                <option value="Meat" ${(product != null && product.category == 'Meat') || category == 'Meat' ? 'selected' : ''}>
                                                    🥩 Meat
                                                </option>
                                                <option value="Bakery" ${(product != null && product.category == 'Bakery') || category == 'Bakery' ? 'selected' : ''}>
                                                    🍞 Bakery
                                                </option>
                                                <option value="Beverages" ${(product != null && product.category == 'Beverages') || category == 'Beverages' ? 'selected' : ''}>
                                                    🥤 Beverages
                                                </option>
                                                <option value="Snacks" ${(product != null && product.category == 'Snacks') || category == 'Snacks' ? 'selected' : ''}>
                                                    🍿 Snacks
                                                </option>
                                                <option value="Pantry" ${(product != null && product.category == 'Pantry') || category == 'Pantry' ? 'selected' : ''}>
                                                    🥫 Pantry
                                                </option>
                                            </select>
                                        </div>

                                        <!-- Price -->
                                        <div class="col-md-6 mb-3">
                                            <label for="price" class="form-label">
                                                <i class="fas fa-dollar-sign me-1"></i>Price ($) *
                                            </label>
                                            <input type="number" class="form-control" id="price" name="price" 
                                                   value="${product != null ? product.price : price}" 
                                                   required step="0.01" min="0.01" max="999.99" 
                                                   placeholder="0.00">
                                            <div class="form-text">Enter price in USD (e.g., 4.99)</div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <!-- Stock Quantity -->
                                        <div class="col-md-6 mb-3">
                                            <label for="stockQuantity" class="form-label">
                                                <i class="fas fa-boxes me-1"></i>Stock Quantity *
                                            </label>
                                            <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" 
                                                   value="${product != null ? product.stockQuantity : stockQuantity}" 
                                                   required min="0" max="9999" placeholder="0">
                                            <div class="form-text">Available units in inventory</div>
                                        </div>

                                        <!-- Status -->
                                        <div class="col-md-6 mb-3">
                                            <label for="isActive" class="form-label">
                                                <i class="fas fa-toggle-on me-1"></i>Status
                                            </label>
                                            <select class="form-select" id="isActive" name="isActive">
                                                <option value="true" ${(product != null && product.active) || isActive == 'true' ? 'selected' : ''}>
                                                    ✅ Active (Visible to customers)
                                                </option>
                                                <option value="false" ${(product != null && !product.active) || isActive == 'false' ? 'selected' : ''}>
                                                    ❌ Inactive (Hidden from customers)
                                                </option>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- Image URL -->
                                    <div class="mb-4">
                                        <label for="imageUrl" class="form-label">
                                            <i class="fas fa-image me-1"></i>Product Image URL
                                        </label>
                                        <input type="url" class="form-control" id="imageUrl" name="imageUrl" 
                                               value="${product != null ? product.imageUrl : imageUrl}" 
                                               placeholder="https://example.com/product-image.jpg">
                                        <div class="form-text">
                                            Enter a valid image URL. If left empty, a default placeholder will be used.
                                        </div>
                                    </div>

                                    <!-- Form Actions -->
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-success btn-lg">
                                            <i class="fas fa-save me-2"></i>
                                            ${product != null ? 'Update Product' : 'Add Product'}
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary btn-lg">
                                            <i class="fas fa-times me-2"></i>Cancel
                                        </a>
                                        <c:if test="${product != null}">
                                            <button type="button" class="btn btn-outline-info btn-lg ms-auto" onclick="previewProduct()">
                                                <i class="fas fa-eye me-2"></i>Preview
                                            </button>
                                        </c:if>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Product Preview -->
                    <div class="col-lg-4">
                        <div class="card admin-card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-eye me-2"></i>Live Preview
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="product-preview">
                                    <div class="text-center mb-3">
                                        <img id="previewImage" 
                                             src="${product != null && product.imageUrl != null ? product.imageUrl : 'https://via.placeholder.com/200x200?text=Product+Image'}" 
                                             alt="Product Preview" 
                                             class="img-fluid rounded shadow-sm" 
                                             style="max-height: 200px; object-fit: cover;">
                                    </div>
                                    <h6 id="previewName" class="fw-bold text-success">
                                        ${product != null ? product.name : 'Product Name'}
                                    </h6>
                                    <p id="previewDescription" class="text-muted small">
                                        ${product != null ? product.description : 'Product description will appear here...'}
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span id="previewPrice" class="fw-bold text-success fs-5">
                                            $${product != null ? product.formattedPrice : '0.00'}
                                        </span>
                                        <span id="previewCategory" class="badge bg-info">
                                            ${product != null ? product.category : 'Category'}
                                        </span>
                                    </div>
                                    <div class="mt-2">
                                        <small id="previewStock" class="text-muted">
                                            Stock: ${product != null ? product.stockQuantity : 0} units
                                        </small>
                                    </div>
                                    <div class="mt-3">
                                        <button class="btn btn-success btn-sm w-100" disabled>
                                            <i class="fas fa-cart-plus me-1"></i>Add to Cart
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Tips -->
                        <div class="card mt-3 border-info">
                            <div class="card-header bg-info text-white">
                                <h6 class="mb-0">
                                    <i class="fas fa-lightbulb me-2"></i>Quick Tips
                                </h6>
                            </div>
                            <div class="card-body">
                                <ul class="list-unstyled mb-0 small">
                                    <li class="mb-2">
                                        <i class="fas fa-check text-success me-1"></i>
                                        Use clear, descriptive product names
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-check text-success me-1"></i>
                                        Include key details in descriptions
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-check text-success me-1"></i>
                                        Use high-quality product images
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-check text-success me-1"></i>
                                        Set competitive pricing
                                    </li>
                                    <li>
                                        <i class="fas fa-check text-success me-1"></i>
                                        Keep stock quantities updated
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Live preview updates
        function updatePreview() {
            const name = document.getElementById('name').value || 'Product Name';
            const description = document.getElementById('description').value || 'Product description will appear here...';
            const price = document.getElementById('price').value || '0.00';
            const category = document.getElementById('category').value || 'Category';
            const stock = document.getElementById('stockQuantity').value || '0';
            const imageUrl = document.getElementById('imageUrl').value || 'https://via.placeholder.com/200x200?text=Product+Image';

            document.getElementById('previewName').textContent = name;
            document.getElementById('previewDescription').textContent = description;
            document.getElementById('previewPrice').textContent = '$' + parseFloat(price).toFixed(2);
            document.getElementById('previewCategory').textContent = category;
            document.getElementById('previewStock').textContent = 'Stock: ' + stock + ' units';
            document.getElementById('previewImage').src = imageUrl;
        }

        // Add event listeners for live preview
        document.getElementById('name').addEventListener('input', updatePreview);
        document.getElementById('description').addEventListener('input', updatePreview);
        document.getElementById('price').addEventListener('input', updatePreview);
        document.getElementById('category').addEventListener('change', updatePreview);
        document.getElementById('stockQuantity').addEventListener('input', updatePreview);
        document.getElementById('imageUrl').addEventListener('input', updatePreview);

        // Handle image load errors
        document.getElementById('previewImage').addEventListener('error', function() {
            this.src = 'https://via.placeholder.com/200x200?text=Invalid+Image+URL';
        });

        // Form validation
        document.getElementById('productForm').addEventListener('submit', function(e) {
            const price = parseFloat(document.getElementById('price').value);
            const stock = parseInt(document.getElementById('stockQuantity').value);

            if (price <= 0) {
                e.preventDefault();
                alert('Price must be greater than 0');
                document.getElementById('price').focus();
                return;
            }

            if (stock < 0) {
                e.preventDefault();
                alert('Stock quantity cannot be negative');
                document.getElementById('stockQuantity').focus();
                return;
            }
        });

        // Preview product function
        function previewProduct() {
            const name = document.getElementById('name').value;
            if (name) {
                const searchUrl = '${pageContext.request.contextPath}/products?search=' + encodeURIComponent(name);
                window.open(searchUrl, '_blank');
            } else {
                alert('Please enter a product name first');
            }
        }

        // Auto-dismiss alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>