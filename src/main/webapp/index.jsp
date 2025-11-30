<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>VegMart – Fresh Groceries Delivered Fast</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .hero {
            background: url('https://images.unsplash.com/photo-1542838132-92c53300491e') center/cover no-repeat;
            height: 60vh;
            color: white;
            display: flex;
            align-items: center;
            padding: 0 50px;
            border-radius: 15px;
        }
        .category-card:hover {
            transform: scale(1.05);
            transition: 0.3s ease-in-out;
        }
    </style>
</head>

<body>
<%@ include file="components/header.jsp" %>

<div class="container mt-4">

    <!-- Hero Section -->
    <div class="hero shadow">
        <div>
            <h1 class="fw-bold">Fresh & Organic Groceries Delivered to Your Door</h1>
            <p class="lead">Shop vegetables, fruits, dairy, grains & more</p>
            <a href="products" class="btn btn-light btn-lg">Shop Now</a>
        </div>
    </div>

    <!-- Categories -->
    <h2 class="mt-5 mb-3">Shop by Category</h2>
    <div class="row text-center">

        <div class="col-md-3 mb-3">
            <div class="card category-card shadow-sm p-3">
                <img src="images/vegetables.jpg" class="card-img-top rounded" height="150">
                <h5 class="mt-2">Vegetables</h5>
            </div>
        </div>

        <div class="col-md-3 mb-3">
            <div class="card category-card shadow-sm p-3">
                <img src="images/fruits.jpg" class="card-img-top rounded" height="150">
                <h5 class="mt-2">Fruits</h5>
            </div>
        </div>

        <div class="col-md-3 mb-3">
            <div class="card category-card shadow-sm p-3">
                <img src="images/dairy.jpg" class="card-img-top rounded" height="150">
                <h5 class="mt-2">Dairy Products</h5>
            </div>
        </div>

        <div class="col-md-3 mb-3">
            <div class="card category-card shadow-sm p-3">
                <img src="images/grains.jpg" class="card-img-top rounded" height="150">
                <h5 class="mt-2">Grains</h5>
            </div>
        </div>

    </div>

</div>


</body>
</html>



