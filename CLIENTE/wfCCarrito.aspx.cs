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
    public partial class Formulario_web12 : System.Web.UI.Page
    {

        //COPIA DE LA CLASE
        clsSana objSanaT = new clsSana();
        //VARIABLE QUE RECIBE A LOS REGISTROS PARA MOSTRARLOS EN EL GRIDVIEW
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            lblDatosCliente.Text = Session["cveUsuario"].ToString() + " - " + Session["nombreUsuario"].ToString();

            if (Session["venActual"].ToString() != "0")
            {
                lblVenta.Text = "Compra actual: " + Session["venActual"].ToString();
                //SE VISUALIZA PRODUCTOS A COMPRAR Y BOTÓN DE AGREGAR
                lblProductos.Visible = true;
                gvProductos.Visible = true;
                btnAgregar.Visible = true;
            }

            if (!IsPostBack)
            {
                ventasRealizadas();
                productos();
            }
        }

        //METODOS DE VENTAS REALIZADAS

        //1. LLENAR VENTAS REALIZADAS DEL CLIENTE
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
                gvVentasAnteriores.DataSource = ds;
                gvVentasAnteriores.DataMember = "VentasRealizadas";
                gvVentasAnteriores.DataBind();
            }
            else
            {
                lblVenta.Text = "Por el momento no se ha realizado ninguna compra";
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

        void detalleCompras()
        {
            ds = new DataSet();
            ds = objSanaT.listarDetalleCompra(Application["cnnVentas"].ToString(),
                int.Parse(Session["venActual"].ToString()));
            gvComprasNuevas.DataSource = ds;
            gvComprasNuevas.DataMember = "VentaActual";
            gvComprasNuevas.DataBind();
        }

        void calcularTotalCompra()
        {
            double stotalVtaNva = 0, totalVta = 0, iva = 0;
            for (int i = 0; i < gvComprasNuevas.Rows.Count; i++)
            {
                stotalVtaNva = stotalVtaNva + double.Parse(gvComprasNuevas.Rows[i].Cells[6].Text);
            }
            iva = stotalVtaNva * 0.16;
            totalVta = stotalVtaNva + iva;
            lblSubtotal.Text = "Subtotal: $" + stotalVtaNva.ToString();
            lblIVA.Text = "I.V.A. (16%): $" + iva.ToString();
            lblTotal.Text = "Total Compra: $";
            txtTotal.Text = totalVta.ToString();
        }

        protected void gvVentasAnteriores_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //SE GENERA LA NUEVA PÁGINA DE DATOS
            gvVentasAnteriores.PageIndex = e.NewPageIndex;

            //SE LLENA DE REGISTROS LA PÁGINA
            ventasRealizadas();
        }

        protected void btnGenerarCompra_Click(object sender, EventArgs e)
        {
            try
            {
                // -----------------------------
                // VALIDACION PARA NO GENERAR OTRA VENTA, CUANDO YA HAY UNA
                if (Session["venActual"].ToString() == "0")
                {

                    //GENERA LA NUEVA VENTA Y ASIGNA EL NÚMERO DE ESA VENTA A LA
                    //VARIABLE DE SESIÓN
                    //0--> ES EL TOTAL DE LA VENTA, PERO HASTA QUE NO SE CIERRE LA
                    //VENTA NO SE PODRÁ
                    //ACTUALIZAR EL TOTAL, INICIALMENTE SE COLOCA UN CERO
                    Session["venActual"] = objSanaT.insertarVenta(Application["cnnVentas"].ToString(),
                        int.Parse(Session["cveUsuario"].ToString()), 0).ToString();

                    Response.Write("<script language='javascript'>alert('Venta " +
                        "registrada: " + Session["venActual"].ToString() + "');</script>");
                    Response.Write("<script language='javascript'>" +
                        "document.location.href='wfCCarrito.aspx';</script>");
                }
                else
                {
                    Response.Write("<script language='javascript'>alert('Ya hay una " +
                        "venta registrada, seleccionar productos ...');" +
                        " </script>");
                    Response.Write("<script language='javascript'>" +
                        "document.location.href='wfCCarrito.aspx';</script>");
                }
                lblVenta.Text = "Venta actual: " + Session["venActual"].ToString();
            }
            catch (Exception)
            {
                Response.Write("<script language='javascript'>alert('Ha sucedido un error en el registro de venta ...');</script>");
                Response.Write("<script language='javascript'>document.location.href='wfOfertas.aspx';</script>");
            }
        }

        protected void gvProductos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //SE GENERA LA NUEVA PÁGINA DE DATOS
            gvProductos.PageIndex = e.NewPageIndex;

            //SE LLENA DE REGISTROS
            productos();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            double subtotalUnidad = 0;
            lblCarritoActual.Visible = true;
            lblSubtotal.Visible = true;
            lblIVA.Visible = true;
            lblTotal.Visible = true;
            txtTotal.Visible = true;

            //RECORRE EL GRID PARA AGREGAR PRODUCTOS
            for (int i = 0; i < gvProductos.Rows.Count; i++)
            {
                CheckBox chk = (CheckBox)gvProductos.Rows[i].FindControl("chkSeleccionado");

                //VERIFICA QUE SE HAYA SELECCIONADO PARA INSERTAR EN CARRITO
                if (chk.Checked && chk != null)
                {
                    DropDownList dd = (DropDownList)gvProductos.Rows[i].FindControl("dwlCantidadP");

                    if (int.Parse(dd.SelectedItem.ToString()) <= int.Parse(gvProductos.Rows[i].Cells[12].Text))
                    {
                        subtotalUnidad = double.Parse(dd.SelectedItem.ToString()) * double.Parse(gvProductos.Rows[i].Cells[13].Text);
                        //ENVIAR EL REGISTRO AL GRID DE CARRITO DE COMPRAS NUEVAS
                        objSanaT.insertarDetalleCompra(Application["cnnVentas"].ToString(),
                            int.Parse(Session["venActual"].ToString()),
                            int.Parse(gvProductos.Rows[i].Cells[3].Text),
                            int.Parse(dd.SelectedItem.ToString()), subtotalUnidad);

                        detalleCompras();

                        calcularTotalCompra();

                    }
                }
            }

            lblCarritoActual.Visible = true;
            gvComprasNuevas.Visible = true;
            btnCancelar.Visible = true;
            btnConfirmarCompra.Visible = true;
            btnCerrarCarrito.Visible = true;
            productos();
        }

        protected void gvComprasNuevas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < gvComprasNuevas.Rows.Count; i++)
            {
                CheckBox chk = (CheckBox)gvComprasNuevas.Rows[i].FindControl("chkBorrado");

                if (chk.Checked && chk != null)
                {
                    //ENVIA DATOS DE PRODUCTOS PARA QUITAR DEL GRID
                    objSanaT.eliminarProductoDetalleCompra(Application["cnnVentas"].ToString(),
                        int.Parse(gvComprasNuevas.Rows[i].Cells[1].Text),
                        int.Parse(gvComprasNuevas.Rows[i].Cells[2].Text),
                        int.Parse(gvComprasNuevas.Rows[i].Cells[4].Text));
                    //RESTA LA CANTIDAD DE PRODUCTOS QUE YA NO SE VAN  A COMPRAR
                    txtTotal.Text = (double.Parse(txtTotal.Text) - double.Parse(gvComprasNuevas.Rows[i].Cells[6].Text)).ToString();
                    //ACTUALIZA LOS GRIDS DE PRODUCTOS Y DEL CARRITO DE COMPRAS
                    productos();
                    detalleCompras();
                    calcularTotalCompra();
                }


            }
        }

        protected void btnConfirmarCompra_Click(object sender, EventArgs e)
        {
            //CONFIRMAR VENTA
            if (Session["venActual"].ToString() == "0")
            {
                Response.Write("<script language='javascript'>alert('No puedes confirmar la compra porque no has generado ninguna compra actual...');</script>");
            }
            else if (txtTotal.Text == "" || txtTotal.Text == "0")
            {
                Response.Write("<script language='javascript'>alert('No puedes confirmar la compra, porque no has comprado productos...');</script>");
            }
            else
            {
                //EJECUTA LA ACTUALIZACIÓN DE LA VENTA
                objSanaT.confirmarCompra(Application["cnnVentas"].ToString(), int.Parse(Session["venActual"].ToString()), float.Parse(txtTotal.Text));
                Session["venActual"] = "0";
                Response.Write("<script language='javascript'>alert('La compra se ha confirmado y cerrado correctamente');</script>");
                ventasRealizadas();
                productos();
                detalleCompras();
                lblVenta.Text = "[Pendiente de generarse una compra]";
                gvComprasNuevas.Visible = false;
                gvProductos.Visible = false;
                txtTotal.Visible = false;
                btnAgregar.Visible = false;
                lblCarritoActual.Visible = false;
                lblSubtotal.Visible = false;
                lblIVA.Visible = false;
                lblTotal.Visible = false;
                btnCancelar.Visible = false;
                lblProductos.Visible = false;
                btnCerrarCarrito.Visible = false;
                btnConfirmarCompra.Visible = false;


            }
        }

        protected void btnCancelarCompra_Click(object sender, EventArgs e)
        {
            if (Session["venActual"].ToString() == "0")
            {
                Response.Write("<script language='javascript'>alert('No puedes cancelar la compra porque no se ha generado ninguna...');</script>");
            }
            else if (txtTotal.Text == "" || txtTotal.Text == "0")
            {
                Response.Write("<script language='javascript'>alert('No puedes cancelar la compra porque no has comprado nada...');</script>");
            }
            else
            {
                //1.Quita los productos de detalle venta
                //recorre el grid
                for (int i = 0; i < gvComprasNuevas.Rows.Count; i++)
                {
                    objSanaT.eliminarProductoDetalleCompra(Application["cnnVentas"].ToString(),
                    int.Parse(gvComprasNuevas.Rows[i].Cells[1].Text), int.Parse(gvComprasNuevas.Rows[i].Cells[2].Text),
                    int.Parse(gvComprasNuevas.Rows[i].Cells[4].Text));
                }
                //2. actualiza el grid de producto y ventas

                productos();
                detalleCompras();
                gvComprasNuevas.Visible = false;
                txtTotal.Visible = false;

                //3. cancelar la venta de ventas

                objSanaT.cancelarVenta(Application["cnnVentas"].ToString(), int.Parse(Session["venActual"].ToString()));
                //4. Liberar la venta dejando en 0 la variable
                Session["venActual"] = "0";

                Response.Write("<script language='javascript'>alert('La compra se ha cancelado y cerrado completamente...');</script>");

                ventasRealizadas();
                gvProductos.Visible = false;
                lblIVA.Visible = false;
                lblSubtotal.Visible = false;
                lblTotal.Visible = false;
                txtTotal.Visible = false;
                btnAgregar.Visible = false;
                lblProductos.Visible = false;
                lblCarritoActual.Visible = false;
                btnCancelar.Visible = false;
                btnConfirmarCompra.Visible = false;
                btnCerrarCarrito.Visible = false;
                //poner como no visibles
            }
        }

        protected void btnCerrarCarrito_Click(object sender, EventArgs e)
        {
            //1.Quita los productos de detalle venta
            //recorre el grid
            for (int i = 0; i < gvComprasNuevas.Rows.Count; i++)
            {
                objSanaT.eliminarProductoDetalleCompra(Application["cnnVentas"].ToString(),
                int.Parse(gvComprasNuevas.Rows[i].Cells[1].Text), int.Parse(gvComprasNuevas.Rows[i].Cells[2].Text),
                int.Parse(gvComprasNuevas.Rows[i].Cells[4].Text));
            }
            //2. actualiza el grid de producto y ventas

            productos();
            detalleCompras();
            gvComprasNuevas.Visible = false;
            txtTotal.Visible = false;

            //3. cancelar la venta de ventas

            objSanaT.cerrarCarrito(Application["cnnVentas"].ToString(), int.Parse(Session["venActual"].ToString()));
            //4. Liberar la venta dejando en 0 la variable
            Session["venActual"] = "0";


            ventasRealizadas();
            gvProductos.Visible = false;
            lblIVA.Visible = false;
            lblSubtotal.Visible = false;
            lblTotal.Visible = false;
            txtTotal.Visible = false;
            btnAgregar.Visible = false;
            lblProductos.Visible = false;
            lblCarritoActual.Visible = false;
            btnCancelar.Visible = false;
            btnConfirmarCompra.Visible = false;
            btnCerrarCarrito.Visible = false;
            //poner como no visibles
            Response.Redirect("wfCInicio.aspx");
        }
    }

}