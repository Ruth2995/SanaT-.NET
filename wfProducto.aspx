<%@ Page Title="" Language="C#" MasterPageFile="~/mpPrincipalGeneral.Master" AutoEventWireup="true" CodeBehind="wfProducto.aspx.cs" Inherits="swwSanaT.Formulario_web13" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- car -->
      <div  class="car">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage">
                     <h2>PRODUCTOS</h2>
                     <span>Aquí podrás encontrar la gran variedad de productos que tenemos para ti.</span>
                  </div>
               </div>
                <div align="center">
                    <asp:GridView ID="gvProductos" runat="server" AllowPaging="True" BackColor="White" BorderColor="#175624" BorderStyle="None" BorderWidth="1px" CellPadding="4" OnPageIndexChanging="gvProductos_PageIndexChanging" AutoGenerateColumns="False">
                                <Columns>
                                    
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
            </div>
            
         </div>
      </div>
      <!-- end car -->
</asp:Content>
