/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import config.DBConexion;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Carrito;
import modelo.Producto;
import modelo.ProductosDAO;

/**
 *
 * @author saint
 */
public class Controlador extends HttpServlet {

    ProductosDAO pdao = new ProductosDAO();
    List<Producto> productos = new ArrayList<>();
    Producto producto = new Producto();

    List<Carrito> listaCarrito = new ArrayList<>();
    int item;
    double totalPagar = 0.0;
    int cantidad = 1;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        productos = pdao.listar();
        switch (accion) {
            case "AgregarCarrito":
                int idProducto = Integer.parseInt(request.getParameter("id"));
                producto = pdao.listarIdProducto(idProducto);
                item = item + 1;
                Carrito car = new Carrito();
                car.setItem(item);
                car.setIdProducto(producto.getIdProducto());
                car.setNombres(producto.getNombre());
                car.setDescripcion(producto.getDescripcion());
                car.setPrecioCompra(producto.getPrecio());
                car.setCantidad(cantidad);
                car.setSubTotal(cantidad * producto.getPrecio());
                listaCarrito.add(car);
                request.setAttribute("contador", listaCarrito.size());
                request.getRequestDispatcher("Controlador?accion=shop").forward(request, response);
                break;
            case "Carrito":
                totalPagar = 0.0;
                request.setAttribute("carrito", listaCarrito);
                for (int i = 0; i < listaCarrito.size(); i++) {
                    totalPagar = totalPagar + listaCarrito.get(i).getSubTotal();
                }
                request.setAttribute("totalPagar", totalPagar);
                request.getRequestDispatcher("carrito.jsp").forward(request, response);
                break;

            case "Delete":
                int idproducto = Integer.parseInt(request.getParameter("idp"));
                for (int i = 0; i < this.listaCarrito.size(); i++) {
                    if (this.listaCarrito.get(i).getItem() == idproducto) {
                        this.listaCarrito.remove(i);
                    }
                }
                request.getRequestDispatcher("Controlador?accion=Carrito").forward(request, response);
                break;
            case "Comprar":
                String[] idItemList = request.getParameter("idp").split(";");
                for (int i = 0; i < idItemList.length; i++) {
                    int idItem = Integer.parseInt(idItemList[i]);
                    for (Carrito listaCarrito1 : this.listaCarrito) {
                        if (listaCarrito1.getItem() == idItem) {
                            DBConexion.cambiarStock(this.listaCarrito.get(i).getIdProducto());
                        }
                    }
                }
                request.getRequestDispatcher("confirmacion_compra.jsp").forward(request, response);
                this.listaCarrito.clear();
                break;
            default:
                request.setAttribute("productos", productos);
                request.getRequestDispatcher("shop.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
