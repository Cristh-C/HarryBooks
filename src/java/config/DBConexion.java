package config;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.Producto;

public class DBConexion {

    private static final String DB_USER = "root";
    private static final String DB_PASS = "Cr1s1996#";
    private static final String DB_URI = "jdbc:mysql://localhost:3306/harrybooks?allowPublicKeyRetrieval=true&useSSL=false";

    public Connection getConexion() {

        try {
            Connection conexion = DriverManager.getConnection(DBConexion.DB_URI, DBConexion.DB_USER, DBConexion.DB_PASS);
            return conexion;
        } catch (SQLException e) {
            System.out.println(e.toString());
            return null;
        }
    }

    public static List<Producto> getProductos() {
        PreparedStatement stmt;
        ResultSet rs;
        List<Producto> productos = new ArrayList<>();
        try {
            Connection conexion = DriverManager.getConnection(DBConexion.DB_URI, DBConexion.DB_USER, DBConexion.DB_PASS);
            stmt = conexion.prepareStatement("SELECT * FROM harrybooks.producto");
            rs = stmt.executeQuery();
            Producto producto;
            while (rs.next()) {
                producto = new Producto();
                producto.setIdProducto(rs.getInt("idproducto"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setNombre(rs.getString("nombre"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setStock(rs.getInt("stock"));
                producto.setImagen(rs.getString("imagen"));
                productos.add(producto);
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
            return null;
        }
        return productos;
    }

    public static Producto getListarId(int id) {
        PreparedStatement stmt;
        ResultSet rs;
        Producto p = new Producto();
        try {
            Connection conexion = DriverManager.getConnection(DBConexion.DB_URI, DBConexion.DB_USER, DBConexion.DB_PASS);
            stmt = conexion.prepareStatement("SELECT * FROM harrybooks.producto WHERE idproducto=" + id);
            rs = stmt.executeQuery();
            while (rs.next()) {
                p.setIdProducto(rs.getInt("idproducto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("imagen"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));
            }
        } catch (Exception e) {
        }
        return p;
    }

    public static void cambiarStock(int idProducto) {
        CallableStatement stmt;
        try {
            Connection conexion = DriverManager.getConnection(DBConexion.DB_URI, DBConexion.DB_USER, DBConexion.DB_PASS);
            stmt = conexion.prepareCall("{call CambiarStock(?)}");
            stmt.setInt("idProducto", idProducto);
            stmt.execute();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
