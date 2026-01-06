<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Payment Failed | VegMart</title>

    <!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #eaffea !important;
            font-family: 'Segoe UI', sans-serif;
        }

        .fail-box {
            max-width: 500px;
            background: white;
            margin: 80px auto;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
            text-align: center;
        }

        .fail-icon {
            font-size: 70px;
            color: #dc3545;
        }

        .btn-retry {
            background: #b02a37;
            color: white;
            font-weight: 600;
        }

        .btn-retry:hover {
            background: #b02a37;
        }

        .btn-back {
            border: 2px solid #2e7d32;
            color: #2e7d32;
            font-weight: 600;
        }
</style>
</head>

<body>
<%@ include file="components/common/header.jsp" %>
<div class="fail-box">
<div class="fail-icon"></div>

    <h3 class="fw-bold mt-3 text-danger">Payment Failed</h3>

    <p class="text-muted mt-2">
        Oops! Your payment could not be completed.<br>
        Please try again or choose a different payment method.
</p>

    <div class="d-grid gap-3 mt-4">
<a href="checkout.jsp" class="btn btn-retry btn-lg">
            Retry Payment
</a>

        <a href="index.jsp" class="btn btn-back btn-lg">
            Back to Home
</a>
</div>
</div>
<%@ include file="components/common/footer.jsp" %>
</body>
</html>
<script>
handler: function (response) {
   document.getElementById("razorpay_payment_id").value = response.razorpay_payment_id;
   document.getElementById("paymentForm").submit();
},
modal: {
   ondismiss: function () {
       window.location.href = "payment_failed.jsp";
   }
}
<script>
