<%@ page import="java.util.*" %>
<%@ page import="com.yash.vegmart.entity.*" %>
<%@ page import="com.yash.vegmart.service.OrderService" %>
<%@ page import="com.yash.vegmart.serviceimpl.OrderServiceImpl" %>

<%

    User admin = (User) session.getAttribute("userObj");

    if (admin == null || !"admin".equals(admin.getUserType())) {

        session.setAttribute("msg", "Access denied!");

        response.sendRedirect("login.jsp");

        return;

    }
    OrderService os = new OrderServiceImpl();

    List<Order> list = os.getAllOrders();

%>

<!DOCTYPE html>
<html>
<head>
<title>Customer Orders</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body {
 background: #eaffea !important;
  font-family: Segoe UI;
 }

.table-box {

    background:white;

    padding:20px;

    border-radius:14px;

    box-shadow:0 6px 20px rgba(0,0,0,0.1);

}

/* Status Colors */

.status-processing { color:#ff9800; font-weight:600; }

.status-received { color:#0288d1; font-weight:600; }

.status-packed { color:#7b1fa2; font-weight:600; }

.status-delivery { color:#e65100; font-weight:600; }

.status-delivered { color:#2e7d32; font-weight:600; }
</style>

</head>

<body>
<%@ include file="components/common/header.jsp" %>

<div class="container mt-4">
<h2 class="text-center fw-bold mb-4">Customer Orders</h2>

<div class="table-box">

<table class="table table-bordered text-center align-middle">
<thead class="table-success">
<tr>
<th>Order Date</th>
<th>Order ID</th>
<th>Delivery Address</th>
<th>Product Details</th>
<th>Payment Type</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>

<tbody>
<%

for (Order o : list) {

%>
<tr>
<td><%= o.getOrderDate() %></td>

    <td class="fw-bold text-success">

        PROD-ORD-00<%= o.getOrderId() %>
</td>

    <td>
<b><%= o.getUser().getName() %></b><br>
<%= o.getUser().getAddress() %> <br>

        Mob: <%= o.getUser().getMobile() %>
</td>

    <td style="text-align:left; line-height: 22px;">
    <% for (OrderItem oi : o.getItems()) { %>
    <div style="margin-bottom:4px;">
    <b><%= oi.getVegetable().getName() %></b>
    &nbsp; | &nbsp;
                Qty: <%= oi.getQuantity() %>
    &nbsp; | &nbsp;
     &#8377;  <%= oi.getVegetable().getPrice() * oi.getQuantity() %>
    </div>
    <% } %>
    </td>
    <td><%= o.getPaymentMode() %></td>

    <td>
<% String st = o.getStatus();

           String cls = "";

           if (st.contains("Processing")) cls = "status-processing";

           else if (st.contains("Received")) cls = "status-received";

           else if (st.contains("Packed")) cls = "status-packed";

           else if (st.contains("Out")) cls = "status-delivery";

           else if (st.contains("Delivered")) cls = "status-delivered";
           else st = "Order Processing";

        %>

        <span class="<%= cls %>"><%= st %></span>
</td>

    <td>
<form action="UpdateOrderStatusServlet" method="post">
<input type="hidden" name="orderId" value="<%= o.getOrderId() %>">
<select name="status" class="form-select mb-2">
<option>Order Processing</option>
<option>Order Received</option>
<option>Order Packed</option>
<option>Out for Delivery</option>
<option>Order Delivered</option>
</select>
<button class="btn btn-primary btn-sm w-100">Update</button>
</form>
</td>

</tr>
<% } %>

</tbody>
</table>
<div class="text-center mt-4">
<a href="javascript:history.back()" class="btn btn-outline-success px-4"> Back </a>
</div>
</div>
</div>

</body>
</html>

