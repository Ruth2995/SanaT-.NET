<%@ Page Title="" Language="C#" MasterPageFile="~/ADMINISTRADOR/mpAInicio.Master" AutoEventWireup="true" CodeBehind="wfAUsuarios.aspx.cs" Inherits="swwSanaT.ADMINISTRADOR.Formulario_web12" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 27px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- choose  section -->
      <div class="choose ">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage">
                     <h2>Usuarios registrados</h2>
                     
                  </div>
               </div>
            </div>
            <div class="row" align="center">
               <div class="col-md-12">
                  <div class="choose_box" align="center">
                      <table style="width: 100%;">
                          <tr align="center">
                              <td>&nbsp;
                                  <asp:Button ID="btnTodosUsuarios" runat="server" Text="Mostrar todos" class="find_btn" OnClick="btnTodosUsuarios_Click"/>
                              </td>
                              <td>&nbsp;
                                  <asp:Button ID="btnBuscarUsuario" runat="server" Text="Buscar usuario" class="find_btn" OnClick="btnBuscarUsuario_Click"/>
                              </td>
                              <td>&nbsp;
                                  <asp:Button ID="btnRegistrar" runat="server" Text="Registrar usuarios" class="find_btn" OnClick="btnRegistrar_Click"/>
                              </td>
                          </tr>
                          </table>
                          
                      <div>
                          
                      </div>
                      <div align="center" style="margin-top: 20px">
                          <asp:GridView ID="gvListaUsuarios" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#175624" BorderStyle="None" BorderWidth="1px" CellPadding="4" OnPageIndexChanging="GridView1_PageIndexChanging" Visible="False">
                              <Columns>
                                  <asp:BoundField DataField="USU_ID" HeaderText="ID" />
                                  <asp:BoundField DataField="USUARIO" HeaderText="Usuario" />
                                  <asp:BoundField DataField="ROL" HeaderText="Rol" />
                                  <asp:BoundField DataField="VIGENTE" HeaderText="Estatus" />
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
                      <div align="center" style="margin-top: 20px">
                          <div>
                              <asp:Label ID="lblIngresa" runat="server" Text="Ingresa el ID del usuario a buscar: " Visible="false"></asp:Label>
                              <asp:TextBox ID="txtOP" runat="server" Visible="false"></asp:TextBox>
                              
                          </div>
                          <div>
                              <asp:Button ID="btnBuscar" runat="server" Text="Buscar" visible="false" OnClick="btnBuscar_Click" class="find_btn"/>
                          </div>
                          <div style="margin-top: 20px">
                              <asp:GridView ID="gvListarUsuario" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#175624" BorderStyle="None" BorderWidth="1px" CellPadding="4" OnPageIndexChanging="gvListarUsuario_PageIndexChanging" PageSize="2">
                              <Columns>
                                  <asp:BoundField DataField="USU_ID" HeaderText="ID" />
                                  <asp:BoundField DataField="ROL_Nombre" HeaderText="Rol" />
                                  <asp:BoundField DataField="USU_Nombre" HeaderText="Nombre" />
                                  <asp:BoundField DataField="USU_ApellidoPaterno" HeaderText="Apellido Paterno" />
                                  <asp:BoundField DataField="USU_ApellidoMaterno" HeaderText="Apellido Materno" />
                                  <asp:BoundField DataField="USU_Correo" HeaderText="Correo" />
                                  <asp:BoundField DataField="USU_Usuario" HeaderText="Usuario" />
                                  <asp:BoundField DataField="USU_Estatus" HeaderText="Estatus" />
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
                      <div style="margin-top: 20px">
                          <asp:Label ID="lblUsuario" runat="server" Text="[No se han generado usuarios]" Visible="False"></asp:Label>
                      </div>
                      <div align="center">
                          <table style="width: 100%;">
                              <tr>
                                  <td>&nbsp;
                                      <asp:Label ID="lblSeleccionado" runat="server" Text="Seleccionar archivos: " Visible="false"></asp:Label>
                                      
                                  </td>
                                  <td>&nbsp;
                                      <asp:FileUpload ID="fulArchivo" runat="server" visible="false"/>
                                  </td>
                              </tr>
                              <tr>
                                  <td>&nbsp;
                                      <asp:Button ID="btnImportar" runat="server" Text="Importar usuarios" class="find_btn" Visible="false" OnClick="btnImportar_Click"/>
                                  </td>
                                  <td>&nbsp;
                                      <asp:Button ID="btnRegistrarU" runat="server" Text="Registrar usuarios" class="find_btn" Visible="false" OnClick="btnRegistrarU_Click"/>
                                  </td>
                              </tr>
                              <tr>
                                  <td colspan="3">&nbsp;
                                      <asp:GridView ID="gvRegistroUsuario" runat="server" AllowPaging="True" BackColor="White" BorderColor="#175624" BorderStyle="None" BorderWidth="1px" CellPadding="4" OnPageIndexChanging="gvRegistroUsuario_PageIndexChanging">
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
                          <tr>
                            <td class="auto-style3">&nbsp;</td>
                            <td class="auto-style5">
                                <asp:Label ID="lblProductosRegistrados" runat="server" Text="Usuarios registrados" Visible="False"></asp:Label>
                            </td>
                            <td>&nbsp;</td>
                          </tr>

                      </div>
                  </div>
               </div>
               
            </div>
             <div>

             </div>
         </div>
      </div>
      <!-- end choose  section -->
</asp:Content>
