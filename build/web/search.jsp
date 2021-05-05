<%-- 
    Document   : search
    Created on : Apr 17, 2021, 9:49:48 PM
    Author     : Khoa Nguyễn
--%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HOME PAGE</title>
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
                /* flex: unset; */
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
            .col{
                background-color: cornsilk;
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
                        <a href="MainController?action=viewCartPage" class="bg-dark list-group-item list-group-item-action">
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
                            <form class="form-inline" action="MainController">
                                <input class="form-control mr-sm-2" type="search" name="valueSearch" placeholder="Search" aria-label="Search">
                                <button class="btn btn-outline-success my-2 my-sm-0" name="action" value="searchByName" type="submit">Search</button>
                            </form>
                        </nav>
                    </h1>

                    <c:if test="${not empty requestScope.OUT_OF_STOCK}">
                        <h2 style="color: red;">${requestScope.OUT_OF_STOCK}</h2>
                    </c:if>

                    <c:set var="USER" value="${sessionScope.LOGIN_USER}"/>   

                    <c:set var="listProduct" value="${requestScope.listProduct}"/>
                    <div class="row"> 
                        <c:forEach var="item" items="${listProduct}">
                            <div class="col-3">
                                <div class="card" style="height: 400px; width: 280px; margin-top: 20px">
                                    <img class="card-img-top"  style="width: 100%; height: 200px" src="${item.productImg}" alt="abc" />
                                    <div class="card-body">
                                        <h4 class="card-title">${item.productName}</h4>
                                        <p class="card-text">Price: ${item.price}$</p>
                                        <p class="card-text" style="color: red">Count: ${item.quantity}</p>
                                    </div>
                                    <p style="text-align: center">


                                        <c:if test="${USER.roleID ne 'AD'}">
                                        <form action="MainController">
                                            <c:if test="${requestScope.productIDError eq item.productID}">
                                                <c:if test="${empty requestScope.OUT_OF_STOCK}">
                                                    <button style="width: 100%; height: 45px" name="action"  value="checkUnitQuantityProduct" type="submit" class="btn btn-success" >
                                                        Add To Cart
                                                    </button>
                                                    <input type="hidden" name="proID" value="${item.productID}" />
                                                    <input type="hidden" name="proName" value="${item.productName}" />
                                                    <input type="hidden" name="proImg" value="${item.productImg}" />
                                                    <input type="hidden" name="proPrice" value="${item.price}" />
                                                    <input type="hidden" name="proCate" value="${item.categoryID}" />
                                                    <input type="hidden" name="actionPrimary" value="addCart" />
                                                    <input type="hidden" name="actionSearch" value="${requestScope.ACTIONSEARCH}" />
                                                    <input type="hidden" name="searchValue" value="${param.valueSearch}" />
                                                    <input type="hidden" name="cateID" value="${param.cateID}" />
                                                </c:if>
                                                <c:if test="${not empty requestScope.OUT_OF_STOCK}">
                                                    <button style="width: 100%; height: 45px" name="action"  value="checkUnitQuantityProduct" type="submit" class="btn btn-success"  disabled>
                                                        Maximum Quantity
                                                    </button>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${requestScope.productIDError ne item.productID}">
                                                <button style="width: 100%; height: 45px" name="action"  value="checkUnitQuantityProduct" type="submit" class="btn btn-success" >
                                                    Add To Cart
                                                </button>
                                                <input type="hidden" name="proID" value="${item.productID}" />
                                                <input type="hidden" name="proName" value="${item.productName}" />
                                                <input type="hidden" name="proImg" value="${item.productImg}" />
                                                <input type="hidden" name="proPrice" value="${item.price}" />
                                                <input type="hidden" name="proCate" value="${item.categoryID}" />
                                                <input type="hidden" name="actionPrimary" value="addCart" />


                                                <input type="hidden" name="actionSearch" value="${requestScope.ACTIONSEARCH}" />
                                                <input type="hidden" name="searchValue" value="${param.valueSearch}" />
                                                <input type="hidden" name="cateID" value="${param.cateID}" />
                                            </c:if>
                                        </form>
                                    </c:if>

                                    <c:if test="${USER.roleID eq 'AD'}">
                                        <c:url var="urlUpdateProduct" value="MainController">
                                            <c:param name="action" value="updateProductPage"/>
                                            <c:param name="proID" value="${item.productID}"/>
                                            <c:param name="actionSearch" value="${requestScope.ACTIONSEARCH}"/>
                                            <c:param name="searchValue" value="${param.valueSearch}"/>
                                            <c:param name="cateID" value="${param.cateID}"/>
                                        </c:url>
                                        <a href="${urlUpdateProduct}" class="btn btn-info">Update</a>
                                        <c:url var="urlDeleteProduct" value="MainController">
                                            <c:param name="action" value="removeProduct"/>
                                            <c:param name="proID" value="${item.productID}"/>
                                            <c:param name="actionSearch" value="${requestScope.ACTIONSEARCH}"/>
                                            <c:param name="searchValue" value="${param.valueSearch}"/>
                                            <c:param name="cateID" value="${param.cateID}"/>
                                        </c:url>
                                        <c:if test="${item.quantity > 0}">
                                            <a href="${urlDeleteProduct}" class="btn btn-danger">Remove</a>    
                                        </c:if>
                                        <c:if test="${item.quantity <= 0}">
                                            <button disabled class="btn btn-danger">Remove</button>    
                                        </c:if>
                                    </c:if>


                                </div>   
                            </div>   
                        </c:forEach>
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
