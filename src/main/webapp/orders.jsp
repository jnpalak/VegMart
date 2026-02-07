<%@ page import="java.util.*" %>
<%@ page import="com.yash.vegmart.entity.*" %>
<%@ page import="com.yash.vegmart.service.OrderService" %>
<%@ page import="com.yash.vegmart.serviceimpl.OrderServiceImpl" %>


<%
    User u5 = (User) session.getAttribute("userObj");
    if (u5 == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    OrderService os = new OrderServiceImpl();
    List<Order> list = os.getOrdersByUser(u5.getUserId());
%>

<!DOCTYPE html>
<html>
<head>
<title>Your Orders</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {  background: #eaffea !important; font-family: Segoe UI; }

.table-box {
    background:white;
    padding:20px;
    border-radius:14px;
    box-shadow:0 6px 20px rgba(0,0,0,0.1);
}
</style>

</head>
<body>

<%@ include file="components/common/header.jsp" %>

<div class="container mt-4">
<h2 class="text-center fw-bold mb-4">Your Orders</h2>

<div class="table-box">

<table class="table table-bordered text-center align-middle">
<thead class="table-success">
<tr>
<th>Order Date</th>
<th>Order ID</th>
<th>Product Details</th>
<th>Quantity</th>
<th>Total Price</th>
<th>Payment Type</th>
<th>Status</th>
</tr>
</thead>

<tbody>
<%
for (Order o : list) {
    for (OrderItem oi : o.getItems()) {
%>
<tr>
<td><%= o.getOrderDate() %></td>

    <td class="fw-bold text-success">
        PROD-ORD-00<%= o.getOrderId() %>
</td>

    <td><%= oi.getVegetable().getName() %></td>
<td><%= oi.getQuantity() %></td>

    <td> &#8377; <%= oi.getVegetable().getPrice() * oi.getQuantity() %></td>

    <td><%= o.getPaymentMode() %></td>

    <td><%= o.getStatus() %></td>
</tr>
<%
    }
}
%>
</tbody>
</table>
<div class="text-center mt-4">
<a href="javascript:history.back()" class="btn btn-outline-success px-4"> Back </a>
</div>
</div>
</div>
<%@ include file="components/common/footer.jsp" %>
</body>
</html>