<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.yash.vegmart.entity.CartItem" %>

<%
    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
    if (cart == null) cart = new HashMap<>();
    double total = 0;
%>

<!-- BOOTSTRAP CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<div style="background:#eaffea; min-height:100vh; padding-top:10px;">
<div class="container my-5">

    <!-- PAGE HEADING -->
    <h2 class="text-center fw-bold mb-4">Checkout</h2>

    <div class="row">

        <!-- LEFT SIDE: ORDER SUMMARY -->
        <div class="col-md-6">

            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">Your Selected Items</h5>
                </div>

                <div class="card-body">

                    <table class="table table-striped text-center">
                        <thead class="table-success">
                            <tr>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Qty</th>
                                <th>Total</th>
                            </tr>
                        </thead>

                        <tbody>
                        <% for (CartItem ci : cart.values()) {
                            total += ci.getTotalPrice();
                        %>
                            <tr>
                                <td><%= ci.getName() %></td>
                                <td>₹ <%= ci.getPrice() %></td>
                                <td><%= ci.getQuantity() %></td>
                                <td>₹ <%= ci.getTotalPrice() %></td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>

                    <h4 class="text-end fw-bold"> Total Price : ₹ <%= total %></h4>

                </div>
            </div>

        </div>

        <!-- RIGHT SIDE: USER DETAILS -->
        <div class="col-md-6">

            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">Your Details for Order</h5>
                </div>

                <div class="card-body">

                    <form action="Checkout" method="post">

                        <div class="mb-3">
                            <label class="form-label fw-bold">Email Address</label>
                            <input class="form-control" name="email" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Full Name</label>
                            <input class="form-control" name="name" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Contact Number</label>
                            <input class="form-control" name="contact" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Shipping Address</label>
                            <textarea class="form-control" name="address" rows="3" required></textarea>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="index.jsp" class="btn btn-secondary">Continue Shopping</a>
                            <button class="btn btn-success px-4">Place Order</button>
                        </div>

                    </form>

                </div>
            </div>

        </div>

    </div>

</div>