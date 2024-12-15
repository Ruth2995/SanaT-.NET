using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//AGREGAR LIBRERIA DE MANEJO DE DATOS
using System.Data;
using System.IO;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using NPOI.HSSF.UserModel;
using System.Globalization;
using System.Drawing;

namespace swwSanaT.ADMINISTRADOR
{
    public partial class Formulario_web12 : System.Web.UI.Page
    {

        //COPIA DE LA CLASE
        clsSana objSanaT = new clsSana();
        string rutaArchivo = "";
        //VARIABLE QUE RECIBE A LOS REGISTROS PARA MOSTRARLOS EN EL GRIDVIEW
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                listaUsuarios();
            }
            //EVENTO DE CARGADO
            CultureInfo.CurrentCulture = new CultureInfo("es-PE");
        }

        void limpiarControles()
        {
            txtOP.Text = "";
            txtOP.Focus();
        }


        //1. LLENAR VENTAS REALIZADAS DEL CLIENTE
        void listaUsuarios()
        {
            string id = "";
            ds = new DataSet();
            ds = objSanaT.listarUsuarios(Application["cnnVentas"].ToString(), int.Parse(Session["cveUsuario"].ToString()), 0);

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                id = dr["USU_ID"].ToString();
                break;
            }
            if (id != "0")
            {
                gvListaUsuarios.DataSource = ds;
                gvListaUsuarios.DataMember = "listaUsuarios";
                gvListaUsuarios.DataBind();
                
            }
            else
            {
                lblUsuario.Text = "Por el momento no hay usuarios";
            }

            

        }
        int USUID;
        void listaUsuarios1(int USUID)
        {
            ds = new DataSet();
            ds = objSanaT.listarUsuarios1(Application["cnnVentas"].ToString(), USUID, 1);

            
            if (ds.Tables[0].Rows.Count > 0)
            {
                gvListarUsuario.DataSource = ds;
                gvListarUsuario.DataMember = "listaUsuarios1";
                gvListarUsuario.DataBind();
            }
            else
            {
                lblUsuario.Text = "No se encontró el ID del usuario";
                limpiarControles();
            }

        }


        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //SE GENERA LA NUEVA PÁGINA DE DATOS
            gvListaUsuarios.PageIndex = e.NewPageIndex;

            //SE LLENA DE REGISTROS LA PÁGINA
            listaUsuarios();
        }

        protected void btnTodosUsuarios_Click(object sender, EventArgs e)
        {
            gvListaUsuarios.Visible = true;
            lblUsuario.Visible = false;
            lblIngresa.Visible = false;
            btnBuscar.Visible = false;
            gvListarUsuario.Visible = false;
            txtOP.Visible = false;
            lblSeleccionado.Visible = false;
            fulArchivo.Visible = false;
            btnImportar.Visible = false;
            btnRegistrarU.Visible = false;
            gvRegistroUsuario.Visible = false;

        }

        protected void gvListarUsuario_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvListarUsuario.PageIndex = e.NewPageIndex;

            //SE LLENA DE REGISTROS LA PÁGINA
            if (int.TryParse(txtOP.Text, out USUID))
            {
                listaUsuarios1(USUID);
            }
            else
            {
                lblUsuario.Text = "Ingresa un ID válido";

                limpiarControles();
 

            }
        }

        protected void btnBuscarUsuario_Click(object sender, EventArgs e)
        {
            lblIngresa.Visible = true;
            txtOP.Visible = true;
            btnBuscar.Visible = true;
            btnTodosUsuarios.Visible = true;
            gvListaUsuarios.Visible = false;
            lblUsuario.Visible = false;
            lblSeleccionado.Visible = false;
            fulArchivo.Visible = false;
            btnImportar.Visible = false;
            btnRegistrarU.Visible = false;
            gvRegistroUsuario.Visible = false;
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            gvListarUsuario.Visible = true;
            // SE LLENA DE REGISTROS LA PÁGINA
            if (int.TryParse(txtOP.Text, out USUID) && USUID > 0)
            {
                int cantidad = objSanaT.cantUsuarios(Application["cnnVentas"].ToString());
                if (USUID <= cantidad)
                {
                    listaUsuarios1(USUID);
                    lblUsuario.Visible = false;
                }
                else
                {
                    Response.Write("<script language='javascript'>" + "alert('¡Debes agregar un ID que exista!');" + "</script>");
                    limpiarControles();
                    lblUsuario.Text = "Ingresa un ID existente";
                    gvListarUsuario.Visible = false;
                    limpiarControles();
                }

            }
            else
            {
                Response.Write("<script language='javascript'>" + "alert('Debes agregar un ID numérico!');" + "</script>");
                limpiarControles();
                lblUsuario.Text = "Ingresa un ID válido";
                lblUsuario.Visible = true;
                gvListarUsuario.Visible = false;
                limpiarControles();
            }
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            lblSeleccionado.Visible = true;
            fulArchivo.Visible = true;
            btnImportar.Visible = true;
            btnRegistrarU.Visible = true;
            gvListaUsuarios.Visible = false;
            lblIngresa.Visible = false;
            txtOP.Visible = false;
            btnBuscar.Visible = false;
            gvListarUsuario.Visible = false;

        }

        protected void btnImportar_Click(object sender, EventArgs e)
        {
            //SE GENERA UNA RUTA TEMPORAL DEL ARCHIVO PARA QUE PUEDA LEERSE
            rutaArchivo = HttpContext.Current.Server.MapPath("~/Temporal");
            //se verifica que la ruta exista
            if (!Directory.Exists(rutaArchivo))
            {
                Directory.CreateDirectory(rutaArchivo);
            }
            //se guarda de manera local el archivo
            var rutaG = Path.Combine(rutaArchivo, fulArchivo.FileName);
            fulArchivo.SaveAs(rutaG);
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
            table.Columns.Add("ROL", typeof(string));
            table.Columns.Add("NOMBRE", typeof(string));
            table.Columns.Add("APATERNO", typeof(string));
            table.Columns.Add("AMATERNO", typeof(string));
            table.Columns.Add("MUNICIPIO", typeof(string));
            table.Columns.Add("ESTADO", typeof(string));
            table.Columns.Add("CORREO", typeof(string));
            table.Columns.Add("CELULAR", typeof(string));
            table.Columns.Add("USUARIO", typeof(string));
            table.Columns.Add("CONTRASEÑA", typeof(string));
            table.Columns.Add("ESTATUS", typeof(string));

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
                            fila.GetCell(10, MissingCellPolicy.RETURN_NULL_AND_BLANK) != null ? fila.GetCell(10, MissingCellPolicy.RETURN_NULL_AND_BLANK).ToString() : ""
                            );
                    }

                }

                gvRegistroUsuario.DataSource = table;
                gvRegistroUsuario.DataBind();
                gvListarUsuario.Visible = false;
                gvRegistroUsuario.Visible = true;
                
            }
        }

        protected void gvRegistroUsuario_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            // SE GENERA LA NUEVA PÁGINA DE DATOS
            gvListaUsuarios.PageIndex = e.NewPageIndex;
        }

        protected void btnRegistrarU_Click(object sender, EventArgs e)
        {
            int res = 0, conR = 0;
            if ( gvRegistroUsuario.Rows.Count >= 1)
            {
                //se ejecuta el metodo para insertar datos
                for (int i = 0; i < gvRegistroUsuario.Rows.Count; i++)
                {
                    res = objSanaT.insertarUsuario(Application["cnnVentas"].ToString(),


                         int.Parse(gvRegistroUsuario.Rows[i].Cells[0].Text),
                         gvRegistroUsuario.Rows[i].Cells[1].Text,
                         gvRegistroUsuario.Rows[i].Cells[2].Text,
                         gvRegistroUsuario.Rows[i].Cells[3].Text,
                         gvRegistroUsuario.Rows[i].Cells[4].Text,
                         gvRegistroUsuario.Rows[i].Cells[5].Text,
                         gvRegistroUsuario.Rows[i].Cells[6].Text,
                         gvRegistroUsuario.Rows[i].Cells[7].Text,
                         gvRegistroUsuario.Rows[i].Cells[8].Text,
                         gvRegistroUsuario.Rows[i].Cells[9].Text,
                         int.Parse(gvRegistroUsuario.Rows[i].Cells[10].Text));
                    conR = conR + 1;
                    

                    if (res == 0)
                        gvRegistroUsuario.Rows[i].BackColor = Color.Red;
                    else
                    {
                        gvRegistroUsuario.Rows[i].BackColor = Color.Green;
                    }
                    lblProductosRegistrados.Visible = true;
                    lblProductosRegistrados.Text = "Usuarios registrados: " + conR.ToString();

                }
                Response.Write("<script language='javascript'>alert('Verificar " +
                    "registros insertados, lo que fueron insertados en la Base" + " de datos están en color rojo');</script>");
            }
        }
    }
}