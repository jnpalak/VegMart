<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.yash.vegmart.entity.Vegetable" %>
<%@ page import="com.yash.vegmart.service.ProductService" %>
<%@ page import="com.yash.vegmart.serviceimpl.ProductServiceImpl" %>
<%@ page import="com.yash.vegmart.service.CategoryService" %>
<%@ page import="com.yash.vegmart.serviceimpl.CategoryServiceImpl" %>
<%@ page import="com.yash.vegmart.entity.Category" %>
<%@ page import="java.util.*" %>

<%
    int pid = Integer.parseInt(request.getParameter("pid"));

    ProductService ps = new ProductServiceImpl();
    Vegetable product = ps.getProductById(pid);

    CategoryService cs = new CategoryServiceImpl();
    List<Category> catList = cs.getCategory();
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Product | Admin</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>

    <style>
        body {
            background: #eaffea !important;
        }
        .edit-box {
            max-width: 700px;
            min-height:600px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        .prod-img {
            height: 80px;
        }
</style>

</head>
<body>

<%@ include file="components/common/header.jsp" %>

<div class="edit-box">
<h3 class="text-center text-success fw-bold mb-4">Edit Product</h3>

    <form action="UpdateProductServlet" method="post" enctype="multipart/form-data">

        <input type="hidden" name="pid" value="<%= product.getVegetableId() %>">

        <!-- Title -->
<label class="fw-bold">Enter Title</label>
<input type="text" name="title" value="<%= product.getName() %>" class="form-control mb-3" required>

        <!-- Description -->
<label class="fw-bold">Enter Description</label>
<textarea name="description" class="form-control mb-3" rows="5" required><%= product.getDescription() %></textarea>

        <!-- Category -->
<label class="fw-bold">Select Category</label>
<select name="categoryId" class="form-control mb-3" required>
<% for (Category c : catList) { %>
<option value="<%= c.getCategoryId() %>"
<%= (c.getCategoryId() == product.getCategory().getCategoryId()) ? "selected" : "" %>>
<%= c.getCategoryName() %>
</option>
<% } %>
</select>

        <!-- Price -->
<label class="fw-bold">Enter Price</label>
<input type="number" name="price" value="<%= product.getPrice() %>" class="form-control mb-3" required>

        <!-- Stock -->
<label class="fw-bold">Enter Stock</label>
<input type="number" name="stock" value="<%= product.getQuantityInStock() %>" class="form-control mb-3" required>

        <!-- Image -->
<label class="fw-bold">Product Image</label>
<div class="mb-3">
<img src="img/Products/<%= product.getpImage() %>" class="prod-img mb-2">
<input type="file" name="image" class="form-control">
</div>


        <!-- Submit -->
<div class="text-center mt-4">
<button class="btn btn-success px-4">Update Product</button> &nbsp; &nbsp;
<a href="javascript:history.back()" class="btn btn-outline-success px-4"> Back </a>
</div>
</form>

</div>

<%@ include file="components/common/footer.jsp" %>

</body>
</html>