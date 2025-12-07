<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="components/common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>About | VegMart</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background: #eaffea;
        }
        .about-box {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        .heading {
            font-weight: 700;
            color: #2e8b57;
        }
        .underline {
            width: 70px;
            height: 3px;
            background: #2e8b57;
            margin-top: 5px;
        }
    </style>
</head>

<body>

<div class="container mt-5 mb-5">

    <div class="about-box">

        <h3 class="heading">About VegMart</h3>
        <div class="underline"></div>

        <p class="mt-4" style="line-height: 1.7;">
            VegMart is a simple and convenient online vegetable shopping platform.
            Our goal is to make buying fresh vegetables easy, quick, and affordable.
            We focus on providing clean, hygienic, and fresh produce directly sourced
            from trusted farmers and local markets.
        </p>

        <p style="line-height: 1.7;">
            We started VegMart to solve a small but common problem—finding fresh
            vegetables without spending too much time outside. Over time, VegMart
            has grown into a platform that helps people save time, avoid queues,
            and get their daily essentials delivered at their doorstep.
        </p>

        <h5 class="mt-4">What We Offer</h5>
        <ul style="line-height: 1.8;">
            <li>Fresh vegetables delivered to your home</li>
            <li>Affordable pricing and discounts</li>
            <li>Easy browsing by category</li>
            <li>Simple add-to-cart and checkout process</li>
        </ul>

        <h5 class="mt-4">Our Vision</h5>
        <p style="line-height: 1.7;">
            To provide fresh vegetables to every home with just one click —
            making everyday shopping easier and stress-free.
        </p>

        <h5 class="mt-4">Contact Us</h5>
        <p style="line-height: 1.7;">
            Email: vegmart.support@gmail.com <br>
            Phone: +91 98765 43210
        </p>

    </div>

</div>
<%@ include file="components/common/footer.jsp" %>
</body>
</html>
