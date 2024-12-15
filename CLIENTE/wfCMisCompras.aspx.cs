using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//AGREGAR LIBRERIA DE MANEJO DE DATOS
using System.Data;
namespace swwSanaT.CLIENTE
{
    public partial class Formulario_web13 : System.Web.UI.Page
    {
        //COPIA DE LA CLASE
        clsSana objSanaT = new clsSana();
        //VARIABLE QUE RECIBE A LOS REGISTROS PARA MOSTRARLOS EN EL GRIDVIEW
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            lblDatosCliente.Text = Session["cveUsuario"].ToString() + " - " + Session["nombreUsuario"].ToString();


            if (!IsPostBack)
            {
                ventasRealizadas();
            }
        }

        void ventasRealizadas()
        {
            string id = "";
            ds = new DataSet();
            ds = objSanaT.listarVentasCliente(Application["cnnVentas"].ToString(), int.Parse(Session["cveUsuario"].ToString()));

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                id = dr["claveCompra"].ToString();
                break;
            }
            if (id != "0")
            {
                gvCompras.DataSource = ds;
                gvCompras.DataMember = "VentasRealizadas";
                gvCompras.DataBind();
            }
            else
            {
                lblVenta.Visible = true;
                lblVenta.Text = "Por el momento no se ha realizado ninguna compra";
            }

        }

        protected void gvVentasAnteriores_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //SE GENERA LA NUEVA PÁGINA DE DATOS
            gvCompras.PageIndex = e.NewPageIndex;

            //SE LLENA DE REGISTROS LA PÁGINA
            ventasRealizadas();
        }
    }
}