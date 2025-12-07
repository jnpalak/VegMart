<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.yash.vegmart.entity.CartItem" %>
<%@ page import="com.yash.vegmart.entity.User" %>

<%

    User u3= (User) session.getAttribute("userObj");

    if (u3 == null) {
        session.setAttribute("msg", "Please login first!");
        response.sendRedirect("login.jsp");
        return;

    }

    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

    if (cart == null) cart = new HashMap<>();

    double amount = 0;

    for (CartItem ci : cart.values()) {

        amount += ci.getTotalPrice();

    }
    double shipping = (amount > 500) ? 0 : 50; // Free above 500
    double tax = amount * 0.05;               // 5% tax
    double grandTotal = amount + shipping + tax;
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

    body {

        background: #eaffea !important;

        font-family: "Segoe UI", sans-serif;

    }

    .address-box, .summary-box {

        background: white;

        padding: 20px;

        border-radius: 12px;

        box-shadow: 0 6px 18px rgba(0,0,0,0.1);

    }

    .summary-label {

        font-weight: 600;

        color: #2e7d32;

    }

    .place-btn {

        background: #2e7d32;

        color: white;

        font-weight: 600;

        width: 100%;

        font-size: 18px;

        padding: 10px;

    }

    .header-green {

        background-color: #2e7d32 !important;
        color: white !important;

    }
</style>

<%@ include file="components/common/header.jsp" %>

<div class="container my-5">

    <h2 class="text-center fw-bold mb-4 ">Checkout Page</h2>

    <div class="row">

        <!-- LEFT SIDE: CART LIST -->
<div class="col-md-7">

            <table class="table table-bordered text-center align-middle">
<thead class="header-green">
<tr>
<th>Image</th>
<th>Name</th>
<th>Price</th>
<th>Quantity</th>
<th>Total Price</th>
</tr>
</thead>

                <tbody>
<% for (CartItem ci : cart.values()) { %>
<tr>
<td><img src="img/Products/<%= ci.getImage() %>" width="60"></td>
<td><%= ci.getName() %></td>
<td>₹ <%= ci.getPrice() %></td>
<td>[ <%= ci.getQuantity() %> ]</td>
<td>₹ <%= ci.getTotalPrice() %></td>
</tr>
<% } %>
</tbody>
</table>

            <!-- BACK & CONTINUE BUTTONS -->
<div class="text-center mt-4">
<a href="index.jsp" class="btn btn-success px-4">Continue</a>
<a href="javascript:history.back()" class="btn btn-outline-success px-4"> Back </a>
</div>

        </div>

        <!-- RIGHT SIDE -->
<div class="col-md-5">

            <!-- Delivery Address -->
<div class="address-box mb-3">
<h5 class="summary-label mb-3">Delivery Address</h5>

                <p><b><%= u.getName() %></b></p>
<p><%= u.getAddress() %></p>
<p>Mobile No: <%= u.getMobile() %></p>

                <a href="profile.jsp" class="text-primary fw-bold">Change Address</a>
</div>

            <!-- PAYMENT SUMMARY -->
<div class="summary-box mb-3" id="paymentSection">

                <h5 class="summary-label mb-3">Payment</h5>

                <p>Amount: <span class="float-end">₹ <%= amount %></span></p>
<p>Shipping Charge:
<span class="float-end">
<%= (shipping == 0) ? "FREE" : "₹ " + shipping %>
</span>
</p>
<p>Tax (5%): <span class="float-end">₹ <%= String.format("%.2f", tax) %></span></p>

                <hr>

                <h5>Total Amount:
<span class="float-end fw-bold">₹ <%= String.format("%.2f", grandTotal) %></span>
</h5>

                <form action="PlaceOrderServlet" method="post" class="mt-4">

                    <label class="form-label fw-bold">Payment Mode</label>
<select class="form-control mb-3" name="paymentMode" required>
<option value="">-- Select --</option>
<option value="COD">Cash On Delivery</option>
<option value="ONLINE">Online Payment</option>
</select>

                    <button class="place-btn">Place Order</button>
</form>

            </div>

        </div>

    </div>
</div>

<%@ include file="components/common/footer.jsp" %>

