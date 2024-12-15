using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace swwSanaT
{
    public partial class Formulario_web1 : System.Web.UI.Page
    {

        //COPIA DE LA CLASE
        clsSana objSanaT = new clsSana();

        void limpiarControles()
        {
            txtNombreUsuario.Text = "";
            txtContrasena.Text = "";
            txtNombreUsuario.Focus();
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            //VALIDAR QUE LOS CONTROLES TENGAN DATOS
            if (txtNombreUsuario.Text != "" && txtContrasena.Text != "")
            {
                //ASIGNAR LOS VALORES A LAS PROPIEDADES DE LA CLASE
                objSanaT.Usuario = txtNombreUsuario.Text;
                objSanaT.Contra = txtContrasena.Text;

                //EJECUTAR EL MÉTODO DE LA CLASE QUE VALIDA EL ACCESO
                objSanaT.validarAcceso(Application["cnnVentas"].ToString());

                //SI PERMITE EL ACCESO O NO AL SISTEMA
                if (objSanaT.Clave != 0)
                {
                    //SE ASIGNAN LOS DATOS A LA VARIABLE DE SESIÓN
                    Session["cveUsuario"] = objSanaT.Clave;
                    Session["nombreUsuario"] = objSanaT.NomUsuario;
                    Session["Rol"] = objSanaT.Rol;

                    if(objSanaT.Rol == "Administrador")
                    {
                        Response.Write("<script language='javascript'>" + "alert('Bienvenido " +
                        objSanaT.NomUsuario + ", " + "estás accediendo como " + objSanaT.Rol + "');" +
                        "document.location.href='ADMINISTRADOR/wfAInicio.aspx'</script>");
                    }
                    else if(objSanaT.Rol== "Cliente")
                    {
                        Response.Write("<script language='javascript'>" + "alert('Bienvenido " +
                        objSanaT.NomUsuario + ", " + "estás accediendo como " + objSanaT.Rol + "');" +
                        "document.location.href='CLIENTE/wfCInicio.aspx'</script>");
                    }

                    Response.Write("<script language='javascript'>" + "alert('Bienvenido " +
                        objSanaT.NomUsuario + ", " + "estás accediendo como " + objSanaT.Rol + "');</script>");
                }
                else
                {
                    Response.Write("<script language='javascript'>" + "alert('¡Acceso denegado!');" + "</script>");
                    limpiarControles();
                }
            }
            else
            {
                Response.Write("<script language='javascript'>" + "alert('¡Debes agregar valores!');" + "</script>");
                limpiarControles();
            }
        }
    }
}