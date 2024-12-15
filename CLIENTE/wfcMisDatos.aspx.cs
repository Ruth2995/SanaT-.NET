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
    public partial class Formulario_web14 : System.Web.UI.Page
    {
        //COPIA DE LA CLASE
        clsSana objSanaT = new clsSana();
        //VARIABLE QUE RECIBE A LOS REGISTROS PARA MOSTRARLOS EN EL GRIDVIEW
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                datos();
            }
        }

        void datos()
        {
            ds = new DataSet();
            ds = objSanaT.listarDatosUsuario(Application["cnnVentas"].ToString(), int.Parse(Session["cveUsuario"].ToString()));
            
            gvDatos.DataSource = ds;
            gvDatos.DataMember = "listarDatosUsuario";
            gvDatos.DataBind();
        }

        protected void gvDatos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //SE GENERA LA NUEVA PÁGINA DE DATOS
            gvDatos.PageIndex = e.NewPageIndex;

            //SE LLENA DE REGISTROS LA PÁGINA
            datos();
        }
    }
}