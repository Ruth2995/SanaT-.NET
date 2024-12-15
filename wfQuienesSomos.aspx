<%@ Page Title="" Language="C#" MasterPageFile="~/mpPrincipalGeneral.Master" AutoEventWireup="true" CodeBehind="wfQuienesSomos.aspx.cs" Inherits="swwSanaT.Formulario_web12" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- cutomer -->
      <div class="cutomer">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage">
                     <h2>Sobre nosotros</h2>
                  </div>
                   
               </div>
            </div>
            <div class="row">
               <div class="col-md-12">
                  <div id="myCarousel" class="carousel slide cutomer_Carousel " data-ride="carousel">
                     <ol class="carousel-indicators">
                        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#myCarousel" data-slide-to="1"></li>
                        <li data-target="#myCarousel" data-slide-to="2"></li>
                        <li data-target="#myCarousel" data-slide-to="3"></li>
                        <li data-target="#myCarousel" data-slide-to="4"></li>
                     </ol>
                     <div class="carousel-inner">
                        <div class="carousel-item active">
                           <div class="container">
                              <div class="carousel-caption ">
                                 <div class="cross_img">
                                    <figure><img src="plantilla/images/cross3.png" alt="#"/></figure>
                                 </div>
                                 <div class="our cross_layout">
                                    <div class="test_box">
                                       <h4>Revitalice</h4>
                                       <span>Sus sentidos</span>
                                       <p>Desde que abrimos nuestras puertas en el año 2013, nos dedicamos a brindar tratamientos 
                                           tradicionales, profundamente relajantes y de salud. Nuestro 
                                           equipo de terapeutas está ansioso por ayudarle a lograr la tranquilidad en 
                                           un ambiente sereno, con tratamientos personalizados según sus necesidades y deseos.</p>
                                       <i><img src="plantilla/images/te3.png" alt="#"/></i>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="carousel-item">
                           <div class="container">
                              <div class="carousel-caption">
                                 <div class="cross_img">
                                    <figure><img src="plantilla/images/cross1.png" alt="#"/></figure>
                                 </div>
                                 <div class="our cross_layout">
                                    <div class="test_box">
                                       <h4>Misión</h4>
                                       <p>Somos una empresa dedicada a garantizar servicios profesionales en el 
                                           cuidado de la belleza, con el objetivo de brindar un alto estándar de 
                                           calidad y satisfacción a nuestros clientes.</p>
                                       <i><img src="plantilla/images/te3.png" alt="#"/></i>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="carousel-item">
                           <div class="container">
                              <div class="carousel-caption">
                                 <div class="cross_img">
                                    <figure><img src="plantilla/images/cross2.png" alt="#"/></figure>
                                 </div>
                                 <div class="our cross_layout">
                                    <div class="test_box">
                                       <h4>Visión</h4>
                                       <p>Posicionar nuestro nombre como la mejor opción hacia nuestros clientes a nivel 
                                           municipal de manera reconocida por la atención hacia los servicios estéticos 
                                           y medicinales.</p>
                                       <i><img src="plantilla/images/te3.png" alt="#"/></i>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="carousel-item">
                           <div class="container">
                              <div class="carousel-caption">
                                 <div class="cross_img">
                                    <figure><img src="plantilla/images/cross4.png" alt="#"/></figure>
                                 </div>
                                 <div class="our cross_layout">
                                    <div class="test_box">
                                       <h4>Valores</h4>
                                       <p>Respeto: Valoramos la individualidad y la dignidad del ser humano, creando un 
                                           ambiente de armonía, amistad, profesionalismo y honestidad, promoviendo una 
                                           buena actitud por parte de nuestro equipo de colaboradores.</p>
                                        <p>Excelencia: Nos esmeramos en satisfacer las necesidades y expectativas de 
                                            nuestros clientes, dándole un trato amable antes, durante y después de servirles.</p>
                                       <i><img src="plantilla/images/te3.png" alt="#"/></i>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="carousel-item">
                           <div class="container">
                              <div class="carousel-caption">
                                 <div class="cross_img">
                                    <figure><img src="plantilla/images/cross5.png" alt="#"/></figure>
                                 </div>
                                 <div class="our cross_layout">
                                    <div class="test_box">
                                       <h4>Valores</h4>
                                        <p>Calidad: Capacidad, conocimientos y esfuerzos para brindarles un servicio 
                                            de óptima calidad.</p>
                                        <p>Responsabilidad: Interés de garantizarles la calidad, cantidad e integridad de los 
                                            productos y/o servicios que solicitan.</p>
                                        <p>Innovación: Buscamos las mejores herramientas y maquinarias de última generación 
                                            para garantizar la mejor tecnología y calidad en el servicio .</p>
                                       <i><img src="plantilla/images/te3.png" alt="#"/></i>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
                     <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                     <span class="sr-only">Previous</span>
                     </a>
                     <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
                     <span class="carousel-control-next-icon" aria-hidden="true"></span>
                     <span class="sr-only">Next</span>
                     </a>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- end cutomer -->
</asp:Content>
