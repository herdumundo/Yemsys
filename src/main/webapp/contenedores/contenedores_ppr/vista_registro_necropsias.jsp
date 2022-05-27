<%-- 
    Document   : vista_registro_contador_huevo
    Created on : 26-ene-2022, 13:37:16
    Author     : aespinola
--%>
<script>
            var today = new Date();
            var dd = today.getDate(1);
            var mm = today.getMonth(1) + 1;
            var yyyy = today.getFullYear();
            if (dd < 10) {
                dd = '0' + dd
            }
            if (mm < 10) {
                mm = '0' + mm
            }

            today = yyyy + '-' + mm + '-' + dd;
            document.getElementById("fecha").setAttribute("max", today);
           

            function setInputDate(_id) {
                var _dat = document.querySelector(_id);
                var hoy = new Date(),
                        d = hoy.getDate(),
                        m = hoy.getMonth() + 1,
                        y = hoy.getFullYear(),
                        data;

                if (d < 10) {
                    d = "0" + d;
                }
                ;
                if (m < 10) {
                    m = "0" + m;
                }
                ;

                data = y + "-" + m + "-" + d;
                console.log(data);
                _dat.value = data;
            }
            ;

        
            setInputDate("#fecha");

        </script>
        <% 
     String version=clases.versiones.contenedores_registro_necropsia;
 
      %> 
     <head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')">
    <label neme="label_contenido" id="label_contenido"><%=version%></label>  
</div>
</head>   
         
<div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PPR
</div>
</div>
    <center><b>MODULO DE REGISTRO DE NECROPSIAS</b></center>
</div>
   </div>  <br> 
   
   
 <div class="card m-4">
           
            <section class="content" id="contenido">
                <div class="text-center">
                     
                    <table id="tabla" name="tabla" class=" tablagrilla compact-cs">
                        <th class="tablagrilla">
                      <center>
                            
                      <center>
                            <label class="tablagrilla">Fecha Desde</label>
                      </center>
                          <input onchange="ocultar_ppr()" style="width:120px" type="text" id="desde_necropsias" placeholder="seleccione" 
                             name="desde_necropsias" class="tablagrilla form-control text-center datepicker" required="true">

                       </center></th>
                        <th class="tablagrilla">
                        <center>
                            <label class="tablagrilla">Fecha Hasta</label>
                        </center>
                        <center>
                            <input onchange="ocultar_ppr()" style="width:120px" type="text" id="hasta_necropsias" placeholder="seleccione"  
                                   name="hasta_necropsias" class="tablagrilla form-control text-center datepicker" required="true" >
                        </center>
                        
                        </th>

                        <th class="tablagrilla">
                        <center>
                            <div style="color: #ffffff"><label class="">brueb</label></div>
                        </center>
                        <center>
                         <div class="input-group-append">
                         <input  style=" font-weight: bold"class="form-control bg-navy"   type="button"  value="Consultar" onclick="ir_consultar_registro_necropsias_ppr()">               
                         </div>
                        </center></th>
                          </th>
                                          <th>
                                         <center>
                                            <label class=""></label>
                                        </center>
                                        
                                          <center>
                                             <input  style="width:200px" type="submit" onclick=""  value="Informe ejemplo n8"   
                                             class=" form-control btn btn-sm  bg-primary" data-toggle="modal" data-target="#modal_reportere2"
                                             > 
                                        </center>
                                        </th>
                                         <br>
                    </table>
                    <br>
                    <div id="boton_nuevo_registro"style="margin-bottom:15px;" class=" tablagrilla input-group-append ocultar">
                        
                    <button class=" bg-navy" data-toggle="modal" data-target="#ppr_necro_form">nueva necropsia</button>
                    </div>
                    <center>
                    <br>
                    <div id="tabla_a"  style="width: 100% " class=" tablagrilla input-group-append ocultar"></div>
                    </center>
                     <center>
                    <br>
                    <div id="tabla_b" style="width: 100% "  class=" tablagrilla input-group-append ocultar_div_editar"></div>
                     </center><!-- v -->
                      <center>
                    <br>
                    <div id="tabla_h" class=" tablagrilla input-group-append "></div>
                    </center>
                  
                  
                </div>
              
           
            </section>
        </div>
   <div class="modal fade" id="ppr_necro_form" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form id="ppr-necro-form" name="ppr-necro-form" autocomplete="off" class="form form-horizontal">
                <div class="modal-header bg-navy">
                    <h class="modal-title">FORMULARIO REGISTRO DE NUEVA NECROPSIA</h>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="control-label col-md-4">Fecha</label>
                        <div class="col-md-4">
                            <input   type="date" id="fecha" step="1" name="fecha" min="2014-10-01" class="tablagrilla form-control text-center" required="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-4">Lote</label>
       <div class="col-md-6">
     
           <select id="lote" name="lote" class="form-control" required="">
           <option value=""></option>
            <option value="242">(A3) - 653+654</option>
            <option value="243">(B8) - 655+656</option>
            <option value="244">(A8) - 657+658</option>
            <option value="245">(B5) - 659+660</option>
            <option value="246">(A6) - 661+662</option>
            <option value="248">(B6) - 663+664</option>
            <option value="249">(B10) - 665+666</option>
            <option value="250">(B4) - 667+668</option>
            <option value="251">(A11) - 669+670</option>
            <option value="252">(B3) - 671+672</option>
            <option value="253">(B11) - 673+674</option>
            <option value="254">(A2) - 675+676</option>
            <option value="255">(B2) - 677+678</option>
            <option value="266">(A10) - 679+680</option>
            <option value="267">(A12) - 681+682</option>
            <option value="268">(A5) - 683+684</option>
            <option value="269">(A3) - 685+686</option>
            <option value="270">(B9) - 687+688</option>
            <option value="271">(A4) - 689+690</option>
            <option value="266">(A10) - 679+680</option>                            
            <option value="272">(B7) - 691+692</option>
            <option value="273">(A9) - 693+694</option>
            <option value="274">(A7) - 695+696</option>
            <option value="275">(B8) - 697+698</option>
            <option value="276">(H2) - 699+700</option>
            <option value="277">(H1) - 701+702</option>
            <option value="278">(B5) - 703+704</option>
            <option value="279">(A8) - 705+706</option>
            <option value="280">(A6) - 707+708</option>
            <option value="281">(B6) - 709+710</option>
            <option value="282">(B10) - 711+712</option>
            <option value="283">(B4) - 713+714</option>
            <option value="284">(A11) - 715+716</option>
            <option value="285">(B3) - 717+718</option>
            <option value="286">(B11) - 719+720</option>
            <option value="287">(A2) - 721+722</option>
            <option value="288">(B2) - 723+724</option>
            <option value="289">(A10) - 725+726</option>
            <option value="290">(A12) - 727+728</option>
            <option value="291">(A3) - 729+730</option>
            <option value="292">(A5) - 731+732</option>
            <option value="293">(B9) - 733+734</option>
            <option value="294">(A4) - 735+736</option>
            <option value="295">(B7) - 737+738</option>
    </select>
       </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" onclick="registrar_necropsias_ppr()" class="bg-navy">Registrar</button>
                    <button type="button" class="bg-navy" data-dismiss="modal">Cancelar</button>
                </div>
            </form>
        </div>
    </div>
</div>
   
   
   
   
</div>
   <div  id="ppr_necro_editar" class="modal"  tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        
      
          <div class="modal-content-full-width modal-content ">
                    <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                        <span aria-hidden="true">×</span>
                    </button>
                    </div>
                    <div class="modal-body">
                        
        
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn bg-navy btn-md btn-rounded" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
   
       </div>
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
  <div  class="modal fade" id="modal_reportere2" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
        <div class="modal-dialog modal-xl"  role="document">
            
            <div class="modal-content">
                <div class="modal-header">        
             <h4 class="modal-title">informe ejemplo n8</h4> 
             
                 <button type="button" class="close" data-dismiss="modal">×</button></div> 
                 <h4 >RUTA</h4> 
            
                 <img src="img/img_aldo/Captura_infrom.PNG"  width="200" height="70"/>
                 <img src="img/img_aldo/boton_mort_global.PNG" width="500" height="50"/>
                 <img src="img/img_aldo/mort_pan_global.PNG" width="1000" height="500"/>
              
                  
            </div>
        </div>
    </div> 