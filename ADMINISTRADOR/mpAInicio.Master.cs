using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace swwSanaT.ADMINISTRADOR
{
    public partial class mpAInicio : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Para personalizar sesión
            if (Session["nombreUsuario"].ToString() != "")
            {
                Session["cveUsuario"] = Session["cveUsuario"].ToString();
                lblSesionA.Text = Session["nombreUsuario"].ToString() + "\n" + Session["Rol"].ToString();
            }
        }
    }
}