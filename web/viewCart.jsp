<%-- 
    Document   : viewCart
    Created on : Apr 19, 2021, 7:08:17 PM
    Author     : Khoa Nguyễn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VIEW CART PAGE</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" integrity="sha512-HK5fgLBL+xu6dm/Ii3z4xhlSUyZgTT9tuc/hSrtw6uzJOvgRr2a9jyxxT1ely+B+xFAmJKVSTbpM/CuL7qxO8w==" crossorigin="anonymous" />
        <style type="text/css">
            @import url('https://fonts.googleapis.com/css?family=Montserrat');
            #body-row {
                margin-left: 0;
                margin-right: 0;
            }
            #sidebar-container {
                min-height: 77vh;
                background-color: #222222;
                padding: 0;
            }
            .sidebar-expanded {
                width: 230px;
            }
            .sidebar-collapsed {
                width: 100px;
            }   
            #sidebar-container .list-group a {
                height: 50px;
                color: white;
                font-size: 25px
            }  
            #sidebar-container .list-group li.list-group-item {
                background-color: #222222;
            }
            #sidebar-container .list-group .sidebar-submenu a {
                height: 45px;
                padding-left: 30px;
            }
            .sidebar-submenu {
                font-size: 0.9rem;
            } 
            .sidebar-separator-title {
                background-color: #222222;
                height: 35px;
            }
            .sidebar-separator {
                background-color: #222222;
                height: 25px;
            }
            .logo-separator {
                background-color: #222222;
                height: 60px;
            }
            a.bg-dark {
                background-color: #222222 !important;
            }
            .menu-collapsed:hover{
                color: #f79320;
            }
            #sidebar-container .list-group .sidebar-submenu a:hover{
                color: #f79320;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid p-0">
            <div class="row" id="body-row">
                <div id="sidebar-container" class="sidebar-expanded d-none d-md-block">
                    <ul class="list-group">
                        <a href="#" class="bg-dark list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-start align-items-center">
                                <span class="fa fa-user fa-fw mr-3"></span>
                                <span class="menu-collapsed">Hi,
                                    <c:if test="${not empty  sessionScope.LOGIN_USER}">
                                        <span class="menu-collapsed">${sessionScope.LOGIN_USER.getName()}</span>
                                    </c:if>
                                </span>    
                            </div>
                        </a>       
                        <a href="#" class="bg-dark list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-start align-items-center">
                                <span class="fas fa-id-badge mr-4"></span>
                                <span class="menu-collapsed">Profile</span>    
                            </div>
                        </a>
                        <a href="#submenu2" data-toggle="collapse" aria-expanded="false" class="bg-dark list-group-item list-group-item-action flex-column align-items-start">
                            <div class="d-flex w-100 justify-content-start align-items-center">
                                <span class="fa fa-tasks fa-fw mr-3"></span>
                                <span class="menu-collapsed">Categories</span>
                                <span class="submenu-icon ml-auto"></span>
                            </div>
                        </a>
                        <div id='submenu2' class="collapse sidebar-submenu">
                            <c:set var="listCate" value="${sessionScope.LISTCATE}"/>
                            <c:forEach items="${listCate}" var="o">
                                <li class="list-group-item text-white"><a href=MainController?action=searchByCate&cateID=${o.categoryID}>${o.categoryName}</a></li>
                                </c:forEach>

                        </div> 
                        <a href="#" class="bg-dark list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-start align-items-center">
                                <span class="fas fa-shopping-cart mr-3"></span>
                                <span class="menu-collapsed mr-3">View Cart</span> 
                                <span id="quantityCart"></span>
                            </div>
                        </a>

                        <c:if test="${not empty  sessionScope.LOGIN_USER}">
                            <a href="MainController?action=Logout" class="bg-dark list-group-item list-group-item-action">
                                <div class="d-flex w-100 justify-content-start align-items-center">
                                    <span class="fas fa-sign-out-alt mr-3"></span>
                                    <span class="menu-collapsed">Logout</span>    
                                </div>
                            </a>
                        </c:if>
                    </ul>
                </div>
                <div class="col">
                    <h1>
                        <nav class="navbar navbar-light bg-light justify-content-between">
                            <a class="navbar-brand" href="MainController?action=homePage">Menu</a>
                        </nav>
                    </h1>

                    <div class="col-12">
                        <c:set var="cart" value="${sessionScope.CART}"/>

                        <c:if test="${cart != null}">

                            <c:set var="map" value="${cart.cartProduct}"/>
                            <c:if test="${map != null and !map.isEmpty()}">
                                <c:if test="${not empty requestScope.OUT_OF_STOCK_CHECK_OUT}">
                                    <h3 style="color: red;">${requestScope.OUT_OF_STOCK_CHECK_OUT}</h3>
                                </c:if>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Product ID</th>
                                                <th scope="col">Product Name</th>
                                                <th scope="col">Product IMG</th>
                                                <th scope="col">Price</th>
                                                <th scope="col">Quantity</th>
                                                <th scope="col">Remove</th>
                                                <th scope="col">Update</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="dto" items="${map}" varStatus="counter">
                                                <tr>
                                            <form action="MainController">
                                                <th scope="row">${counter.count}</th>
                                                <td>${dto.key}</td>
                                                <td>${dto.value.productName}</td>
                                                <td><img src="${dto.value.productImg}" width="200px" height="200"/></td>
                                                <td>${dto.value.price}</td>
                                                <td>
                                                    <input type="number" name="proQuantity" value="${dto.value.quantity}" min="1"/>
                                                    <c:if test="${requestScope.productIDError eq dto.key}">
                                                        <c:if test="${not empty requestScope.OUT_OF_STOCK}">
                                                            <p style="color: red;">${requestScope.OUT_OF_STOCK}</p>
                                                        </c:if>
                                                    </c:if>

                                                </td> 
                                                <td>
                                                    <a href="MainController?action=deleteProductFormCart&pk=${dto.key}" class="btn btn-danger">Remove</a>
                                                </td>

                                                <td>
                                                    <input type="hidden" name="proID" value="${dto.key}" />
                                                    <input type="hidden" name="actionPrimary" value="updateQuantity" />
                                                    <button type="submit" name="action" value="checkUnitQuantityProduct" class="btn btn-primary">Update</button>

                                                </td>
                                                <c:set var="totalUnitPrice" value="${dto.value.price * dto.value.quantity}"/>
                                                <c:set var="totalPrice" value="${totalPrice + totalUnitPrice}"/>
                                            </form>
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                            <td colspan="4">

                                            </td>
                                            <td>
                                                Total Price:
                                            </td>
                                            <td>
                                                ${totalPrice}$
                                            </td>
                                            <td colspan="2">
                                                <a href="MainController?action=proceedToCheckout&totalPrice=${totalPrice}" class="btn btn-success">Checkout</a>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>

                            <c:if test="${map == null or map.isEmpty()}">
                                <c:if test="${not empty requestScope.OUT_OF_STOCK_CHECK_OUT}">
                                    <h3 style="color: red;">${requestScope.OUT_OF_STOCK_CHECK_OUT}</h3>
                                </c:if>
                                <c:if test="${empty requestScope.OUT_OF_STOCK_CHECK_OUT}">
                                    <h3 style="color: red;">Your Cart Is empty</h3>
                                </c:if>
                            </c:if>
                        </c:if>
                        <c:if test="${cart == null}">
                            <h1>YOUR CART IS EMPTY</h1>
                        </c:if>
                    </div>
                </div>
            </div>

        </div>
                        <c:set var="map" value="${sessionScope.CART.cartProduct}"/>
            <script type="text/javascript">
                document.getElementById("quantityCart").textContent=${map.size()};
            </script>
        <%@include file="footer.jsp" %>
    </body>
</html>
