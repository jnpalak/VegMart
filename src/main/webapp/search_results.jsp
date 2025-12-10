<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.yash.vegmart.entity.Vegetable" %>
<%@ page import="com.yash.vegmart.utilities.Helper" %>

<%

    List<Vegetable> vegList = (List<Vegetable>) request.getAttribute("searchResult");

    String keyword = (String) request.getAttribute("keyword");

%>

<%@ include file="components/common/header.jsp" %>

<style>

    body { background: #eaffea; }

    .product-card {

        background: white;

        border-radius: 12px;

        padding: 18px;

        min-height: 460px;

        box-shadow: 0 4px 12px rgba(0,0,0,0.12);

        transition: 0.3s;

        display: flex;

        flex-direction: column;

        justify-content: space-between;

    }

    .product-img {

        height: 180px;

        width: 100%;

        object-fit: cover;

        border-radius: 10px;

    }

    .out-container { position: relative; }

    .out-of-stock-img { opacity: 0.35; filter: grayscale(100%); }

    .out-stock-label {

        position: absolute;

        top: 50%;

        left: 50%;

        transform: translate(-50%, -50%);

        background: rgba(220,53,69,0.9);

        color: white;

        padding: 6px 14px;

        border-radius: 8px;

        font-size: 14px;

        font-weight: bold;

    }

    .desc-short { font-size: 14px; color: #444; }

    .desc-full { display: none; font-size: 14px; color: #444; }

    .read-more {

        color: #2e8b57;

        cursor: pointer;

        font-weight: 600;

        margin-top: -14px;

        font-size: 14px;

    }

    .cart-btn, .price-btn {

        background: #2e8b57 !important;

        color: white !important;

    }

    .disabled-btn {

        background: #9e9e9e !important;

        color: white !important;

        pointer-events: none;

        border: none;

    }

    .discount-label {

        font-size: 13px;

        font-style: italic;

        color: white;

    }
</style>

<div class="container mt-4">

    <h3 class="fw-bold text-success mb-4">

        Search Results for: "<%= keyword %>"
</h3>

    <div class="row g-4">

        <% if (vegList == null || vegList.isEmpty()) { %>

            <p class="text-center text-danger fs-4">No vegetables found!</p>

        <% } else {

            int index = 0;

            for (Vegetable veg : vegList) {

                String shortDesc = Helper.get35Words(veg.getDescription());

                String fullDesc = veg.getDescription();

        %>

        <div class="col-md-3">
<div class="product-card">

                <!-- Image + Out of Stock Overlay -->
<div class="out-container">
<img src="img/Products/<%= veg.getpImage() %>"

                         class="product-img <%= (veg.getQuantityInStock() <= 0) ? "out-of-stock-img" : "" %>">

                    <% if (veg.getQuantityInStock() <= 0) { %>
<span class="out-stock-label">OUT OF STOCK</span>
<% } %>
</div>

                <!-- Product Details -->
<div>
<h6 class="fw-bold mt-2"><%= veg.getName() %></h6>

                    <p class="desc-short" id="short<%= index %>"><%= shortDesc %></p>
<p class="desc-full" id="full<%= index %>"><%= fullDesc %></p>

                    <p class="read-more" onclick="toggleDesc(<%= index %>)" id="btn<%= index %>">

                        Read More
</p>
</div>

                <!-- Buttons -->
<div class="d-flex justify-content-between mt-3">

                    <% if (veg.getQuantityInStock() <= 0) { %>

                        <button class="btn disabled-btn btn-sm w-50 me-2">Add to Cart</button>

                    <% } else { %>

                        <a href="AddToCartServlet?vid=<%= veg.getVegetableId() %>"

                           class="btn cart-btn btn-sm w-50 me-2">

                            Add to Cart
</a>

                    <% } %>

                    <button class="btn price-btn btn-sm w-50">

                        ₹<%= veg.getPriceAfterDis() %>/-
<span class="discount-label" style="text-decoration: line-through;">

                            ₹<%= veg.getPrice() %>
</span>
<span class="discount-label">
<%= veg.getDiscount() %>% off
</span>
</button>

                </div>

            </div>
</div>

        <% index++; } } %>

    </div>

</div>

<script>

function toggleDesc(i) {

    let shortText = document.getElementById("short" + i);

    let fullText = document.getElementById("full" + i);

    let btn = document.getElementById("btn" + i);

    if (fullText.style.display === "none") {

        fullText.style.display = "block";

        shortText.style.display = "none";

        btn.innerText = "Read Less";

    } else {

        fullText.style.display = "none";

        shortText.style.display = "block";

        btn.innerText = "Read More";

    }

}
</script>

<%@ include file="components/common/footer.jsp" %>

