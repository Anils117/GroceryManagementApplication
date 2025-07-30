<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products - Admin Panel</title>
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
                    <h1 class="h2"><i class="fas fa-box me-2"></i>Manage Products</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn-success">
                            <i class="fas fa-plus me-2"></i>Add New Product
                        </a>
                    </div>
                </div>

                <!-- Success/Error Messages -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Products Table -->
                <div class="card admin-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">All Products</h5>
                        <small class="text-muted">Total: ${products.size()} products</small>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${not empty products}">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th>ID</th>
                                                <th>Image</th>
                                                <th>Product Details</th>
                                                <th>Category</th>
                                                <th>Price</th>
                                                <th>Stock</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="product" items="${products}">
                                                <tr class="${!product.active ? 'table-secondary' : ''}">
                                                    <td class="fw-bold">#${product.productId}</td>
                                                    <td>
                                                        <img src="${product.imageUrl}" alt="${product.name}" 
                                                             class="img-thumbnail" style="width: 50px; height: 50px; object-fit: cover;">
                                                    </td>
                                                    <td>
                                                        <div class="fw-bold">${product.name}</div>
                                                        <small class="text-muted">${product.description}</small>
                                                        <div class="mt-1">
                                                            <small class="text-muted">
                                                                Created: <fmt:formatDate value="${product.createdAt}" pattern="MMM dd, yyyy" />
                                                            </small>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-info">${product.category}</span>
                                                    </td>
                                                    <td>
                                                        <div class="fw-bold text-success">${product.formattedPrice}</div>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${product.stockQuantity <= 0}">
                                                                <span class="badge bg-danger">Out of Stock</span>
                                                            </c:when>
                                                            <c:when test="${product.stockQuantity <= 10}">
                                                                <span class="badge bg-warning text-dark">Low Stock (${product.stockQuantity})</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-success">${product.stockQuantity} units</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${product.active}">
                                                                <span class="badge bg-success">
                                                                    <i class="fas fa-check me-1"></i>Active
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">
                                                                    <i class="fas fa-ban me-1"></i>Inactive
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group btn-group-sm" role="group">
                                                            <!-- Edit Button -->
                                                            <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${product.productId}" 
                                                               class="btn btn-outline-primary" title="Edit Product">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            
                                                            <!-- Delete Button -->
                                                            <form method="post" action="${pageContext.request.contextPath}/admin/products" class="d-inline">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="productId" value="${product.productId}">
                                                                <button type="submit" class="btn btn-outline-danger" 
                                                                        title="Delete Product"
                                                                        onclick="return confirm('Are you sure you want to delete ${product.name}? This action cannot be undone.')">
                                                                    <i class="fas fa-trash"></i>
                                                                </button>
                                                            </form>
                                                            
                                                            <!-- View in Store Button -->
                                                            <a href="${pageContext.request.contextPath}/products?search=${product.name}" 
                                                               target="_blank" class="btn btn-outline-info" title="View in Store">
                                                                <i class="fas fa-external-link-alt"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-box-open fa-4x text-muted mb-3"></i>
                                    <h5 class="text-muted">No Products Found</h5>
                                    <p class="text-muted mb-4">Get started by adding your first product to the inventory.</p>
                                    <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn-success btn-lg">
                                        <i class="fas fa-plus me-2"></i>Add First Product
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Product Statistics Cards -->
                <c:if test="${not empty products}">
                    <div class="row mt-4">
                        <div class="col-md-3">
                            <div class="card bg-primary text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h6 class="card-title">Total Products</h6>
                                            <h3>${products.size()}</h3>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-box fa-2x opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-success text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h6 class="card-title">Active Products</h6>
                                            <h3>
                                                <c:set var="activeCount" value="0" />
                                                <c:forEach var="product" items="${products}">
                                                    <c:if test="${product.active}">
                                                        <c:set var="activeCount" value="${activeCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${activeCount}
                                            </h3>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-check-circle fa-2x opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-warning text-dark">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h6 class="card-title">Low Stock</h6>
                                            <h3>
                                                <c:set var="lowStockCount" value="0" />
                                                <c:forEach var="product" items="${products}">
                                                    <c:if test="${product.stockQuantity <= 10 && product.stockQuantity > 0}">
                                                        <c:set var="lowStockCount" value="${lowStockCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${lowStockCount}
                                            </h3>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-exclamation-triangle fa-2x opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-danger text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h6 class="card-title">Out of Stock</h6>
                                            <h3>
                                                <c:set var="outOfStockCount" value="0" />
                                                <c:forEach var="product" items="${products}">
                                                    <c:if test="${product.stockQuantity <= 0}">
                                                        <c:set var="outOfStockCount" value="${outOfStockCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${outOfStockCount}
                                            </h3>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-times-circle fa-2x opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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