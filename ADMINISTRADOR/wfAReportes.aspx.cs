using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace swwSanaT.ADMINISTRADOR
{
    public partial class Formulario_web15 : System.Web.UI.Page
    {
        clsSana objSanaT = new clsSana();
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void MasVendido()
        {
            ds = new DataSet();
            ds = objSanaT.productosMasVendidos(Application["cnnVentas"].ToString());
            gvProdVendidos.DataSource = ds;
            gvProdVendidos.DataMember = "MasVendido";
            gvProdVendidos.DataBind();
        }

        void MenosVendido()
        {
            ds = new DataSet();
            ds = objSanaT.productosMenosVendidos(Application["cnnVentas"].ToString());
            gvMenosVendidos.DataSource = ds;
            gvMenosVendidos.DataMember = "MenosVendido";
            gvMenosVendidos.DataBind();
        }

        protected void gvProdVendidos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProdVendidos.PageIndex = e.NewPageIndex;
            MasVendido();
        }

        protected void gvMenosVendidos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMenosVendidos.PageIndex = e.NewPageIndex;
            MenosVendido();

        }

        protected void btnMasVendido_Click(object sender, EventArgs e)
        {
            lblMenos.Visible = false;
            lblVendido.Visible = true;
            gvProdVendidos.Visible = true;
            gvMenosVendidos.Visible = false;
            MasVendido();

        }

        protected void btnMenosVendido_Click(object sender, EventArgs e)
        {
            lblMenos.Visible = true;
            lblVendido.Visible = false;
            gvMenosVendidos.Visible = true;
            gvProdVendidos.Visible = false;
            MenosVendido();

        }


    }
}