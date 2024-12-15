<%@ Page Title="" Language="C#" MasterPageFile="~/CLIENTE/mpCInicio.Master" AutoEventWireup="true" CodeBehind="wfcMisDatos.aspx.cs" Inherits="swwSanaT.CLIENTE.Formulario_web14" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- car -->
      <div  class="car">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage">
                     <h2>Mis datos</h2>
                     <span>Aquí podrás encontrar tus datos de usuario.</span>
                  </div>
               </div>
            </div>
                <div align="center">
                    <asp:GridView ID="gvDatos" runat="server" BackColor="White" BorderColor="#175624" BorderStyle="None" BorderWidth="1px" CellPadding="4" OnPageIndexChanging="gvDatos_PageIndexChanging">
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
      <!-- end car -->
</asp:Content>
