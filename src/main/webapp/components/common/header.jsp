<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.yash.vegmart.entity.User" %>
<%@ page import="java.util.*" %>
<%@ page import="com.yash.vegmart.entity.CartItem" %>
<%@ page import="com.yash.vegmart.utilities.CartUtils" %>

<!-- BOOTSTRAP CSS (MOST IMPORTANT) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- BOOTSTRAP ICONS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<nav class="navbar navbar-expand-lg bg-white shadow-sm sticky-top p-3">
    <div class="container">

        <!-- Brand -->
        <a class="navbar-brand fw-bold text-success fs-3" href="index.jsp">VegMart</a>

        <!-- Toggler -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">

            <!-- LEFT ITEMS -->
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" style="color:black;" href="index.jsp">
                        <i class="bi bi-house-door-fill"></i> Home
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" style="color:black;" href="allproducts">Vegetables</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" style="color:black;" href="about.jsp">About</a>
                </li>
            </ul>

            <!-- SEARCH -->
            <form action="searchProducts" method="get" class="d-flex me-3">
                <input class="form-control form-control-sm"
                       style="width:300px;" name="keyword"
                       placeholder="Search vegetables...">
            </form>

           <div class="d-flex align-items-center">

               <!-- CART BUTTON (Always Visible) -->
               <button class="btn btn-outline-success btn-sm me-3"
                       data-bs-toggle="modal" data-bs-target="#cartModal" id="cartButtonNav">
                   <i class="bi bi-cart"></i> Cart
                   <span class="badge bg-success" id="cartCount">
                       <%= (session.getAttribute("cart") == null)
                               ? 0
                               : ((java.util.Map)session.getAttribute("cart")).size() %>
                   </span>
               </button>

               <%
                   User user = (User) session.getAttribute("userObj");

                   if (user == null) {
               %>

                   <a  href="login.jsp" class="btn btn-outline-success btn-sm me-2 px-3">Login</a>
                   <a  href="register.jsp" class="btn btn-outline-success btn-sm  me-2px-3">Sign Up</a>

               <%
                   } else if (user.getUserType().equals("admin")) {
               %>

               <div class="dropdown">
                   <button class="btn btn-outline-success btn-sm dropdown-toggle px-3" data-bs-toggle="dropdown">
                       <i class="bi bi-person-circle"></i> <%= user.getName() %>
                   </button>

                   <ul class="dropdown-menu dropdown-menu-end">
                       <li><a class="dropdown-item" href="admin.jsp">Admin Dashboard</a></li>
                       <li><a class="dropdown-item" href="password.jsp">Settings</a></li>
                       <li><hr class="dropdown-divider"></li>
                       <li><a class="dropdown-item text-danger" href="LogoutServlet">Logout</a></li>
                   </ul>
               </div>

               <%
                   } else {
               %>

               <div class="dropdown">
                   <button class="btn btn-outline-success btn-sm dropdown-toggle px-3" data-bs-toggle="dropdown">
                       <i class="bi bi-person-circle"></i> <%= user.getName() %>
                   </button>

                   <ul class="dropdown-menu dropdown-menu-end">
                       <li><a class="dropdown-item" href="profile.jsp">My Profile</a></li>
                       <li><a class="dropdown-item" href="orders.jsp">My Orders</a></li>
                       <li><a class="dropdown-item" href="password.jsp">Settings</a></li>
                       <li><hr class="dropdown-divider"></li>
                       <li><a class="dropdown-item text-danger" href="LogoutServlet">Logout</a></li>
                   </ul>
               </div>

               <%
                   }
               %>

           </div>

        </div>
    </div>
</nav>

<%
    Map<Integer, CartItem> cart1 = (Map<Integer, CartItem>) session.getAttribute("cart");
    if (cart1 == null) cart1 = new HashMap<>();

    double totalPrice1 = CartUtils.getCartTotal(cart1);
%>

<!-- CART MODAL -->
<div class="modal fade" id="cartModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <div class="modal-header bg-success text-white">
        <h5 class="modal-title">Your Cart</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">

        <% if (cart1.isEmpty()) { %>
          <p class="text-center text-muted fs-5">Your cart is empty.</p>

        <% } else { %>

        <table class="table table-bordered text-center">
          <thead class="table-success">
            <tr>
              <th>Item Name</th>
              <th>Price</th>
              <th>Qty</th>
              <th>Total</th>
              <th>Action</th>
              <th>Quantity</th>
            </tr>
          </thead>

          <tbody>
          <% for (CartItem item : cart1.values()) { %>
            <tr id="row_<%= item.getVegetableId() %>">
              <td><%= item.getName() %></td>
              <td>₹ <%= item.getPrice() %></td>
              <td id="qty_<%= item.getVegetableId()%>"><%= item.getQuantity() %> kg</td>
              <td id="total_<%= item.getVegetableId()%>">₹ <%= item.getTotalPrice() %></td>

              <td>
                <button class="btn btn-danger btn-sm"
                        onclick="removeItem(<%= item.getVegetableId() %>)">
                    Remove
                </button>
              </td>
              <td>
                  <button class="btn btn-success btn-sm" onclick="updateQty(<%= item.getVegetableId() %>, 'inc')">+</button>

                  <span id="qty_span_<%= item.getVegetableId()%>"><%= item.getQuantity() %></span>

                  <button class="btn btn-warning btn-sm" onclick="updateQty(<%= item.getVegetableId() %>, 'dec')">-</button>
              </td>
            </tr>
          <% } %>
          </tbody>
        </table>

       <h5 class="text-end fw-bold">Total: ₹ <span id="grandTotal"><%= totalPrice1 %></span></h5>

        <% } %>

      </div>

      <div class="modal-footer d-flex justify-content-center">

          <% User u = (User) session.getAttribute("userObj"); %>

          <% if (u == null) { %>

              <!-- NOT LOGGED IN: BOTH BUTTONS CENTER + LOGIN MESSAGE -->
              <div class="d-flex align-items-center gap-3">
                  <button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>

                  <button class="btn btn-success" disabled>Checkout</button>

                  <span class="text-danger fw-bold">Please login First </span>
              </div>

          <% } else { %>

              <!-- LOGGED IN: BOTH BUTTONS CENTER -->
              <div class="d-flex align-items-center gap-3">
                  <button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>

                  <% if (!cart1.isEmpty()) { %>
                      <a href="checkout.jsp" class="btn btn-success">Checkout</a>
                  <% } %>
              </div>

          <% } %>

      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function updateQty(id, actionType) {
    fetch(actionType === 'inc'
        ? '/VegMartV1/IncreaseQuantity'
        : '/VegMartV1/DecreaseQuantity', {

        method: 'POST',
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "vid=" + id
    })

    .then(res => res.text())
    .then(data => {

        let parts = data.split(",");
        let newQty = parts[0];
        let newItemTotal = parts[1];
        let newGrandTotal = parts[2];

        // update item quantity
        document.getElementById("qty_" + id).innerText = newQty;
        document.getElementById("qty_span_" + id).innerText = newQty;
        // update item total
        document.getElementById("total_" + id).innerText = "₹ " + newItemTotal;

        // update grand total
        document.getElementById("grandTotal").innerText = newGrandTotal;
    })

    .catch(err => console.log("Error updating quantity:", err));
}
function removeItem(id) {
    fetch('/VegMartV1/RemoveFromCartServlet', {
        method: 'POST',
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "vid=" + id
    })
    .then(res => res.text())
    .then(data => {
        let parts = data.split(",");
        let newGrandTotal = parts[0];
        let newCartCount = parts[1];

        // Remove the row from table
        let row = document.getElementById("row_" + id);
        if (row) row.remove();

        // Update grand total
        document.getElementById("grandTotal").innerText = newGrandTotal;

        // Update cart count
        document.getElementById("cartCount").innerText = newCartCount;

        // If cart becomes empty, show empty message
        if (newCartCount == 0) {
            document.querySelector(".modal-body").innerHTML =
                "<p class='text-center text-muted fs-5'>Your cart is empty.</p>";
        }
    })
    .catch(err => console.log("Remove error:", err));
}
</script>
