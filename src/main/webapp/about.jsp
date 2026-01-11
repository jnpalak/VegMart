<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="components/common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>About | VegMart</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background: #eaffea;
        }
        .about-box {
            background: #fff;
            padding: 40px;
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
            margin-bottom: 20px;
        }
        .section-title {
            color: #2e8b57;
            font-weight: 600;
            margin-top: 30px;
            margin-bottom: 15px;
        }
        .feature-card {
            background: #f8fff8;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #2e8b57;
            margin-bottom: 15px;
            transition: transform 0.3s;
        }
        .feature-card:hover {
            transform: translateX(5px);
        }
        .feature-icon {
            color: #2e8b57;
            font-size: 24px;
            margin-right: 15px;
        }
        .contact-info {
            background: #f8fff8;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }
        .contact-item {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
        }
        .contact-item i {
            color: #2e8b57;
            font-size: 20px;
            width: 30px;
        }
        .stats-section {
            background: linear-gradient(135deg, #2e8b57 0%, #228b52 100%);
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin: 30px 0;
        }
        .stat-box {
            text-align: center;
        }
        .stat-number {
            font-size: 36px;
            font-weight: 700;
        }
        .stat-label {
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>

<body>

<div class="container mt-5 mb-5">

    <div class="about-box">

        <!-- Main Heading -->
        <h3 class="heading">About VegMart</h3>
        <div class="underline"></div>

        <!-- Introduction -->
        <p class="mt-4" style="line-height: 1.8; font-size: 16px;">
            VegMart is a simple and convenient online vegetable shopping platform.
            Our goal is to make buying fresh vegetables easy, quick, and affordable.
            We focus on providing clean, hygienic, and fresh produce directly sourced
            from trusted farmers and local markets.
        </p>

        <p style="line-height: 1.8; font-size: 16px;">
            We started VegMart to solve a small but common problem—finding fresh
            vegetables without spending too much time outside. Over time, VegMart
            has grown into a platform that helps people save time, avoid queues,
            and get their daily essentials delivered at their doorstep.
        </p>

        <!-- Stats Section -->
        <div class="stats-section">
            <div class="row">
                <div class="col-md-3 col-6">
                    <div class="stat-box">
                        <div class="stat-number">5000+</div>
                        <div class="stat-label">Happy Customers</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stat-box">
                        <div class="stat-number">50+</div>
                        <div class="stat-label">Fresh Vegetables</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stat-box">
                        <div class="stat-number">100%</div>
                        <div class="stat-label">Quality Assured</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stat-box">
                        <div class="stat-number">24/7</div>
                        <div class="stat-label">Support Available</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- What We Offer -->
        <h5 class="section-title">What We Offer</h5>

        <div class="feature-card">
            <i class="fas fa-leaf feature-icon"></i>
            <strong>Fresh vegetables delivered to your home</strong> -
            Handpicked daily from trusted sources
        </div>

        <div class="feature-card">
            <i class="fas fa-tag feature-icon"></i>
            <strong>Affordable pricing and discounts</strong> -
            Best prices in town with regular offers
        </div>

        <div class="feature-card">
            <i class="fas fa-list feature-icon"></i>
            <strong>Easy browsing by category</strong> -
            Find what you need quickly and easily
        </div>

        <div class="feature-card">
            <i class="fas fa-shopping-cart feature-icon"></i>
            <strong>Simple add-to-cart and checkout</strong> -
            Order in just a few clicks
        </div>

        <div class="feature-card">
            <i class="fas fa-truck feature-icon"></i>
            <strong>Fast delivery</strong> -
            Same-day delivery for orders placed before 2 PM
        </div>

        <!-- Vision -->
        <h5 class="section-title">Our Vision</h5>
        <p style="line-height: 1.8; font-size: 16px;">
            To provide fresh vegetables to every home with just one click —
            making everyday shopping easier and stress-free. We believe in
            promoting healthy eating habits by ensuring everyone has access
            to fresh, quality vegetables without any hassle.
        </p>

        <!-- Why Choose Us -->
        <h5 class="section-title">Why Choose VegMart?</h5>
        <div class="row mt-3">
            <div class="col-md-4 mb-3">
                <div class="text-center">
                    <i class="fas fa-check-circle" style="font-size: 40px; color: #2e8b57;"></i>
                    <h6 class="mt-2">Quality Assured</h6>
                    <p style="font-size: 14px;">Every vegetable is checked for freshness</p>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="text-center">
                    <i class="fas fa-clock" style="font-size: 40px; color: #2e8b57;"></i>
                    <h6 class="mt-2">Save Time</h6>
                    <p style="font-size: 14px;">No more waiting in long queues</p>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="text-center">
                    <i class="fas fa-shield-alt" style="font-size: 40px; color: #2e8b57;"></i>
                    <h6 class="mt-2">Secure Payments</h6>
                    <p style="font-size: 14px;">Safe and encrypted transactions</p>
                </div>
            </div>
        </div>

        <!-- Contact Us -->
        <h5 class="section-title">Contact Us</h5>
        <div class="contact-info">
            <div class="contact-item">
                <i class="fas fa-envelope"></i>
                <span><strong>Email:</strong> vegmart.support@gmail.com</span>
            </div>
            <div class="contact-item">
                <i class="fas fa-phone"></i>
                <span><strong>Phone:</strong> +91 98765 43210</span>
            </div>
            <div class="contact-item">
                <i class="fas fa-map-marker-alt"></i>
                <span><strong>Address:</strong> 123 Vijay Nagar, Indore,Madhya Pradesh</span>
            </div>
            <div class="contact-item">
                <i class="fas fa-clock"></i>
                <span><strong>Working Hours:</strong> Mon - Sat: 8:00 AM - 8:00 PM</span>
            </div>
        </div>
    </div>

</div>

<%@ include file="components/common/footer.jsp" %>
</body>
</html>