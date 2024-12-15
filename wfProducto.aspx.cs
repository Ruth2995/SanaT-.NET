using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//AGREGAR LIBRERIA DE MANEJO DE DATOS
using System.Data;

namespace swwSanaT
{
    public partial class Formulario_web13 : System.Web.UI.Page
    {
        //COPIA DE LA CLASE
        clsSana objSanaT = new clsSana();
        //VARIABLE QUE RECIBE A LOS REGISTROS PARA MOSTRARLOS EN EL GRIDVIEW
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                productos();
            }
            
        }

        void productos()
        {
            ds = new DataSet();
            ds = objSanaT.listarProductos(Application["cnnVentas"].ToString());
            gvProductos.DataSource = ds;
            gvProductos.DataMember = "Productos";
            gvProductos.DataBind();
        }


        protected void gvProductos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //SE GENERA LA NUEVA PÁGINA DE DATOS
            gvProductos.PageIndex = e.NewPageIndex;

            //SE LLENA DE REGISTROS
            productos();
           
        }
    }
}