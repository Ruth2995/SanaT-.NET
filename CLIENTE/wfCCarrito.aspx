<%@ Page Title="" Language="C#" MasterPageFile="~/CLIENTE/mpCInicio.Master" AutoEventWireup="true" CodeBehind="wfCCarrito.aspx.cs" Inherits="swwSanaT.CLIENTE.Formulario_web12" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- choose  section -->
      <div class="choose">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage">
                     <h2>Carrito de compras</h2>
                     <asp:Label ID="lblDatosCliente" runat="server" Text="[Datos Cliente]"></asp:Label>
                  </div>
               </div>
            </div>
            <div align="center">
               <div class="col-md-12">
                  <div class="choose_box">

                      <div>
                          <table style="width: 100%;" align="center">
                          <tr>
                              <td class="auto-style1" align="center">
                                  <asp:GridView ID="gvVentasAnteriores" runat="server" AllowPaging="True" AutoGenerateColumns="False" PageSize="5" BackColor="White" BorderColor="#175624" BorderStyle="None" BorderWidth="1px" CellPadding="4" OnPageIndexChanging="gvVentasAnteriores_PageIndexChanging">
                                      <Columns>
                                          <asp:BoundField DataField="ClaveCompra" HeaderText="Número de compra" />
                                          <asp:BoundField DataField="FechaCompra" HeaderText="Fecha" />
                                          <asp:BoundField DataField="Total" HeaderText="Total" />
                                          <asp:BoundField DataField="Estatus" HeaderText="Estado de la compra" />
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
                          </table>
                      </div>
                      
                        <div align="center" style="margin-top: 20px">
                            <span>
                                <asp:Label ID="lblVenta" runat="server" Text="[Pendiente a generar compra]" ></asp:Label>
                            </span>
                        </div>
                        <div align="center">
                            <asp:Button ID="btnGenerarCompra" runat="server" Text="Nueva compra" class="find_btn" OnClick="btnGenerarCompra_Click"/>
                        </div>
                        <div align="center">
                            <asp:Button ID="btnCancelarCompra" runat="server" Text="Cancelar compra actual" class="find_btn" OnClick="btnCancelarCompra_Click"/>
                        </div>
                        <div align="center">
                            <asp:Label ID="lblProductos" runat="server" Text="[Productos disponibles para comprar]" Visible="false"></asp:Label>
                        </div>
                        <div align="center">
                            <asp:GridView ID="gvProductos" runat="server" AllowPaging="True" BackColor="White" BorderColor="#175624" BorderStyle="None" BorderWidth="1px" CellPadding="4" OnPageIndexChanging="gvProductos_PageIndexChanging" Visible="False" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSeleccionado" runat="server"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:DropDownList ID="dwlCantidadP" runat="server">
                                                <asp:ListItem>1</asp:ListItem>
                                                <asp:ListItem>2</asp:ListItem>
                                                <asp:ListItem>3</asp:ListItem>
                                                <asp:ListItem>4</asp:ListItem>
                                                <asp:ListItem>5</asp:ListItem>
                                                <asp:ListItem>6</asp:ListItem>
                                                <asp:ListItem>7</asp:ListItem>
                                                <asp:ListItem>8</asp:ListItem>
                                                <asp:ListItem>9</asp:ListItem>
                                                <asp:ListItem>10</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField AccessibleHeaderText="Ver" SelectText="Ver" ShowSelectButton="True" />
                                    <asp:BoundField DataField="Clave" HeaderText="CLAVE" />
                                    <asp:ImageField DataAlternateTextField="Imagen" DataAlternateTextFormatString="Imagen" DataImageUrlField="Imagen" HeaderText="IMAGEN">
                                        <ItemStyle Height="30px" Width="30px" />
                                    </asp:ImageField>
                                    <asp:BoundField DataField="Productos" HeaderText="PRODUCTOS" />
                                    <asp:BoundField DataField="Ingredientes" HeaderText="INGREDIENTES" />
                                    <asp:BoundField DataField="Descripcion" HeaderText="DESCRIPCION" />
                                    <asp:BoundField DataField="Presentacion" HeaderText="PRESENTACION" />
                                    <asp:BoundField DataField="SaborTipo" HeaderText="SABOR-TIPO" />
                                    <asp:BoundField DataField="GramosMililitros" HeaderText="GRAMOS-MILILITROS" />
                                    <asp:BoundField DataField="ModoUso" HeaderText="MODOUSO" />
                                    <asp:BoundField DataField="Existencias" HeaderText="EXISTENCIAS" />
                                    <asp:BoundField DataField="Costo" HeaderText="PRECIO" />
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
                        </div>
                        <div align="center">
                            <asp:Button ID="btnAgregar" runat="server" Text="Agregar al carrito" Visible="false" class="find_btn" OnClick="btnAgregar_Click"/>
                        </div>
                        <div align="center">
                            <asp:Label ID="lblCarritoActual" runat="server" Text="Carrito actual de compras:" Visible="false"></asp:Label>
                        </div>
                        <div align="center">
                            <asp:GridView ID="gvComprasNuevas" runat="server" Visible="False" AllowPaging="True" BackColor="White" BorderColor="#175624" BorderStyle="None" BorderWidth="1px" CellPadding="4" PageSize="5" OnPageIndexChanging="gvComprasNuevas_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkBorrado" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
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
                        </div>
                        <div align="center">
                            <asp:Label ID="lblSubtotal" runat="server" Text="Subtotal: $" Visible="false"></asp:Label>
                        </div>
                        <div align="center">
                            <asp:Label ID="lblIVA" runat="server" Text="I.V.A (16%): $" Visible="false"></asp:Label>
                        </div>
                        <div align="center">
                            <asp:Label ID="lblTotal" runat="server" Text="Total venta: $" Visible="false"></asp:Label>
                        </div>
                        <div align="center">
                            <asp:TextBox ID="txtTotal" runat="server" ReadOnly="true" Visible="false"></asp:TextBox>
                        </div>
                        <div align="center">
                            <asp:Button ID="btnCancelar" runat="server" Text="Eliminar producto" Visible="false" class="find_btn" OnClick="btnCancelar_Click"/>
                        </div>
                        <div align="center">
                            <asp:Button ID="btnConfirmarCompra" runat="server" Text="Confirmar compra" visible="false" class="find_btn" OnClick="btnConfirmarCompra_Click"/>
                            <asp:Button ID="btnCerrarCarrito" runat="server" Text="Cerrar carrito" visible="false" class="find_btn" OnClick="btnCerrarCarrito_Click"/>
                        </div>

                  
               </div>
              </div>
            </div>
         </div>
      </div>
      <!-- end choose  section -->
</asp:Content>
