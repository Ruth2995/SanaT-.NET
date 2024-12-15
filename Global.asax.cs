using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
//Agregar libreria
using System.Configuration;

namespace swwSanaT
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            //VARIABLE DE APLICACION QUE CONTIENE LA CADENA DE CONEXIÓN
            Application["cnnVentas"] = ConfigurationManager.ConnectionStrings["cnnCarrito"].ConnectionString.ToString();
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            //Variables de sesión para guardar los datos del usuarip
            Session["cveUsuario"] = 0;
            Session["nombreUsuario"] = "";
            Session["Rol"] = "";

            //SE USA COMO PARAMETRO AL SELECCIONAR USUARIOS
            Session["cveSel"] = 0;
            Session["numTel"] = "";

            //VARIABLE PARA MANEJO DE VENTAS
            Session["venActual"] = 0;

            //SINO SE COLOCA NO MODIFICA
            Session["opMod"] = 0;

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}