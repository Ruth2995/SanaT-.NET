<%@ Page Title="" Language="C#" MasterPageFile="~/ADMINISTRADOR/mpAInicio.Master" AutoEventWireup="true" CodeBehind="wfAReportes.aspx.cs" Inherits="swwSanaT.ADMINISTRADOR.Formulario_web15" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- car -->
      <div  class="car">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage">
                     <h2>REPORTES</h2>
                     <span>Aquí podrás ver los reportes de las ventas.</span>
                  </div>
               </div>
            </div>
                <div align="center">
                        <asp:Button ID="btnMasVendido" runat="server" Text="Producto más vendido" OnClick="btnMasVendido_Click" class="find_btn" />
                        <asp:Button ID="btnMenosVendido" runat="server" Text="Producto menos vendido" OnClick="btnMenosVendido_Click" class="find_btn"/>
                </div>
            </div>
          <table style="width: 100%;" align="center">
              <tr>
                  <td class="auto-style3" colspan="3" align="center">
                      <asp:Label ID="lblVendido" runat="server" Text="El producto más vendido:" Visible="False"></asp:Label>
                      <asp:GridView ID="gvProdVendidos" runat="server" AllowPaging="True" OnPageIndexChanging="gvProdVendidos_PageIndexChanging">
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
                      <asp:Label ID="lblMenos" runat="server" Text="El producto menos vendido:" Visible="False"></asp:Label>
                      <asp:GridView ID="gvMenosVendidos" runat="server" AllowPaging="True" OnPageIndexChanging="gvMenosVendidos_PageIndexChanging">
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

                  </td>
              </tr>
          </table>

      </div>
      <!-- end car -->
</asp:Content>
