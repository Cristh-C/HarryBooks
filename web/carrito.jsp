<%-- 
    Document   : carrito
    Created on : 31/01/2022, 11:04:18 AM
    Author     : saint
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/styles.css"/>
        <link rel="stylesheet" href="css/styles_carryshop.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HarryBooks - La mejor tienda de HarryPotter</title>
    </head>
    <body>
        <ul class="page-nav">
            <img src="img/img_logo/Icon.png" width="200" alt="logo"/>
            <li>
                <a class="carry-shop" href="Controlador?accion=home">SEGUIR COMPRANDO</a>
            </li>
        </ul>
        <div class="div-table" style="text-align: center">
            <table summary="Libros de Harry Potter">
                <h1><br>RESUMEN DE TU COMPRA</h1>
                <br>
                <thead>
                    <tr>
                        <th class="col">ITEM</th>
                        <th class="col"></th>
                        <th class="col">LIBRO</th>
                        <th class="col">PRECIO UNITARIO</th>
                        <th class="col">CANTIDAD</th>
                        <th class="col">ACCIÓN</th>
                    </tr>
                </thead>
                <c:forEach var="car" items="${carrito}">
                    <tbody>
                        <tr>
                            <th>${car.getItem()}</th>
                            <td><img src="${car.getDescripcion()}" style="width: 80px"></td>
                            <td>${car.getNombres()}</td>
                            <td>$ ${car.getPrecioCompra()} COP</td>
                            <td>${car.getCantidad()}</td>
                            <td>
                                <input type="hidden" id="idp" value="${car.getIdProducto()}">
                                <a class="delete" href="Controlador?accion=Delete&idp=${car.getItem()}" id="buttonDelete">ELIMINAR</a>
                            </td>
                        </tr>
                    <tbody/>
                </c:forEach>
                <table class="subtotal-table">
                    <br>
                    <thead>
                        <tr>
                            <th>Subtotal:</th>
                            <th>Valor total:</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>$ ${totalPagar} COP</td>
                            <th>$ ${totalPagar} COP</th>
                        </tr>
                    </tbody>
                </table>
                <br/>
                <a class="button-pay" href="Controlador?accion=Comprar&idp=<c:forEach var="car" items="${carrito}">${car.getItem()};</c:forEach>" class="button-shop">PAGAR</a>
        </div>
    </body>
</html>
