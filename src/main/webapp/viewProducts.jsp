<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.yash.vegmart.entity.Vegetable" %>
<%@ page import="com.yash.vegmart.entity.Category" %>
<%@ page import="com.yash.vegmart.service.ProductService" %>
<%@ page import="com.yash.vegmart.serviceimpl.ProductServiceImpl" %>
<%@ page import="com.yash.vegmart.service.CategoryService" %>
<%@ page import="com.yash.vegmart.serviceimpl.CategoryServiceImpl" %>

<!DOCTYPE html>
<html>
<head>
    <title>View Products | Admin</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #eaffea;
            font-family: 'Segoe UI', sans-serif;
        }

        .table-box {
            background: white;
            padding: 25px;
            border-radius: 12px;
            margin-top: 30px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.1);
        }

        .table thead {
            background: #2e7d32;
            color: white;
        }

        .prod-img {
            height: 55px;
            width: 55px;
            object-fit: cover;
            border-radius: 6px;
        }

        .btn-edit {

            padding: 4px 10px;
        }

        .btn-delete {
            background: #E53935;
            color: white;
            padding: 4px 10px;
        }

        .btn-discount {
            background: #007bff;
            color: white;
            padding: 4px 10px;
        }
    </style>
</head>

<body>

<!-- HEADER -->
<%@ include file="components/common/header.jsp" %>
<div style="background:#eaffea; min-height:100vh; padding-top:10px;">
<div class="container">
    <div class="table-box">
        <h3 class="fw-bold mb-4 text-success text-center">View Product</h3>

        <%
            ProductService ps = new ProductServiceImpl();
            CategoryService cs = new CategoryServiceImpl();
            List<Vegetable> vegList = ps.getAllProducts();
        %>

        <table class="table table-bordered align-middle text-center">
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Title</th>
                    <th>Stock</th>
                    <th>Category</th>
                    <th>Original Price</th>
                    <th>Discount</th>
                    <th>Discount Price</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody>
            <% for (Vegetable v : vegList) { %>
                <tr>
                    <td>
                        <img src="img/Products/<%= v.getpImage() %>" class="prod-img">
                    </td>

                    <td><%= v.getName() %></td>

                    <td><%= v.getQuantityInStock() %></td>

                    <td><%= v.getCategory().getCategoryName() %></td>

                    <td>₹ <%= v.getPrice() %></td>

                    <td><%= v.getDiscount() %> %</td>

                    <td>
                        ₹ <%= v.getPriceAfterDis() %>
                    </td>

                    <td>
                        <a href="editProduct.jsp?pid=<%= v.getVegetableId()%>" class="btn btn-primary btn-sm fw-bold me-2">Edit</a>
                        <a href="DeleteProductServlet?pid=<%= v.getVegetableId()%>"
                           class="btn btn-danger btn-sm fw-bold me-2"
                           onclick="return confirm('Are you sure to delete this product?');">
                           Delete
                        </a>
                        <a href="applyDiscount.jsp?pid=<%= v.getVegetableId() %>" class="btn btn-warning btn-sm fw-bold">Discount</a>

                    </td>
                </tr>
            <% } %>

            </tbody>
        </table>
        <div class="d-flex justify-content-center mt-3">
<a href="javascript:history.back()" class="btn btn-outline-success " style="width:50%;"> Back </a></div>
    </div>
</div>
</div>

<%@ include file="components/common/footer.jsp" %>
</body>
</html>