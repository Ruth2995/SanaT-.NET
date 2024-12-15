<%@ Page Title="" Language="C#" MasterPageFile="~/mpPrincipalGeneral.Master" AutoEventWireup="true" CodeBehind="wfAcceso.aspx.cs" Inherits="swwSanaT.Formulario_web1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        //<!-- bestCar -->
    <div id="contact" class="bestCar">
         <div class="container">
            <div class="row">

               <div class="col-md-12">
               </div>
            </div>
            <div class="row">
               <div class="col-sm-12">
                  <div class="row">
                     <div class="col-md-6 offset-md-6 main_form">
                        
                           <div class="titlepage">
                              <h2>Iniciar sesión</h2>
                           </div>
                           <div class="row">
                               <table style="width: 100%;">
                                   <tr>
                                       <td>&nbsp;
                                           <div class="col-md-12 ">
                                            <asp:Label ID="lblNombre" runat="server" Text="Nombre: "></asp:Label>
                              
                                           </div>
                                       </td>
                                   </tr>
                                   <tr>
                                       <td>
                                           <div class="col-md-12">
                                               <asp:TextBox ID="txtNombreUsuario" runat="server" placeholder="Nombre de usuario" class="contactus"></asp:TextBox>                            
                                            </div>
                                       </td>
                                   </tr>
                                   <tr>
                                       <td>&nbsp;
                                           <div class="col-md-12">
                                            <asp:Label ID="lblContra" runat="server" Text="Contraseña: "></asp:Label>                         
                                            </div>
                                       </td>
                                   </tr>
                                   <tr>
                                       <td>
                                           <div class="col-md-12">
                                            <asp:TextBox ID="txtContrasena" runat="server" TextMode="Password" placeholder="Contraseña" type="Search" class="contactus"></asp:TextBox>
                                           </div>
                                       </td>
                                   </tr>
                                   <tr>
                                       <td>
                                           &nbsp;

                                       </td>
                                   </tr>
                               </table>
      
                              
                              <div class="col-sm-4">
                                  <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" class="btn find_btn" OnClick="btnAceptar_Click"/>
                              </div>
                               <div class="col-sm-4">
                                   <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" class="btn find_btn"/>                             
                              </div>
                           </div>
                       
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- end bestCar -->
    
</asp:Content>
