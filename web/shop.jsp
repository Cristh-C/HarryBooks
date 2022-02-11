<%-- 
    Document   : index
    Created on : 30/01/2022, 12:59:52 PM
    Author     : saint
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/styles.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HarryBooks - La mejor tienda de HarryPotter</title>
    </head>
    <body>

        <ul class="page-nav">
            <img src="img/img_logo/Icon.png" width="200" alt="logo"/>
            <li>
                <a class="carry-shop" href="Controlador?accion=Carrito">VER CARRITO (<label style="color: orange">${contador}</label>)</a>
            </li>
        </ul>
        <main class="container">
            <h2>¡Mira los libros disponibles!</h2>    
            <c:forEach var="p" items="${productos}">
                <div class="box1 box">
                    <img src="${p.getImagen()}" alt="harry 1">
                    <h2 class="name-book">${p.getNombre()}</h2>
                    <p class="description">${p.getDescripcion()}</p>
                    <h2 class="price">Precio: ${p.getPrecio()} COP</h2>

                    <c:set var="stock" value="${p.getStock()}"></c:set>
                    <c:choose>
                        <c:when test="${stock!=0}">
                            <h2 class="price">Hay ${p.getStock()} disponibles</h2>
                            <a href="Controlador?accion=AgregarCarrito&id=${p.getIdProducto()}" class="button-shop">Agregar</a>
                        </c:when>    
                        <c:otherwise>
                            <h2 class="price" style="color: red">¡AGOTADO!</h2>
                            <button disabled class="button-shop">Agregar</button>
                        </c:otherwise>
                    </c:choose>   
                </div>
            </c:forEach>
        </main>

        <div class="page-content"></div>
    </body>
</html>
