using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
//AGREGAR LAS LIBRERIAS QUE PERMITEN MANEJAR INSTRUCCIONES DE MYSQL
using System.Data;
//MANEJAR TODOS LOS REGISTROS QUE LLEGAN DE MYSQL
using MySql.Data;
//EJECUTAR LAS INSTRUCCIONES DE MYSQL COMO SP
using MySql.Data.MySqlClient;

namespace swwSanaT
{
    public class clsSana
    {
        //ATRIBUTOS DE LA CLASE (MIENTRAS SOLO DEL ACCESO)
        string usuario;
        string contra;
        string nomUsuario;
        string rol;
        int clave;

        public string Usuario { get => usuario; set => usuario = value; }
        public string Contra { get => contra; set => contra = value; }
        public string NomUsuario { get => nomUsuario; set => nomUsuario = value; }
        public string Rol { get => rol; set => rol = value; }
        public int Clave { get => clave; set => clave = value; }

        //VARIABLES DE LA CLASE QUE PERMITIRAN TRABAJAR CON LOS DATOS DE MYSQL
        // PERMITE USER LA CADENA DE CONEXIÓN
        public MySqlConnection cnn;
        //EJECUTAR LOS COMANDOS DE LA BASE DE DATOS: INSTRUCCIONES
        public MySqlCommand cmd;
        //RECIBE RESULTADOS DE UNA CONSULTA, INSERCIÓN, MODIFICACIÓN, O BORRADO
        //PERO SUS DATOS VAN AUN SOLO CONTROL
        public MySqlDataAdapter da;
        //RECIBE LO MISMO QUE EL ADAPTER, PERO SUS DATOS PUEDEN COLOCARSE EN DIFERENTES CONTROLES
        public MySqlDataReader dr;
        //RECIBE UN CONJUNTO DE REGISTROS, PERO NO TIPEADOS
        public DataSet ds;

        //CONSTRUCTOR Y DESTRUCTOR DE LA CLASE
        public clsSana()
        {
            clave = 0;
            nomUsuario = "";
            rol = "";
            usuario = "";
            contra = "";
        }

        ~clsSana()
        {
            System.GC.Collect();
        }

        //METODO DE LA CLASE
        //VALIDAR ACCESO: tspValidarAcceso(usu, contra) -->0 ó clave

        public void validarAcceso(string cadConexion)
        {
            //GENERAR UNA COPIA DE LA CADENA DE CONEXIÓN
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;

            //GENERAR UNA COPIA DEL COMMAND
            cmd = new MySqlCommand();

            //EJECUTAR EL PROCEDIMIENTO QUE VA VALIDAR EL ACCESO DEL USUARIO
            cmd.CommandText = "call tspValidarAccesoSanaT('" + Usuario + "','" + Contra + "');";

            //ASIGNAR LA CADENA DE CONEXIÓN DONDE SE ENCUENTRA EL PROCEDIMIENTO
            cmd.Connection = cnn;

            //ABRIR LA CONEXIÓN
            cnn.Open();

            //
            //EJECUTAR EL COMANDO
            dr = cmd.ExecuteReader();

            //LEER LOS REGISTROS QUE RECIBIO EL DATAREADER
            while (dr.Read())
            {
                //OBTIENE EL PRIMER CAMPO QUE REGRESA PARA VER SI ES CERO
                clave = int.Parse(dr.GetValue(0).ToString());
                if (clave != 0)
                {
                    //OBTIENE NOMBRE DE USUARIO Y ROL
                    nomUsuario = dr.GetValue(1).ToString();
                    rol = dr.GetValue(2).ToString();
                }
            }

            //CERRAR LA LECTURA DE LOS REGISTROS
            dr.Close();

            //CERRAR LA CONEXIÓN DE LA BD
            cnn.Close();
        }//FIN VALIDAR ACCESO

        //MÉTODOS DEL CARRITO DE COMPRAS
        public DataSet listarVentasCliente(string cadConexion, int cliente)
        {
            da = new MySqlDataAdapter("spMostrarVentasCliente('" + cliente + "');", cadConexion);
            ds = new DataSet();
            //fill --> hace un vaciado de los datos del adapter al dataset
            //ventas realizadas --> datamember, es como de identifican los registros
            da.Fill(ds, "VentasRealizadas");
            return ds;
        }

        //LISTAR LOS PRODUCTOS QUE SE PUEDEN COMPRAR
        public DataSet listarProductos(string cadConexion)
        {
            da = new MySqlDataAdapter("spProductosComprar();", cadConexion);
            ds = new DataSet();
            da.Fill(ds, "Productos");
            return ds;
        }

        public DataSet listarProductosAdmin(string cadConexion)
        {
            da = new MySqlDataAdapter("spProductosAdmin();", cadConexion);
            ds = new DataSet();
            da.Fill(ds, "Productos");
            return ds;
        }

        public DataSet listarProveedores(string cadConexion)
        {
            da = new MySqlDataAdapter("spListarProveedores();", cadConexion);
            ds = new DataSet();
            da.Fill(ds, "Proveedores");
            return ds;
        }

        public DataSet listarInventario(string cadConexion)
        {
            da = new MySqlDataAdapter("spListarInventario();", cadConexion);
            ds = new DataSet();
            da.Fill(ds, "Inventario");
            return ds;
        }

        //INSERTAR NUEVA VENTA
        public string insertarVenta(string cadConexion, int cveCliente, float total)
        {
            string resultado = "0";
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call spRegistrarNuevaVenta('" + cveCliente + "','" + total + "');";
            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                resultado = dr.GetValue(0).ToString();
            }
            dr.Close();
            cnn.Close();
            return resultado;
        }

        //INSERTAR DETALLE COMPRA
        public string insertarDetalleCompra(string cadConexion, int cveVenta, int cveProd, int cantidad, double subtotal)
        {
            string resultadoConsulta = "";
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call spRegistrarDetalleCompra('" + cveVenta + "','" + cveProd + "','" + cantidad + "','" + subtotal + "');";
            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();
            resultadoConsulta = "0";
            while (dr.Read())
            {
                resultadoConsulta = dr.GetValue(0).ToString();
            }
            dr.Close();
            cnn.Close();
            return resultadoConsulta;
        }

        //LISTAR DETALLE COMPRA
        public DataSet listarDetalleCompra(string cadConexion, int cveVenta)
        {
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.Connection = cnn;
            cmd.CommandText = "call spDetalleCompraActual('" + cveVenta + "');";
            da = new MySqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds, "VentaActual");
            return ds;
        }

        //ELIMINAR COMPRA
        public string eliminarProductoDetalleCompra(string cadConexion, int cveVenta, int cveProd, int cantidad)
        {
            string resultadoConsulta = "";
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call spEliminarProductoCompra('" + cveVenta + "','" + cveProd + "','" + cantidad + "');";
            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();
            resultadoConsulta = "0";
            while (dr.Read())
            {
                resultadoConsulta = dr.GetValue(0).ToString();
            }
            dr.Close();
            cnn.Close();
            return resultadoConsulta;
        }

        //CONFIRMAR COMPRA
        public string confirmarCompra(string cadConexion, int cveVenta, float total)
        {
            string resultadoConsulta = "";
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call spConfirmarVenta('" + cveVenta + "','" + total + "');";
            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();
            resultadoConsulta = "0";
            while (dr.Read())
            {
                resultadoConsulta = dr.GetValue(0).ToString();
            }
            dr.Close();
            cnn.Close();
            return resultadoConsulta;
        }

        public DataSet listarUsuarios(string cadConexion, int cveCliente, int op)
        {
            da = new MySqlDataAdapter("tspListarUsuarios1('" + op + "','" + cveCliente + "');", cadConexion);
            ds = new DataSet();
            //fill --> hace un vaciado de los datos del adapter al dataset
            //ventas realizadas --> datamember, es como de identifican los registros
            da.Fill(ds, "ListaUsuarios");
            return ds;
        }

        public DataSet listarUsuarios1(string cadConexion, int cveCliente, int op)
        {
            da = new MySqlDataAdapter("tspListarUsuarios1('" + op + "','" + cveCliente + "');", cadConexion);
            ds = new DataSet();
            //fill --> hace un vaciado de los datos del adapter al dataset
            //ventas realizadas --> datamember, es como de identifican los registros
            da.Fill(ds, "ListaUsuarios1");
            return ds;
        }

        public DataSet listarDatosUsuario(string cadConexion, int claveUsuario)
        {
            da = new MySqlDataAdapter("spListarDatosUsuario('" + claveUsuario + "');", cadConexion);
            ds = new DataSet();
            da.Fill(ds, "listarDatosUsuario");
            return ds;
        }

        public string cancelarVenta(string cadConexion, int cveVenta)
        {
            string resultadoConsulta = "";
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call spCancelarVenta('" + cveVenta + "');";
            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();
            resultadoConsulta = "0";
            while (dr.Read())
            {
                resultadoConsulta = dr.GetValue(0).ToString();
            }
            dr.Close();
            cnn.Close();
            return resultadoConsulta;
        }

        public string cerrarCarrito(string cadConexion, int cveVenta)
        {
            string resultadoConsulta = "";
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call spCerrarCarrito('" + cveVenta + "');";
            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();
            resultadoConsulta = "0";
            while (dr.Read())
            {
                resultadoConsulta = dr.GetValue(0).ToString();
            }
            dr.Close();
            cnn.Close();
            return resultadoConsulta;
        }

        //registrar productos
        public int insertarProducto(string cadConexion, int id, int provedor, string nombre,
            string ingred, string descrip, string present, int categ,
            string sabtipo, int unidades, string gramMili, float costo, string modoUso, string imagen)
        {
            int resultado = 0;
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call spRegistrarProducto('" + id + "','" + provedor + "','" + nombre + "','" + ingred + "','" +
                descrip + "','" + present + "','" + categ + "','" + sabtipo + "','" + unidades + "','" + gramMili + "','" + 
                costo + "','" + modoUso + "','" + imagen + "');";
            cmd.Connection = cnn;
            cnn.Open();
            resultado = cmd.ExecuteNonQuery();

            cnn.Close();
            return resultado;
        }

        public DataSet productosTodos(string cadConexion)
        {
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.Connection = cnn;
            cmd.CommandText = "call spProductosTodos();";
            da = new MySqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds, "productosTodos");
            return ds;
        }

        public int insertarUsuario(string cadConexion, int rol,
            string nombre, string apater, string amater, string munici,
            string estado, string correo, string celu, string usuari, string contra, int estatu)
        {
            int resultado = 0;
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call spRegistrarUsuario('" + rol + "','" + nombre + "','" +
                apater + "','" + amater + "','" + munici + "','" + estado + "','" + correo + "','" + celu + "','" +
                usuari + "','" + contra + "','" + estatu + "');";
            cmd.Connection = cnn;
            cnn.Open();
            resultado = cmd.ExecuteNonQuery();

            cnn.Close();
            return resultado;
        }

        public int insertarInventario(string cadConexion, int produc, int canti)
        {
            int resultado = 0;
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call spRegistrarInventario('" + produc + "','" + canti + "');";
            cmd.Connection = cnn;
            cnn.Open();
            resultado = cmd.ExecuteNonQuery();

            cnn.Close();
            return resultado;
        }

        public int insertarProveedor(string cadConexion, string nombre, string ciudad, string munici, string estado, int codpos, string telef)
        {
            int resultado = 0;
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call spRegistrarProveedor('" + nombre + "','" + ciudad + "','" + munici + "','" + estado + "','" + codpos + "','" + telef + "');";
            cmd.Connection = cnn;
            cnn.Open();
            resultado = cmd.ExecuteNonQuery();

            cnn.Close();
            return resultado;
        }

        public DataSet listarVenUsuario(string cadConexion, int cveCliente)
        {
            da = new MySqlDataAdapter("spReporteVentasCliente('" + cveCliente + "');", cadConexion);
            ds = new DataSet();
            //fill --> hace un vaciado de los datos del adapter al dataset
            //ventas realizadas --> datamember, es como de identifican los registros
            da.Fill(ds, "ListaVenUsuario");
            return ds;
        }

        public DataSet listarVentas(string cadConexion)
        {
            da = new MySqlDataAdapter("spReporteVentasTodos();", cadConexion);
            ds = new DataSet();
            //fill --> hace un vaciado de los datos del adapter al dataset
            //ventas realizadas --> datamember, es como de identifican los registros
            da.Fill(ds, "ListaVentas");
            return ds;
        }

        public int cantUsuarios(string cadConexion)
        {

            int resultado = 0;
            using (MySqlConnection cnn = new MySqlConnection(cadConexion))
            {
                using (MySqlCommand cmd = new MySqlCommand("CALL spCantUsuarios();", cnn))
                {
                    cnn.Open();
                    // Utiliza ExecuteScalar para obtener un único valor
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        resultado = Convert.ToInt32(result);
                    }
                }
            }

            return resultado;
        }

        public DataSet productosMasVendidos(string cadConexion)
        {
            da = new MySqlDataAdapter("spProductoMasVendido();", cadConexion);
            ds = new DataSet();
            //fill --> hace un vaciado de los datos del adapter al dataset
            //ventas realizadas --> datamember, es como de identifican los registros
            da.Fill(ds, "MasVendido");
            return ds;
        }

        public DataSet productosMenosVendidos(string cadConexion)
        {
            da = new MySqlDataAdapter("spProductoMenosVendido();", cadConexion);
            ds = new DataSet();
            //fill --> hace un vaciado de los datos del adapter al dataset
            //ventas realizadas --> datamember, es como de identifican los registros
            da.Fill(ds, "MenosVendido");
            return ds;
        }


    }

}