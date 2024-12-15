<%@ Page Title="" Language="C#" MasterPageFile="~/ADMINISTRADOR/mpAInicio.Master" AutoEventWireup="true" CodeBehind="wfAVentas.aspx.cs" Inherits="swwSanaT.ADMINISTRADOR.Formulario_web14" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- car -->
      <div  class="car">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage">
                     <h2>VENTAS</h2>
                     <span>Aquí podrás encontrar información de las ventas</span>
                  </div>
               </div>
            </div>
                <div align="center">
                    <table style="width: 100%;">
                        <tr>
                            <td align="center">&nbsp;
                                <asp:Button ID="btnVenCliente" runat="server" Text="Ventas por cliente" class="find_btn" OnClick="btnVenCliente_Click"/>
                            </td>
                            <td align="center">&nbsp;
                                <asp:Button ID="btnVenTot" runat="server" Text="Ventas de clientes" class="find_btn" OnClick="btnVenTot_Click"/>
                            </td>
                        </tr>
                        </table>
                    <div align="center" style="margin-top:30px">
                        <asp:Label ID="lblIngresa" runat="server" Text="Ingresa el ID del usuario a buscar: " Visible="false"></asp:Label>
                         <asp:TextBox ID="txtOP" runat="server" Visible="false"></asp:TextBox>
                    </div>
                    <div style="margin-bottom:30px">
                        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" class="find_btn" OnClick="btnBuscar_Click" Visible="False"/>
                    </div>
                    <div>
                        <asp:GridView ID="gvVentas" runat="server" BackColor="White" BorderColor="#175624" BorderStyle="None" BorderWidth="1px" CellPadding="4" AllowPaging="True" OnPageIndexChanging="gvVentas_PageIndexChanging" PageSize="8">
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
                    <div>
                        <asp:GridView ID="gvVenUsuario" runat="server" BackColor="White" BorderColor="#175624" BorderStyle="None" BorderWidth="1px" CellPadding="4">
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
                </div>
            
            
         </div>
      </div>
      <!-- end car -->
</asp:Content>
