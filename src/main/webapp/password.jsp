<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.yash.vegmart.entity.User" %>

<%

    User uuser = (User) session.getAttribute("userObj");

    if (uuser == null) {

        response.sendRedirect("login.jsp");

        return;

    }

%>
<body class="d-flex flex-column min-vh-100" style="background: #eaffea !important;">

<%@ include file="components/common/header.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- MAIN CONTENT -->
<main class="flex-fill">
<div class="container mt-5" style="max-width: 450px;">
<div class="card shadow-lg p-4 rounded-4">

            <h4 class="text-success fw-bold text-center mb-4">
                Change Password
</h4>

            <form action="ChangePasswordServlet" method="post">

                <div class="mb-3">
<label class="form-label fw-semibold">Old Password</label>
<input type="password" class="form-control" name="oldPassword" required>
</div>

                <div class="mb-3">
<label class="form-label fw-semibold">New Password</label>
<input type="password" class="form-control" name="newPassword" required>
</div>

                <button class="btn btn-success w-100 fw-bold">
                    Update Password
</button>
</form>

            <div class="text-center mt-3">
<a href="profile.jsp" class="btn btn-outline-success btn-sm">
                    Back to Profile
</a>
</div>

        </div>
</div>
</main>

<%@ include file="components/common/footer.jsp" %>

</body>