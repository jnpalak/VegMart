<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.yash.vegmart.entity.Vegetable" %>
<%@ page import="com.yash.vegmart.service.ProductService" %>
<%@ page import="com.yash.vegmart.serviceimpl.ProductServiceImpl" %>
<%@ page import="com.yash.vegmart.entity.Category" %>
<%@ page import="com.yash.vegmart.service.CategoryService" %>
<%@ page import="com.yash.vegmart.serviceimpl.CategoryServiceImpl" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>VegMart – Fresh Vegetables Delivered Fast</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background: #eaffea;
            font-family: 'Segoe UI', sans-serif;
        }

        /* HERO BANNER */
        .hero {
            background: url('https://images.unsplash.com/photo-1542838132-92c53300491e') center/cover no-repeat;
            height: 65vh;
            border-radius: 20px;
            display: flex;
            align-items: center;
            padding: 0 60px;
            color: white;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .section-title {
            font-weight: bold;
            margin-top: 50px;
            color: #2e7d32;
        }

        .veg-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
            transition: 0.3s ease-in-out;
        }

        .why-box {
            background: #e8f5e9;
            padding: 25px;
            border-radius: 12px;
            text-align: center;
        }

        .why-box i {
            color: #2e7d32;
            font-size: 35px;
        }
        .veg-card {
            border-radius: 14px;
            transition: 0.3s;
        }

    </style>
</head>

<body>

<!-- HEADER -->
<%@ include file="components/common/header.jsp" %>
<div style="background:#eaffea; min-height:100vh; padding-top:10px;">
<div class="container mt-4">

    <!-- HERO SECTION -->
    <div class="hero">
        <div>
            <h1 class="fw-bold display-5">Fresh Vegetables Delivered to Your Door</h1>
            <p class="lead mt-3">Farm-fresh, handpicked & delivered within minutes.</p>
            <a href="allproducts" class="btn btn-light btn-lg px-4">
                Shop Now
            </a>
        </div>
    </div>
<!-- DYNAMIC CATEGORY SECTION -->
<h2 class="section-title">Shop by Category</h2>

<%
    CategoryService cs = new CategoryServiceImpl();
    List<Category> catList = cs.getCategory();
%>

<div class="row row-cols-3 text-center mt-4">
  <% for (Category c : catList) { %>
  <div class="col mb-4">
    <a href="categoryProducts?catId=<%= c.getCategoryId() %>" style="text-decoration: none; color: inherit;">
      <div class="card p-4 veg-card shadow-sm">
        <img src="img/<%= c.getcImage() %>" class="rounded mb-3" height="170" style="object-fit:cover; width: 100%;">
        <h5 class="fw-bold"><%= c.getCategoryName() %></h5>
      </div>
    </a>
  </div>
  <% } %>
</div>
    <!-- TODAY'S OFFERS -->
    <h2 class="section-title">Today’s Offers</h2>
    <div class="row mt-3">

        <%
            ProductService ps = new ProductServiceImpl();
            List<Vegetable> vegList = ps.getAllProducts();
        %>

        <% int count = 0;
           for (Vegetable v : vegList) {
               if (count == 4) break;  // only show first 4 offers
               count++;
        %>

        <div class="col-md-3 mb-4">
            <div class="card p-3 veg-card">
                <img src="img/Products/<%= v.getpImage() %>" height="130" class="rounded">
                <h5 class="mt-2"><%= v.getName() %></h5>
                <p class="text-success fw-bold">₹ <%= v.getPrice() %></p>
                <span class="badge bg-danger">Save <%= v.getDiscount() %>%</span>
            </div>
        </div>

        <% } %>

    </div>


    <!-- FRESHLY ARRIVED -->
    <h2 class="section-title">Freshly Arrived Today</h2>
    <div class="row mt-3">

        <% for (Vegetable v : vegList) { %>

        <div class="col-md-3 mb-4">
            <div class="card p-3 veg-card">
                <img src="img/Products/<%= v.getpImage() %>" height="130">
                <h6 class="mt-2"><%= v.getName() %></h6>
                <p class="text-muted">Fresh stock added today</p>
            </div>
        </div>

        <% } %>
</div>
</div>
<%@ include file="components/common/footer.jsp" %>
</body>
</html>


