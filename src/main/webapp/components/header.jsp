<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.yash.vegmart.entity.User" %>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm py-3">
    <div class="container">

        <!-- Brand -->
        <a class="navbar-brand fw-bold text-success fs-3" href="index.jsp">VegMart</a>

        <!-- Toggler -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navMenu">

            <!-- LEFT SIDE NAV ITEMS -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <!-- Home -->
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>

                <!-- Categories Dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="categoriesDropdown"
                       data-bs-toggle="dropdown">
                        Categories
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="products?cat=vegetables">Vegetables</a></li>
                        <li><a class="dropdown-item" href="products?cat=fruits">Fruits</a></li>
                        <li><a class="dropdown-item" href="products?cat=dairy">Dairy</a></li>
                        <li><a class="dropdown-item" href="products?cat=grains">Grains</a></li>
                    </ul>
                </li>

            </ul>

            <!-- CENTER SEARCH BAR -->
            <form action="search" method="get" class="d-flex mx-auto w-50">
                <input class="form-control rounded-start-pill" type="search" name="query"
                       placeholder="Search fresh vegetables">
                <button class="btn btn-success rounded-end-pill px-4">Search</button>
            </form>

            <!-- RIGHT SIDE (Login / Logout / Username) -->
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">

                <%
                    User log = (User) session.getAttribute("userObj");

                    if (log == null) {
                %>


                <li class="nav-item">
                    <a href="login.jsp" class="btn btn-outline-success ms-3">Login</a>
                </li>
                <li class="nav-item">
                    <a href="register.jsp" class="btn btn-success ms-2">Sign Up</a>
                </li>

                <%
                    } else {
                %>

                <!-- SHOW WHEN USER IS LOGGED IN -->
                <li class="nav-item">
                    <a class="btn btn-outline-success ms-3">
                        Welcome, <%= log.getName() %>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="LogoutServlet" class="btn btn-outline-success ms-3">Logout</a>
                </li>

                <%
                    }
                %>

            </ul>

        </div>
    </div>
</nav>





