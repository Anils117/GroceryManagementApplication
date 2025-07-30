<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found - Fresh Grocery Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-shopping-basket me-2"></i>
                Fresh Grocery
            </a>
        </div>
    </nav>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-6 text-center">
                <div class="mb-4">
                    <i class="fas fa-exclamation-triangle fa-5x text-warning"></i>
                </div>
                <h1 class="display-4 fw-bold text-danger mb-3">404</h1>
                <h2 class="h3 text-muted mb-4">Page Not Found</h2>
                <p class="lead text-muted mb-4">
                    The page you're looking for doesn't exist or has been moved.
                </p>
                <div class="d-flex gap-3 justify-content-center flex-wrap">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-success btn-lg">
                        <i class="fas fa-home me-2"></i>Go Home
                    </a>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-success btn-lg">
                        <i class="fas fa-store me-2"></i>Browse Products
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 