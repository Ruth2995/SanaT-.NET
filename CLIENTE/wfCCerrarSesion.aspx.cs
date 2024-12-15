using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace swwSanaT.CLIENTE
{
    public partial class Formulario_web11 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //LIMPIAR VARIABLES
            Session["cveUsuario"] = 0;
            Session["nombreUsuario"] = "";
            Session["Rol"] = "";

            //REDIRECCIONAR
            Response.Redirect("../wfInicio.aspx");
        }
    }
}