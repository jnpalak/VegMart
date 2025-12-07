<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.yash.vegmart.entity.User" %>

<%

    User us = (User) session.getAttribute("userObj");

    if (us== null) {

        session.setAttribute("msg", "Please login first");
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%

    String error = (String) session.getAttribute("error");

    String success = (String) session.getAttribute("success");

    if (error != null) {

%>
<div class="alert alert-danger text-center"><%= error %></div>
<%
        session.removeAttribute("error");
    }
    if (success != null) {
%>
<div class="alert alert-success text-center"><%= success %></div>
<%
        session.removeAttribute("success");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Profile | VegMart</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<style>

    body {

        background: #eaffea !important;

        font-family: "Segoe UI", sans-serif;

    }

    .main-container {

        max-width: 1100px;

        margin: 40px auto;

    }

    /* CARD STYLES */

    .card-box {

        background: white;

        padding: 25px 30px;

        border-radius: 16px;

        box-shadow: 0 8px 20px rgba(0,0,0,0.08);

        height: 100%;

    }

    .section-title {

        font-size: 20px;

        font-weight: 700;

        color: #2e7d32;

        margin-bottom: 15px;

        border-left: 4px solid #2e7d32;

        padding-left: 10px;

    }

    /* PROFILE ICON INSIDE THE RIGHT CARD */

    .profile-icon-circle {

        width: 90px;

        height: 90px;

        border-radius: 50%;

        background: #c8e6c9;

        display: flex;

        justify-content: center;

        align-items: center;

        margin: 0 auto;

    }

    .profile-icon {

        font-size: 50px;

        color: #2e7d32;

    }

    .profile-name {

        margin-top: 8px;

        font-size: 22px;

        font-weight: 700;

        color: #2e7d32;

        text-align: center;

    }
    .card-small
    {
       padding:18px 22px !important;
       height:auto !important;
       }
       .card-small .mb-3
           {
              margin-bottom:10px !important;
              }
</style>

</head>
<body>

<%@ include file="components/common/header.jsp" %>

<div class="main-container">

    <div class="row g-4 align-items-stretch">
<!-- LEFT: CHANGE PASSWORD -->
<div class="col-md-4">
<div class="card-box card-small">

        <h5 class="section-title">Change Password</h5>

        <form action="ChangePasswordServlet" method="post">

            <div class="mb-3">
<label class="form-label">Old Password</label>
<input type="password" class="form-control" name="oldPassword" required>
</div>

            <div class="mb-3">
<label class="form-label">New Password</label>
<input type="password" class="form-control" name="newPassword" required>
</div>

            <button class="btn btn-success w-100">Change Password</button>

        </form>

        <!-- FIXED BACK BUTTON POSITION -->
<div class="text-center mt-3">
<a href="javascript:history.back()" class="btn btn-outline-success px-4">Back</a>
</div>

    </div>
</div>




        <!-- RIGHT: PROFILE DETAILS -->
<div class="col-md-8">
<div class="card-box h-100">

                <!-- PROFILE ICON INSIDE THIS CARD ONLY -->
<div class="text-center mb-3">
<div class="profile-icon-circle">
<i class="bi bi-person-fill profile-icon"></i>
</div>
<div class="profile-name"><%= u.getName() %></div>
</div>

                <h5 class="section-title">Profile Details</h5>

                <form action="UpdateProfileServlet" method="post">

                    <div class="mb-3">
<label class="form-label">Full Name</label>
<input type="text" class="form-control" name="name" value="<%= u.getName() %>" required>
</div>

                    <div class="mb-3">
<label class="form-label">Mobile Number</label>
<input type="text" class="form-control" name="mobile" value="<%= u.getMobile() %>" required>
</div>

                    <div class="mb-3">
<label class="form-label">Email</label>
<input type="text" class="form-control" value="<%= u.getEmail() %>" readonly>
</div>

                    <div class="mb-3">
<label class="form-label">Address</label>
<textarea class="form-control" name="address" rows="2" required><%= u.getAddress() %></textarea>
</div>

                    <button class="btn btn-success w-100">Update Profile</button>
</form>

            </div>
</div>

    </div>

</div>

<%@ include file="components/common/footer.jsp" %>

</body>
</html>

