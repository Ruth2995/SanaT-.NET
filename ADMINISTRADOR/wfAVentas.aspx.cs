using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//AGREGAR LIBRERIA DE MANEJO DE DATOS
using System.Data;

namespace swwSanaT.ADMINISTRADOR
{
    public partial class Formulario_web14 : System.Web.UI.Page
    {
        //COPIA DE LA CLASE
        clsSana objSanaT = new clsSana();
        //VARIABLE QUE RECIBE A LOS REGISTROS PARA MOSTRARLOS EN EL GRIDVIEW
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        void limpiarControles()
        {
            txtOP.Text = "";
            txtOP.Focus();
        }

        void listaVenUsuario(int USUID)
        {
            ds = new DataSet();
            ds = objSanaT.listarVenUsuario(Application["cnnVentas"].ToString(),USUID);


            if (ds.Tables[0].Rows.Count > 0)
            {
                gvVenUsuario.DataSource = ds;
                gvVenUsuario.DataMember = "ListaVenUsuario";
                gvVenUsuario.DataBind();
            }
            else
            {
                Response.Write("<script language='javascript'>" + "alert('¡Este cliente no ha generado compras!');" + "</script>");

            }
            

        }

        void listaVentas()
        {
            ds = new DataSet();
            ds = objSanaT.listarVentas(Application["cnnVentas"].ToString());

            gvVentas.DataSource = ds;
            gvVentas.DataMember = "ListaVentas";
            gvVentas.DataBind();

        }

        protected void btnVenCliente_Click(object sender, EventArgs e)
        {
            lblIngresa.Visible = true;
            txtOP.Visible = true;
            btnBuscar.Visible = true;
            gvVentas.Visible = false;
        }

        int USUID;
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            lblIngresa.Visible = true;
            txtOP.Visible = true;
            btnBuscar.Visible = true;
            gvVentas.Visible = false;
            gvVenUsuario.Visible = true;
            if (int.TryParse(txtOP.Text, out USUID) && USUID > 0)
            {
                int cantidad = objSanaT.cantUsuarios(Application["cnnVentas"].ToString());
                if (USUID <= cantidad)
                {
                    listaVenUsuario(USUID);
                    
                }
                else
                {
                    Response.Write("<script language='javascript'>" + "alert('¡Debes agregar un ID que exista!');" + "</script>");
                    gvVenUsuario.Visible = false;
                    limpiarControles();
                }

            }
            else
            {
                Response.Write("<script language='javascript'>" + "alert('Debes agregar un ID numérico!');" + "</script>");
                gvVenUsuario.Visible = false;
                limpiarControles();
            }
        }

        protected void btnVenTot_Click(object sender, EventArgs e)
        {
            listaVentas();
            gvVenUsuario.Visible = false;
            gvVentas.Visible = true;
            lblIngresa.Visible = false;
            txtOP.Visible = false;
            btnBuscar.Visible = false;
        }

        protected void gvVentas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            // SE GENERA LA NUEVA PÁGINA DE DATOS
            gvVentas.PageIndex = e.NewPageIndex;
            listaVentas();

        }
    }
}