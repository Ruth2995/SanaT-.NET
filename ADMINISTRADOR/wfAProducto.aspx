<%@ Page Title="" Language="C#" MasterPageFile="~/ADMINISTRADOR/mpAInicio.Master" AutoEventWireup="true" CodeBehind="wfAProducto.aspx.cs" Inherits="swwSanaT.ADMINISTRADOR.Formulario_web13" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 27px;
        }
        .auto-style2 {
            height: 27px;
            width: 152px;
        }
        .auto-style3 {
            height: 27px;
            width: 153px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- car -->
      <div  class="car">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage">
                     <h2>PRODUCTOS</h2>
                     <span>Aquí podrás añadir productos que se venden.</span>
                  </div>
               </div>
            </div>
                <div style="margin-bottom:20px">
                    <table class="w-100" align="center">
                        <tr align="center">
                            <td class="auto-style1" colspan="2">
                                <asp:Button ID="btnProveedor" runat="server" Text="Registrar Proveedor" class="find_btn" OnClick="btnProveedor_Click"/>
                            </td>
                        </tr>
                        <tr align="center">
                            <td>&nbsp;
                                <asp:Button ID="btnProducto" runat="server" Text="Registrar Productos" class="find_btn" OnClick="btnProducto_Click"/>
                            </td>
                            <td>&nbsp;
                                <asp:Button ID="btnInventario" runat="server" Text="Registrar en Inventario" class="find_btn" OnClick="btnInventario_Click"/>
                            </td>
                        </tr>
                        </table>

                </div>
             <!-- PROVEEDOR -->
             <table style="width: 100%;" align="center">
                 <tr>
                     <td colspan="3" align="center">&nbsp;
                         <asp:Label ID="lblRegistroP" runat="server" Text="Registro de proveedores" Visible="false"></asp:Label>
                     </td>
                 </tr>
                 <tr>
                     <td colspan="3" align="center">&nbsp;
                         <asp:Label ID="lblSeleccion2P" runat="server" Text="Ningun archivo seleccionado" Visible="false"></asp:Label>
                         <asp:FileUpload ID="fulSeleccionarP" runat="server" visible="false"/>
                     </td>
                 </tr>
                 <tr>
                     <td>&nbsp;
                         <asp:Button ID="btnImportarP" runat="server" Text="Importar datos" class="find_btn" Visible="false" OnClick="btnImportarP_Click"/>
                     </td>
                     <td>&nbsp;
                         <asp:Button ID="btnRegistrarP" runat="server" Text="Registrar" class="find_btn" Visible="false" OnClick="btnRegistrarP_Click"/>
                     </td>
                     <td>&nbsp;
                         <asp:Button ID="btnProveedores" runat="server" Text="Proveedores Actuales" class="find_btn" Visible="false" OnClick="btnProveedores_Click"/>
                     </td>
                 </tr>
             </table>

             <!-- INVENTARIO --> 
             <table style="width: 100%;" align="center">
                 <tr>
                     <td colspan="3" align="center">&nbsp;
                         <asp:Label ID="lblRegistroI" runat="server" Text="Registro de Inventario" Visible="false"></asp:Label>
                     </td>
                 </tr>
                 <tr>
                     <td colspan="3" align="center">&nbsp;
                         <asp:Label ID="lblSeleccion2I" runat="server" Text="Ningun archivo seleccionado" Visible="false"></asp:Label>
                         <asp:FileUpload ID="fulSeleccionarI" runat="server" visible="false"/>
                     </td>
                 </tr>
                 <tr>
                     <td>&nbsp;
                         <asp:Button ID="btnImportarI" runat="server" Text="Importar datos" class="find_btn" Visible="false" OnClick="btnImportarI_Click"/>
                     </td>
                     <td>&nbsp;
                         <asp:Button ID="btnRegistrarI" runat="server" Text="Registrar" class="find_btn" Visible="false" OnClick="btnRegistrarI_Click"/>
                     </td>
                     <td>&nbsp;
                         <asp:Button ID="btnInventarioActual" runat="server" Text="Inventario Actual" class="find_btn" Visible="false" OnClick="btnInventarioActual_Click"/>
                     </td>
                 </tr>
             </table>

             <!-- PRODUCTOS -->
              <table style="width: 100%;" align="center">
                    <tr>
                        <td class="auto-style2" colspan="3" align="center">
                            <asp:Label ID="lblRegistro" runat="server" Text="Registro de productos" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3" colspan="3" align="center">
                            <asp:Label ID="lblSeleccion2" runat="server" Text="Ningun archivo seleccionado" Visible="false"></asp:Label>
                            <asp:FileUpload ID="fulSeleccionar" runat="server" Visible="false"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">&nbsp;
                            <asp:Button ID="btnImportarDatos" runat="server" Text="Importar Datos" OnClick="btnImportarDatos_Click" class="find_btn" Visible="false"/>
                        </td>
                        <td class="auto-style1">&nbsp;
                            <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" class="find_btn" OnClick="btnRegistrar_Click" visible="false"/>
                        </td>
                        <td class="auto-style1">&nbsp;
                            <asp:Button ID="btnProductosActuales" runat="server" Text="Productos Actuales" class="find_btn" OnClick="btnProductosActuales_Click" visible="false"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3" colspan="3" align="center">
                            <asp:GridView ID="gvProductos" runat="server" BackColor="White" BorderColor="#175624" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowPaging="True" OnPageIndexChanging="gvProductos_PageIndexChanging">
                                <FooterStyle BackColor="#3e8e64" ForeColor="#000000" />
                                <HeaderStyle BackColor="#175624" Font-Bold="True" ForeColor="#000000" />
                                <PagerStyle BackColor="#70b190" ForeColor="#000000" HorizontalAlign="Left" />
                                <RowStyle BackColor="White" ForeColor="#000000" />
                                <SelectedRowStyle BackColor="#175624" Font-Bold="True" ForeColor="#CCFF99" />
                                <SortedAscendingCellStyle BackColor="#175624" />
                                <SortedAscendingHeaderStyle BackColor="#000000" />
                                <SortedDescendingCellStyle BackColor="#D6DFDF" />
                                <SortedDescendingHeaderStyle BackColor="#000000" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3" colspan="3" align="center">
                            <asp:GridView ID="gvInventario" runat="server" BackColor="White" BorderColor="#175624" BorderStyle="None" BorderWidth="1px" CellPadding="4" AllowPaging="true" OnPageIndexChanging="gvInventario_PageIndexChanging">
                                <FooterStyle BackColor="#3e8e64" ForeColor="#000000" />
                                <HeaderStyle BackColor="#175624" Font-Bold="True" ForeColor="#000000" />
                                <PagerStyle BackColor="#70b190" ForeColor="#000000" HorizontalAlign="Left" />
                                <RowStyle BackColor="White" ForeColor="#000000" />
                                <SelectedRowStyle BackColor="#175624" Font-Bold="True" ForeColor="#CCFF99" />
                                <SortedAscendingCellStyle BackColor="#175624" />
                                <SortedAscendingHeaderStyle BackColor="#000000" />
                                <SortedDescendingCellStyle BackColor="#D6DFDF" />
                                <SortedDescendingHeaderStyle BackColor="#000000" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3" colspan="3">&nbsp;
                            <asp:GridView ID="gvProductosTodos" runat="server" AllowPaging="True" BackColor="White" BorderColor="#175624" BorderStyle="None" BorderWidth="1px" CellPadding="4" Visible="False" OnPageIndexChanging="gvProductosTodos_PageIndexChanging" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="Clave" HeaderText="CLAVE" />
                                    <asp:ImageField DataAlternateTextField="Imagen" DataAlternateTextFormatString="Imagen" DataImageUrlField="Imagen" HeaderText="IMAGEN">
                                    </asp:ImageField>
                                    <asp:BoundField DataField="Productos" HeaderText="PRODUCTO" />
                                    <asp:BoundField DataField="Ingredientes" HeaderText="INGREDIENTES" />
                                    <asp:BoundField DataField="Descripcion" HeaderText="DESCRIPCION" />
                                    <asp:BoundField DataField="Presentacion" HeaderText="PRESENTACION" />
                                    <asp:BoundField DataField="SaborTipo" HeaderText="SABOR-TIPO" />
                                    <asp:BoundField DataField="GramosMililitros" HeaderText="GRAMOS-MILILITROS" />
                                    <asp:BoundField DataField="ModoUso" HeaderText="MODO-USO" />
                                    <asp:BoundField DataField="Existencias" HeaderText="EXISTENCIAS" />
                                    <asp:BoundField DataField="Costo" HeaderText="PRECIO" />
                                    <asp:BoundField DataField="Proveedor" HeaderText="PROVEEDOR" />
                                </Columns>
                                <FooterStyle BackColor="#3e8e64" ForeColor="#000000" />
                                <HeaderStyle BackColor="#175624" Font-Bold="True" ForeColor="#000000" />
                                <PagerStyle BackColor="#70b190" ForeColor="#000000" HorizontalAlign="Left" />
                                <RowStyle BackColor="White" ForeColor="#000000" />
                                <SelectedRowStyle BackColor="#175624" Font-Bold="True" ForeColor="#CCFF99" />
                                <SortedAscendingCellStyle BackColor="#175624" />
                                <SortedAscendingHeaderStyle BackColor="#000000" />
                                <SortedDescendingCellStyle BackColor="#D6DFDF" />
                                <SortedDescendingHeaderStyle BackColor="#000000" />
                            </asp:GridView>
                        </td>
                    </tr>
                  

                 <tr>
                    <td class="auto-style3" colspan="3" align="center">
                        <asp:Label ID="lblProductosRegistrados" runat="server" Text="Datos registrados" Visible="false"></asp:Label>
                     </td>
                </tr>

            </table>
            
            
         </div>
      </div>
      <!-- end car -->
</asp:Content>
