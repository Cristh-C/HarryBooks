package modelo;

import config.DBConexion;
import java.util.List;

public class ProductosDAO {
    
    public Producto listarIdProducto(int id){
        return (DBConexion.getListarId(id));
    }
    
    public List listar() {
        return (DBConexion.getProductos());
    }
}
