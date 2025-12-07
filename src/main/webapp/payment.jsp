<%@ page contentType="text/html;charset=UTF-8" %>
<%

    Double amount = (Double) session.getAttribute("amountToPay");

    if (amount == null) {

        response.sendRedirect("index.jsp");

        return;

    }

%>

<!DOCTYPE html>
<html>
<head>
<title>Payment | VegMart</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>

    body {

      background: #eaffea !important;

    }

    .payment-box {

        width: 420px;

        background: white;

        margin: 60px auto;

        padding: 25px;

        border-radius: 16px;

        box-shadow: 0 6px 20px rgba(0,0,0,0.15);

    }

    .btn-pay {

        background: #1877f2;

        color: white;

        font-size: 18px;

        width: 100%;

    }
</style>
</head>
<body>

<div class="payment-box">
<h3 class="text-center mb-3">PAYMENT DETAILS</h3>

<form action="PaymentSuccessServlet" method="post">

    <label class="form-label">Card Number</label>
<input type="text" class="form-control mb-3" placeholder="1234 5678 9000 1234" required>

    <div class="row">
<div class="col-md-6">
<label class="form-label">EXP. DATE</label>
<input type="text" class="form-control mb-3" placeholder="03/2025" required>
</div>
<div class="col-md-6">
<label class="form-label">CVV</label>
<input type="password" class="form-control mb-3" placeholder="123" required>
</div>
</div>

    <label class="form-label">Name on Card</label>
<input type="text" class="form-control mb-3" required>

    <label class="form-label fw-bold">TOTAL AMOUNT</label>
<input type="text" class="form-control mb-3" value="<%= amount %>" readonly>

    <button class="btn btn-pay">PAY NOW</button>
    <div class="text-center mt-4">
    <a href="javascript:history.back()" class="btn btn-outline-success px-4"> Back </a>
    </div>

</form>

</div>

</body>
</html>

