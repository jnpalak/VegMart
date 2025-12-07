<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.yash.vegmart.entity.Vegetable" %>
<%@ page import="com.yash.vegmart.service.ProductService" %>
<%@ page import="com.yash.vegmart.serviceimpl.ProductServiceImpl" %>

<%

    int pid = Integer.parseInt(request.getParameter("pid"));

    ProductService ps = new ProductServiceImpl();

    Vegetable product = ps.getProductById(pid);

    String msg = (String) session.getAttribute("msg");

    session.removeAttribute("msg");

%>

<!DOCTYPE html>
<html>
<head>
<title>Add Discount</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        body {

            background: #eaffea !important;

            font-family: 'Segoe UI', sans-serif;

        }

        .box {

            max-width: 500px;
            min-height : 400px;
            background: #ffffff;

            margin: 60px auto;

            padding: 25px 30px;

            border-radius: 12px;

            box-shadow: 0 5px 18px rgba(0,0,0,0.15);

        }

        .box h3 {

            text-align: center;

            font-weight: 700;

            margin-bottom: 10px;

            color: #2e7d32;

        }

        .err {

            color: red;

            font-size: 15px;

            text-align: center;

            margin-bottom: 10px;

        }

        .form-label {

            font-weight: 600;

            margin-top: 8px;

        }

        .btn-add {

            width: 100%;
            color: white;
            padding: 10px;
            margin-top: 12px;
            font-weight: 600;
            border-radius: 6px;

        }
</style>
</head>

<body>
<%@ include file="components/common/header.jsp" %>
<div class="box">

    <h3>Add Discount</h3>

    <% if (msg != null) { %>
<div class="err"><%= msg %></div>
<% } %>

    <form action="ApplyDiscountServlet" method="post">
<input type="hidden" name="pid" value="<%= product.getVegetableId() %>">

        <label class="form-label">Product Name</label>
<input type="text" class="form-control" value="<%= product.getName() %>" readonly>

        <label class="form-label">Price</label>
<input type="text" class="form-control" value="<%= product.getPrice() %>" readonly>

        <label class="form-label">Discount (%)</label>
<input type="number" class="form-control" name="discount" required min="0" max="90">

        <button type="submit" class="btn btn-success" style="width: 40%; color: white; padding: 10px; margin-top: 12px; font-weight: 600; border-radius: 6px;">Add</button>
       &nbsp; &nbsp; <a href="javascript:history.back()" class="btn btn-outline-success " style="width: 50%;padding: 10px; margin-top: 12px; font-weight: 600; border-radius: 6px;"> Back </a>
</form>

</div>

</body>
</html>

