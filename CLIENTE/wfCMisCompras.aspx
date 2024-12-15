<%@ Page Title="" Language="C#" MasterPageFile="~/CLIENTE/mpCInicio.Master" AutoEventWireup="true" CodeBehind="wfCMisCompras.aspx.cs" Inherits="swwSanaT.CLIENTE.Formulario_web13" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- car -->
      <div  class="car">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage">
                     <h2>Mis compras</h2>
                     <span>Compras que has hecho anteriormente.</span>
                  </div>
               </div>
            </div>
                <div align="center">
                    <div align="center">
                        <asp:Label ID="lblDatosCliente" runat="server" Text="[DatosCliente]"></asp:Label>
                    </div>
                    <div align="center">
                        <asp:GridView ID="gvCompras" runat="server" AllowPaging="True" AutoGenerateColumns="False" PageSize="5" BackColor="White" BorderColor="#175624" BorderStyle="None" BorderWidth="1px" CellPadding="4" OnPageIndexChanging="gvVentasAnteriores_PageIndexChanging">
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
                       
                        
                    </div>
                    <div align="center">
                        <asp:Label ID="lblVenta" runat="server" Text="[Ventas realizadas]" Visible="False"></asp:Label>
                    </div>
                </div>
            
            
         </div>
      </div>
      <!-- end car -->
</asp:Content>
