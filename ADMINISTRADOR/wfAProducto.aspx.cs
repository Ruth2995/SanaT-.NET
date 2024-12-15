using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using NPOI.HSSF.UserModel;
using System.Globalization;
using System.Drawing;

namespace swwSanaT.ADMINISTRADOR
{
    public partial class Formulario_web13 : System.Web.UI.Page
    {
        string rutaArchivo = "";
        clsSana objSanaT = new clsSana();
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            //EVENTO DE CARGADO
            CultureInfo.CurrentCulture = new CultureInfo("es-PE");
            if (!IsPostBack)
            {
                //productos();
                //proveedores();
                //inventario();
            }

        }

        void productos()
        {
            ds = new DataSet();
            ds = objSanaT.listarProductosAdmin(Application["cnnVentas"].ToString());
            gvProductosTodos.DataSource = ds;
            gvProductosTodos.DataMember = "Productos";
            gvProductosTodos.DataBind();
        }

        void proveedores()
        {
            ds = new DataSet();
            ds = objSanaT.listarProveedores(Application["cnnVentas"].ToString());
            gvProductos.DataSource = ds;
            gvProductos.DataMember = "Proveedores";
            gvProductos.DataBind();
        }

        void inventario()
        {
            ds = new DataSet();
            ds = objSanaT.listarInventario(Application["cnnVentas"].ToString());
            gvInventario.DataSource = ds;
            gvInventario.DataMember = "Inventario";
            gvInventario.DataBind();
        }

        protected void btnImportarDatos_Click(object sender, EventArgs e)
        {
            
            //SE GENERA UNA RUTA TEMPORAL DEL ARCHIVO PARA QUE PUEDA LEERSE
            rutaArchivo = HttpContext.Current.Server.MapPath("~/Temporal");
            //se verifica que la ruta exista
            if (!Directory.Exists(rutaArchivo))
            {
                Directory.CreateDirectory(rutaArchivo);
            }
            //se guarda de manera local el archivo
            var rutaG = Path.Combine(rutaArchivo, fulSeleccionar.FileName);
            fulSeleccionar.SaveAs(rutaG);
            //SE CREA UN NUEVO LIBRO
            IWorkbook Miexcel = null;
            //se accede al archivo en modo lectura
            FileStream fs = new FileStream(rutaG, FileMode.Open, FileAccess.Read);

            if (Path.GetExtension(rutaG) == ".xlsx")
            {
                Miexcel = new XSSFWorkbook(fs);
            }
            else
            {
                Miexcel = new HSSFWorkbook(fs);
            }
            //generar nueva hoja
            ISheet hoja = Miexcel.GetSheetAt(0);

            DataTable table = new DataTable();
            table.Columns.Add("ID", typeof(string));
            table.Columns.Add("PROVEEDOR", typeof(string));
            table.Columns.Add("NOMBRE", typeof(string));
            table.Columns.Add("INGREDIENTES", typeof(string));
            table.Columns.Add("DESCRIPCION", typeof(string));
            table.Columns.Add("PRESENTACION", typeof(string));
            table.Columns.Add("CATEGORIA", typeof(string));
            table.Columns.Add("SABORTIPO", typeof(string));
            table.Columns.Add("UNIDADES", typeof(string));
            table.Columns.Add("GRAMOSMILILITROS", typeof(string));
            table.Columns.Add("PRECIO", typeof(string));
            table.Columns.Add("MODOUSO", typeof(string));
            table.Columns.Add("IMAGEN", typeof(string));
             

            if (hoja != null)
            {
                int cantidadfilas = hoja.LastRowNum;
                for (int i = 1; i <= cantidadfilas; i++)
                {
                    IRow fila = hoja.GetRow(i);
                    if (fila != null)
                    {
                        table.Rows.Add(
                            fila.GetCell(0, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(0, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(1, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(1, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(2, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(2, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(3, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(3, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(4, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(4, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(5, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(5, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(6, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(6, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(7, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(7, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(8, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(8, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(9, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(9, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(10, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(10, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(11, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(11, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(12, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(12, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : ""
                            );
                    }

                }
                lblProductosRegistrados.Visible = false;
                gvProductos.DataSource = table;
                gvProductos.DataBind();
                lblSeleccion2.Visible = false;
                lblRegistro.Visible = true;
                fulSeleccionar.Visible = true;
                btnImportarDatos.Visible = true;
                btnRegistrar.Visible = true;
                btnProductosActuales.Visible = true;


            }
            gvProductos.Visible = true;
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            lblRegistro.Visible = true;
            fulSeleccionar.Visible = true;
            btnImportarDatos.Visible = true;
            btnRegistrar.Visible = true;
            btnProductosActuales.Visible = true;
            int res = 0, conR = 0;
            if (gvProductos.Rows.Count >= 1)
            {
                //se ejecuta el metodo para insertar datos
                for (int i = 0; i < gvProductos.Rows.Count; i++)
                {
                    res = objSanaT.insertarProducto(Application["cnnVentas"].ToString(),
                         int.Parse(gvProductos.Rows[i].Cells[0].Text),
                         int.Parse(gvProductos.Rows[i].Cells[1].Text),
                         gvProductos.Rows[i].Cells[2].Text,
                         gvProductos.Rows[i].Cells[3].Text,
                         gvProductos.Rows[i].Cells[4].Text, 
                         gvProductos.Rows[i].Cells[5].Text,
                         int.Parse(gvProductos.Rows[i].Cells[6].Text),
                         gvProductos.Rows[i].Cells[7].Text,
                         int.Parse(gvProductos.Rows[i].Cells[8].Text),gvProductos.Rows[i].Cells[9].Text,
                         float.Parse(gvProductos.Rows[i].Cells[10].Text),gvProductos.Rows[i].Cells[11].Text, gvProductos.Rows[i].Cells[12].Text);

                    if (res == 0)
                        gvProductos.Rows[i].BackColor = Color.Red;
                    else
                    {
                        gvProductos.Rows[i].BackColor = Color.Green;
                    }
                    lblRegistro.Text = "Productos registrados: " + conR.ToString();

                }
                Response.Write("<script language='javascript'>alert('Verificar " +
                    "registros insertados, lo que fueron insertados en la Base" + " de datos están en color rojo. No olvide agregar inventario a sus " +
                    "productos');</script>");
                lblProductosRegistrados.Visible = true;
            }
            gvProductos.Visible = true;
            lblProductosRegistrados.Visible = true;
        }


        protected void btnProductosActuales_Click(object sender, EventArgs e)
        {
            gvProductosTodos.Visible = true;
            productos();
            gvProductos.Visible = false;
        }

        protected void gvProductosTodos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //SE GENERA LA NUEVA PÁGINA DE DATOS
            gvProductosTodos.PageIndex = e.NewPageIndex;

            //SE LLENA DE REGISTROS
            productos();
        }

        protected void btnProducto_Click(object sender, EventArgs e)
        {
            lblRegistro.Visible = true;
            lblSeleccion2.Visible = true;
            fulSeleccionar.Visible = true;
            btnImportarDatos.Visible = true;
            btnRegistrar.Visible = true;
            btnProductosActuales.Visible = true;
            gvProductos.Visible = false;
            lblRegistroP.Visible = false;
            lblSeleccion2P.Visible = false;
            fulSeleccionarP.Visible = false;
            btnImportarP.Visible = false;
            btnRegistrarP.Visible = false;
            btnProveedores.Visible = false;
            lblRegistroI.Visible = false;
            lblSeleccion2I.Visible = false;
            fulSeleccionarI.Visible = false;
            btnImportarI.Visible = false;
            btnRegistrarI.Visible = false;
            btnInventarioActual.Visible = false;
            gvProductos.Visible = false;
            gvProductosTodos.Visible = false;
            gvInventario.Visible = false;
            lblProductosRegistrados.Visible = false;

        }

        protected void btnProveedor_Click(object sender, EventArgs e)
        {
            lblRegistroP.Visible = true;
            lblSeleccion2P.Visible = true;
            fulSeleccionarP.Visible = true;
            btnImportarP.Visible = true;
            btnRegistrarP.Visible = true;
            btnProveedores.Visible = true;
            lblRegistro.Visible = false;
            lblRegistroI.Visible = false;
            lblSeleccion2.Visible = false;
            lblSeleccion2I.Visible = false;
            fulSeleccionar.Visible = false;
            fulSeleccionarI.Visible = false;
            btnImportarI.Visible = false;
            btnInventarioActual.Visible = false;
            btnRegistrarI.Visible = false;
            btnImportarDatos.Visible = false;
            btnRegistrar.Visible = false;
            btnProductosActuales.Visible = false;
            gvProductos.Visible = false;
            gvProductosTodos.Visible = false;
            gvInventario.Visible = false;
            lblProductosRegistrados.Visible = false;
        }

        protected void btnImportarP_Click(object sender, EventArgs e)
        {
            //SE GENERA UNA RUTA TEMPORAL DEL ARCHIVO PARA QUE PUEDA LEERSE
            rutaArchivo = HttpContext.Current.Server.MapPath("~/Temporal");
            //se verifica que la ruta exista
            if (!Directory.Exists(rutaArchivo))
            {
                Directory.CreateDirectory(rutaArchivo);
            }
            //se guarda de manera local el archivo
            var rutaG = Path.Combine(rutaArchivo, fulSeleccionarP.FileName);
            fulSeleccionarP.SaveAs(rutaG);
            //SE CREA UN NUEVO LIBRO
            IWorkbook Miexcel = null;
            //se accede al archivo en modo lectura
            FileStream fs = new FileStream(rutaG, FileMode.Open, FileAccess.Read);

            if (Path.GetExtension(rutaG) == ".xlsx")
            {
                Miexcel = new XSSFWorkbook(fs);
            }
            else
            {
                Miexcel = new HSSFWorkbook(fs);
            }
            //generar nueva hoja
            ISheet hoja = Miexcel.GetSheetAt(0);

            DataTable table = new DataTable();
            table.Columns.Add("NOMBRE", typeof(string));
            table.Columns.Add("CIUDAD", typeof(string));
            table.Columns.Add("MUNICIPIO", typeof(string));
            table.Columns.Add("ESTADO", typeof(string));
            table.Columns.Add("CODIGOPOSTAL", typeof(string));
            table.Columns.Add("TELEFONO", typeof(string));
            

            if (hoja != null)
            {
                int cantidadfilas = hoja.LastRowNum;
                for (int i = 1; i <= cantidadfilas; i++)
                {
                    IRow fila = hoja.GetRow(i);
                    if (fila != null)
                    {
                        table.Rows.Add(
                            fila.GetCell(0, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(0, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(1, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(1, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(2, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(2, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(3, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(3, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(4, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(4, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(5, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(5, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : ""
                            );
                    }

                }
                lblProductosRegistrados.Visible = false;
                gvProductos.DataSource = table;
                gvProductos.DataBind();
                lblSeleccion2P.Visible = false;
                lblRegistroP.Visible = true;
                fulSeleccionarP.Visible = true;
                btnImportarP.Visible = true;
                btnRegistrarP.Visible = true;
                btnProveedores.Visible = true;
                gvProductos.Visible = true;

            }
        }

        protected void btnRegistrarP_Click(object sender, EventArgs e)
        {
            lblRegistroP.Visible = true;
            fulSeleccionarP.Visible = true;
            btnImportarP.Visible = true;
            btnRegistrarP.Visible = true;
            btnProveedores.Visible = true;

            int res = 0, conR = 0;
            if (gvProductos.Rows.Count >= 1)
            {
                //se ejecuta el metodo para insertar datos
                for (int i = 0; i < gvProductos.Rows.Count; i++)
                {
                    res = objSanaT.insertarProveedor(Application["cnnVentas"].ToString(),
                         gvProductos.Rows[i].Cells[0].Text,
                         gvProductos.Rows[i].Cells[1].Text,
                         gvProductos.Rows[i].Cells[2].Text,
                         gvProductos.Rows[i].Cells[3].Text, int.Parse(gvProductos.Rows[i].Cells[4].Text),
                         gvProductos.Rows[i].Cells[5].Text);

                    if (res == 0)
                        gvProductos.Rows[i].BackColor = Color.Red;
                    else
                    {
                        gvProductos.Rows[i].BackColor = Color.Green;
                    }
                    lblRegistro.Text = "Proveedores registrados: " + conR.ToString();
                    

                }
                Response.Write("<script language='javascript'>alert('Verificar " +
                    "registros insertados, lo que fueron insertados en la Base" + " de datos están en color rojo');</script>");
            }
            gvProductos.Visible = true;
            lblProductosRegistrados.Visible = true;
        }

        protected void btnProveedores_Click(object sender, EventArgs e)
        {
            gvProductosTodos.Visible = false;
            proveedores();
            gvProductos.Visible = true;
            lblRegistroP.Visible = true;
            lblSeleccion2P.Visible = true;
            fulSeleccionarP.Visible = true;
            btnImportarP.Visible = true;
            btnRegistrarP.Visible = true;
            btnProveedores.Visible = true;
        }

        protected void btnInventario_Click(object sender, EventArgs e)
        {
            lblProductosRegistrados.Visible = true;
            lblSeleccion2I.Visible = true;
            lblRegistroI.Visible = true;
            fulSeleccionarI.Visible = true;
            btnImportarI.Visible = true;
            btnRegistrarI.Visible = true;
            btnInventarioActual.Visible = true;
            lblRegistroP.Visible = false;
            lblSeleccion2P.Visible = false;
            fulSeleccionarP.Visible = false;
            btnImportarP.Visible = false;
            btnRegistrarP.Visible = false;
            btnProveedores.Visible = false;
            lblRegistro.Visible = false;
            lblSeleccion2.Visible = false;
            fulSeleccionar.Visible = false;
            btnImportarDatos.Visible = false;
            btnRegistrar.Visible = false;
            btnProductosActuales.Visible = false;
            gvProductos.Visible = false;
            gvProductosTodos.Visible = false;
            gvInventario.Visible = false;
            lblProductosRegistrados.Visible = false;
        }

        protected void btnImportarI_Click(object sender, EventArgs e)
        {
            //SE GENERA UNA RUTA TEMPORAL DEL ARCHIVO PARA QUE PUEDA LEERSE
            rutaArchivo = HttpContext.Current.Server.MapPath("~/Temporal");
            //se verifica que la ruta exista
            if (!Directory.Exists(rutaArchivo))
            {
                Directory.CreateDirectory(rutaArchivo);
            }
            //se guarda de manera local el archivo
            var rutaG = Path.Combine(rutaArchivo, fulSeleccionarI.FileName);
            fulSeleccionarI.SaveAs(rutaG);
            //SE CREA UN NUEVO LIBRO
            IWorkbook Miexcel = null;
            //se accede al archivo en modo lectura
            FileStream fs = new FileStream(rutaG, FileMode.Open, FileAccess.Read);

            if (Path.GetExtension(rutaG) == ".xlsx")
            {
                Miexcel = new XSSFWorkbook(fs);
            }
            else
            {
                Miexcel = new HSSFWorkbook(fs);
            }
            //generar nueva hoja
            ISheet hoja = Miexcel.GetSheetAt(0);

            DataTable table = new DataTable();
            table.Columns.Add("CLAVEPRODUCTO", typeof(string));
            table.Columns.Add("CANTIDAD", typeof(string));


            if (hoja != null)
            {
                int cantidadfilas = hoja.LastRowNum;
                for (int i = 1; i <= cantidadfilas; i++)
                {
                    IRow fila = hoja.GetRow(i);
                    if (fila != null)
                    {
                        table.Rows.Add(
                            fila.GetCell(0, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(0, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : "",
                            fila.GetCell(1, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(1, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : ""
                            );
                    }

                }
                lblProductosRegistrados.Visible = false;
                gvProductos.DataSource = table;
                gvProductos.DataBind();
                lblSeleccion2I.Visible = false;
                lblRegistroI.Visible = true;
                fulSeleccionarI.Visible = true;
                btnImportarI.Visible = true;
                btnRegistrarI.Visible = true;
                btnInventarioActual.Visible = true;

            }

            gvProductos.Visible = true;
        }

        protected void btnRegistrarI_Click(object sender, EventArgs e)
        {
            lblRegistroI.Visible = true;
            fulSeleccionarI.Visible = true;
            btnImportarI.Visible = true;
            btnRegistrarI.Visible = true;
            btnInventarioActual.Visible = true;
            int res = 0, conR = 0;
            if (gvProductos.Rows.Count >= 1)
            {
                //se ejecuta el metodo para insertar datos
                for (int i = 0; i < gvProductos.Rows.Count; i++)
                {
                    res = objSanaT.insertarInventario(Application["cnnVentas"].ToString(),
                         int.Parse(gvProductos.Rows[i].Cells[0].Text),
                         int.Parse(gvProductos.Rows[i].Cells[1].Text));

                    if (res == 0)
                        gvProductos.Rows[i].BackColor = Color.Red;
                    else
                    {
                        gvProductos.Rows[i].BackColor = Color.Green;
                    }
                    lblRegistro.Text = "Inventario registrado: " + conR.ToString();
                    

                }
                Response.Write("<script language='javascript'>alert('Verificar " +
                    "registros insertados, lo que fueron insertados en la Base" + " de datos están en color rojo');</script>");
            }
            gvProductos.Visible = true;
            lblProductosRegistrados.Visible = true;
        }

        protected void btnInventarioActual_Click(object sender, EventArgs e)
        {
            gvProductosTodos.Visible = false;
            inventario();
            gvInventario.Visible = true;
            gvProductos.Visible = false;
            lblRegistroI.Visible = true;
            fulSeleccionarI.Visible = true;
            btnImportarI.Visible = true;
            btnRegistrarI.Visible = true;
            btnInventarioActual.Visible = true;

        }
        protected void gvProductos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            // SE GENERA LA NUEVA PÁGINA DE DATOS
            gvProductos.PageIndex = e.NewPageIndex;
        }

        protected void gvInventario_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvInventario.PageIndex = e.NewPageIndex;
            inventario();
        }
    }
}