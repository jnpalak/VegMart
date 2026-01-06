<!DOCTYPE html>
<html>
<head>
<title>Thank You | VegMart</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
<style>
    body {
        background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    .content-wrapper {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 40px 20px;
    }

    .success-card {
        background: white;
        border-radius: 20px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        padding: 60px 40px;
        max-width: 600px;
        width: 100%;
        animation: slideUp 0.6s ease-out;
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .tick-container {
        background: linear-gradient(135deg, #66bb6a 0%, #43a047 100%);
        width: 120px;
        height: 120px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 30px;
        box-shadow: 0 8px 20px rgba(67, 160, 71, 0.3);
        animation: scaleIn 0.5s ease-out 0.2s both;
    }

    @keyframes scaleIn {
        from {
            transform: scale(0);
        }
        to {
            transform: scale(1);
        }
    }

    .tick {
        font-size: 70px;
        color: white;
    }

    .success-card h2 {
        color: #2e7d32;
        font-weight: 700;
        margin-bottom: 15px;
    }

    .success-card h4 {
        color: #555;
        font-weight: 500;
        margin-bottom: 20px;
    }

    .success-card p {
        color: #777;
        font-size: 16px;
        margin-bottom: 35px;
    }

    .order-info {
        background: #f5f5f5;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 30px;
    }

    .order-info-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }

    .order-info-item:last-child {
        margin-bottom: 0;
    }

    .order-info-label {
        color: #666;
        font-weight: 500;
    }

    .order-info-value {
        color: #333;
        font-weight: 600;
    }

    .btn-group {
        display: flex;
        gap: 15px;
        flex-wrap: wrap;
        justify-content: center;
    }

    .btn {
        padding: 12px 35px;
        border-radius: 25px;
        font-weight: 600;
        transition: all 0.3s ease;
        border: none;
    }

    .btn-primary {
        background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
    }

    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(33, 150, 243, 0.4);
    }

    .btn-success {
        background: linear-gradient(135deg, #66bb6a 0%, #43a047 100%);
    }

    .btn-success:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(67, 160, 71, 0.4);
    }

    .btn-outline-secondary {
        background: white;
        color: #666;
        border: 2px solid #ddd;
    }

    .btn-outline-secondary:hover {
        background: #f5f5f5;
        border-color: #999;
        color: #333;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    @media (max-width: 576px) {
        .success-card {
            padding: 40px 25px;
        }

        .btn-group {
            flex-direction: column;
            width: 100%;
        }

        .btn {
            width: 100%;
        }
    }
</style>
</head>
<body>

<%@ include file="components/common/header.jsp" %>

<div class="content-wrapper">
    <div class="success-card text-center">
        <div class="tick-container">
            <i class="bi bi-check-circle-fill tick"></i>
        </div>

        <h2>Thank You!</h2>
        <h4>Your Order Successfully Placed</h4>
        <p>Your order has been confirmed and will be delivered to your address within 7 days</p>

        <div class="order-info">
            <div class="order-info-item">
                <span class="order-info-label"><i class="bi bi-box-seam"></i> Order Status:</span>
                <span class="order-info-value text-success">Confirmed</span>
            </div>
            <div class="order-info-item">
                <span class="order-info-label"><i class="bi bi-truck"></i> Estimated Delivery:</span>
                <span class="order-info-value">5-7 Business Days</span>
            </div>
            <div class="order-info-item">
                <span class="order-info-label"><i class="bi bi-envelope"></i> Confirmation Email:</span>
                <span class="order-info-value">Sent</span>
            </div>
        </div>

        <div class="btn-group">
            <a href="index.jsp" class="btn btn-primary">
                <i class="bi bi-house-door"></i> Back to Home
            </a>
            <a href="orders.jsp" class="btn btn-success">
                <i class="bi bi-bag-check"></i> View Orders
            </a>
            <a href="logout" class="btn btn-outline-danger">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
        </div>
    </div>
</div>

<%@ include file="components/common/footer.jsp" %>

</body>
</html>