<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.yash.vegmart.entity.User" %>

<%
    User user = (User) session.getAttribute("userObj");
    Integer razorpayAmount = (Integer) session.getAttribute("razorpayAmount");

    if (user == null || razorpayAmount == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Pay Online | VegMart</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<style>
body {
    background:#eaffea;
    font-family:Segoe UI;
}
.pay-box {
    width:400px;
    margin:120px auto;
    background:white;
    padding:25px;
    border-radius:15px;
    text-align:center;
    box-shadow:0 8px 20px rgba(0,0,0,0.15);
}
.btn-pay {
    background:#2e7d32;
    color:white;
    padding:12px 20px;
    border:none;
    width:100%;
    font-size:18px;
}
</style>
</head>

<body>

<div class="pay-box">
<h3>Complete Payment</h3>
<p>Secure payment powered by Razorpay</p>

<button class="btn-pay" onclick="payNow()">Pay Now</button>
</div>

<script>
function payNow() {

    var options = {
        "key": "rzp_test_RwynRhSsnQlugi",
        "amount": "<%= razorpayAmount %>",
        "currency": "INR",
        "name": "VegMart",
        "description": "Vegetable Purchase",
        "handler": function (response) {

            var form = document.createElement("form");
            form.method = "POST";
            form.action = "PaymentSuccessServlet";

            var fields = {
                razorpay_payment_ id: response.razorpay_payment_id
            };

            for (var key in fields) {
                var input = document.createElement("input");
                input.type = "hidden";
                input.name = key;
                input.value = fields[key];
                form.appendChild(input);
            }

            document.body.appendChild(form);
            form.submit();
        },
        "prefill": {
            "name": "<%= user.getName() %>",
            "email": "<%= user.getEmail() %>",
            "contact": "<%= user.getMobile() %>"
        },
        "theme": {
            "color": "#2e7d32"
        }
    };

    var rzp = new Razorpay(options);
    rzp.open();
}
</script>

</body>
</html>