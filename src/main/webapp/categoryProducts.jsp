<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.yash.vegmart.entity.Vegetable" %>
<%@ page import="com.yash.vegmart.entity.Category" %>
<%@ page import="com.yash.vegmart.utilities.Helper" %>

<%
    List<Category> allCategories = (List<Category>) request.getAttribute("allCategories");
    Category currentCategory = (Category) request.getAttribute("category");
    List<Vegetable> vegList = (List<Vegetable>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>VegMart | Category Products</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body {
            background: #eaffea;
            font-family: 'Segoe UI', sans-serif;
        }

        .sidebar-box {
            background: white;
            padding: 18px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            min-height: 350px;
        }

        .sidebar-box a {
            display: block;
            padding: 10px 12px;
            text-decoration: none;
            color: #333;
            margin-bottom: 6px;
            border-radius: 6px;
        }

        .sidebar-box a.active {
            background: #2e8b57 !important;
            color: white !important;
        }

        .product-card {
            background: white;
            border-radius: 12px;
            padding: 18px;
            min-height: 420px;    /* instead of fixed height */
            box-shadow: 0 4px 12px rgba(0,0,0,0.12);
            transition: 0.3s;
            display: flex;
            flex-direction: column;
            justify-content: space-between;   /* keeps buttons at bottom */
        }

        .product-img {
            height: 180px;
            width: 100%;
            object-fit: cover;
            border-radius: 10px;
        }

        .desc-short {
            font-size: 14px;
            color: #444;
        }

        .desc-full {
            display: none;
            font-size: 14px;
            color: #444;
        }

        .read-more {
            color: #2e8b57;
            cursor: pointer;
            font-weight: 600;
            margin-top: -14px;
            font-size: 14px;
        }

        .cart-btn, .price-btn {
            background: #2e8b57 !important;
            color: white !important;
        }
        .discount-label
        {
          font-size: 13px !important;
          font-style : italic !important;
          color: white !important;
        }
    </style>
</head>

<body>

<%@ include file="components/common/header.jsp" %>
<div style="background:#eaffea; min-height:100vh; padding-top:10px;">
<div class="container mt-4">
    <div class="row">

        <!-- SIDEBAR -->
        <div class="col-md-3">
            <div class="sidebar-box">
                <h5 class="fw-bold mb-3">All Categories</h5>

                <% for (Category c : allCategories) { %>

                    <a href="categoryProducts?catId=<%= c.getCategoryId() %>"
                       class="<%= (currentCategory.getCategoryId() == c.getCategoryId()) ? "active" : "" %>">
                        <%= c.getCategoryName() %>
                    </a>

                <% } %>

            </div>
        </div>

        <!-- PRODUCT GRID -->
        <div class="col-md-9">
            <h3 class="fw-bold text-success mb-4"><%= currentCategory.getCategoryName() %></h3>

            <div class="row g-4">

                <% int index = 0;
                for (Vegetable veg : vegList) {
                    String shortDesc = Helper.get35Words(veg.getDescription());
                    String fullDesc = veg.getDescription();
                %>

                <div class="col-md-4">
                  <div class="product-card">

                      <img src="img/Products/<%= veg.getpImage() %>" class="product-img">

                      <div>
                          <h6 class="fw-bold mt-2"><%= veg.getName() %></h6>

                          <p class="desc-short" id="short<%= index %>"><%= shortDesc %></p>
                          <p class="desc-full" id="full<%= index %>"><%= fullDesc %></p>

                          <p class="read-more" onclick="toggleDesc(<%= index %>)" id="btn<%= index %>">
                              Read More
                          </p>
                      </div>

                      <div class="d-flex justify-content-between mt-3">
                          <button class="btn cart-btn btn-sm w-50 me-2">Add to Cart</button>
                          <button class="btn price-btn btn-sm w-50">
                              &#8377;<%= veg.getPriceAfterDis() %>/-
                              <span class="discount-label" style="text-decoration: line-through;">
                                  &#8377;<%= veg.getPrice() %><br>
                              </span>
                              <span class="discount-label">
                                   <%= veg.getDiscount() %>% off
                              </span>
                          </button>
                          </div>

                  </div>
                </div>

                <% index++; } %>

            </div>
        </div>

    </div>
</div>

<!-- JAVASCRIPT FOR READ MORE / LESS -->
<script>
    function toggleDesc(i) {
        let shortText = document.getElementById("short" + i);
        let fullText = document.getElementById("full" + i);
        let btn = document.getElementById("btn" + i);

        if (fullText.style.display === "none") {
            fullText.style.display = "block";
            shortText.style.display = "none";
            btn.innerText = "Read Less";
        } else {
            fullText.style.display = "none";
            shortText.style.display = "block";
            btn.innerText = "Read More";
        }
    }
</script>
</div>
</body>
</html>