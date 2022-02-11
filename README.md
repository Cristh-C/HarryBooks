
##HarryBooks
>Es una página web donde se pueden realizar ***"compras"* **de los libros de Harry Potter, escritos por la autora **J.K. Rowling**.

### Información

* *La interfaz está diseñada principalmente con código **HTML**, **CSS**. Aunque sus extensiones son **.jsp***.
* *Su back-end está en lenguaje **Java**, haciendo uso de **JPA***.
* *Base de datos creada en **MySQL***. 

### Funcionamiento

Este realiza una consulta a la base de datos donde tiene almacenada la información de los libros, tales como:

>* Su portada.
>* Nombre.
>* Sinopsis.
>* Precio.
>* Cantidades disponibles.

Y se muestran en las etiquetas **HTML**. Al realizar clic en el botón **Agregar** este añade una cantidad en el carrito de compra, en la esquina superior derecha se verá la cantidad de libros que han sido agregadas al carrito. Al dar clic, este redirige al listado de compra con las unidades y el valor total. Al dar clic en comprar, aparecerá que la compra ha sido realizada satisfactoriamente y se descuenta la cantidad de libros comprada en la BD.

Si no hay disponibilidad de libros, se mostrará el mensaje "**Agotado**", y el botón de **Agregar** estará inhabilitado.
