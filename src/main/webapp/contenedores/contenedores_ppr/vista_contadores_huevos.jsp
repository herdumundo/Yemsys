<%-- 
    Document   : vista_registro_contador_huevo
    Created on : 26-ene-2022, 13:37:16
    Author     : aespinola
--%>
 <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@include  file="../../versiones.jsp" %>

<jsp:useBean id="conexion" class="clases.ConnectionSqlServer" scope="page" />
 <% 
     String version= contenedores_ppr_vista_contadores_huevos;

 %> 
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')">
    <label neme="label_contenido" id="label_contenido"> <%=version%> </label>  
</div>
</head>
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
      
 <div class="card m-4">
            <input type="hidden" value="2" id="udepartamento" name="udepartamento">
            <section class="content" id="contenido">
                <div class="text-center">
                    
             <div class="position-relative p-3 bg-navy"  >
             <div class="ribbon-wrapper">
             <div class="ribbon bg-warning">
             PPR
             </div>
             </div>
              
               <center><b>CONTADORES DE HUEVOS</b></center>   
              </div>
                    <table id="tabla" name="tabla" class=" tablagrilla compact-cs">
                        <th class="tablagrilla">
                        
                            <label class="tablagrilla">Mes</label>
                        
                        <center>
                            
                           <select onchange="ocultar_ppr(),consulta_lote_huevo_ppr()" style="width:120px" id="aviario" name="aviario" class=" tablagrilla form-control">
                                                <option class="text-center" ></option>
                                                <option class="text-center" value="A2">A2</option>
                                                <option class="text-center" value="A3">A3</option>
                                                <option class="text-center" value="A4">A4</option>
                                                <option class="text-center" value="A5">A5</option>
                                                <option class="text-center" value="A6">A6</option>
                                                <option class="text-center" value="A7">A7</option>
                                                <option class="text-center" value="A8">A8</option>
                                                <option class="text-center" value="A9">A9</option>
                                                <option class="text-center" value="A10">A10</option>
                                                <option class="text-center" value="A11">A11</option>
                                                <option class="text-center" value="A12">A12</option>
                                                <option class="text-center" value="B2">B2</option>
                                                <option class="text-center" value="B3">B3</option>
                                                <option class="text-center" value="B4">B4</option>
                                                <option class="text-center" value="B5">B5</option>
                                                <option class="text-center" value="B6">B6</option>
                                                <option class="text-center" value="B7">B7</option>
                                                <option class="text-center" value="B8">B8</option>
                                                <option class="text-center" value="B9">B9</option>
                                                <option class="text-center" value="B10">B10</option>
                                                <option class="text-center" value="B11">B11</option>
                                            </select>
                        </center></th>
                        
                        <th class="tablagrilla">
                         
                              <label class="tablagrilla">Fecha </label>
                         
                          <center>
                              <input onchange="ocultar_ppr(),consulta_lote_huevo_ppr()"  type="date" id="fecha" step="1 name="fecha" min="2014-10-01" class="tablagrilla form-control text-center" required="">
                          </center></th>
                           <th class="tablagrilla">
                         
                          <label class="tablagrilla">Lote </label>
                         
                          <center>
                             <input type="text" value="" id="lote" name="lote" style="width:140px" class="tablagrilla form-control text-center" readonly="true">
                             <input type="text" value="" id="loteid" name="loteid" hidden="true" >
                          </center></th>
                            <th class="tablagrilla">
                         
                          <label class="tablagrilla">Tolerancia(%)</label>
                         
                          <center>
                           <input style="width:140px" type="number" value="3.0" id="tolerancia" name="tolerancia" 
                           step="0.1" min="0" class="text-center form-control form-control-sm cursor-pointer" required="">
                          </center></th>

                          
                         <th class="tablagrilla">
                        <center>
                            <div style="color: #ffffff"><label class="">brueb</label></div>
                        </center>
                        <center>
                            <div class="input-group-append">
                                <button type="button" id="buscar" name="buscar" onclick="consulta_contador_huevo_ppr(),grafico_resumen_periodo_ppr(),grafico_resumen_lote_ppr()" class="bg-navy form-control text-center cargar" ><i class="fa fa-search"></i></button>
                                  
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
                    <center>
                    <br>
  
          <div id="tabla_contador" class="caja1 ocultar" style="width:1030px"></div>
           <div id="tabla_contador1" class="caja1" style="width:1030px"></div>
          <div  class=" text-center  ocultar " style="width:1030px">
          <div class="mt-4 row " style="width:1030px" >
       <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder">Huevos</label>
                <input type="text" value="" id="huevos" name="huevos" class="text-center form-control form-control-sm" readonly="">
            </div>
        </div>
        <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder"><b></b>Productividad(%)</label>
                <b></b> <input  type="text" value="" id="henday" name="henday" class="text-center form-control form-control-sm" readonly="">
            </div>
        </div>
        <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder">Productividad padrón (%)</label>
                <input type="text"  value="" id="phenday" name="phenday" class="text-center form-control form-control-sm" readonly="">
                <input type="hidden" value="" id="phen" name="phen">
            </div>
        </div>
        <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder">Dif. Prod. Padrón (%)</label>
                <input type="text" value="" style="color:white" id="diff" name="diff" class="form-control form-control-sm text-center id_diferen " readonly="">               
            </div>
        </div>
        <div class="col-12 col-md-3"> 
            <div class="form-group">
                <label class="form-control-placeholder">Edad días (sem)</label>
                <input type="text" value="" id="edad" name="edad" class="text-center form-control form-control-sm" readonly="">
            </div>
        </div>
        <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder">Prom. huevos/fila</label>
                <input type="text" value="" id="promfila" name="promfila" class="text-center form-control form-control-sm" readonly="">
            </div>
        </div>
        <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder">Máx. huevos/fila</label>
                <input type="text" value="" id="maxfila" name="maxfila" class="text-center form-control form-control-sm" readonly="">
            </div>
        </div>
        <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder">Mín. huevos/fila</label>
                <input type="text" value="" id="minfila" name="minfila" class="text-center form-control form-control-sm" readonly="">
            </div>
        </div>
       
    </div>
         </div>     
             <center>
             
                 <h5 class="text-center  ocultar"><b>HUEVOS ACUMULADO DEL PERIODO</b></h5>
           
               <div  class=" text-center  ocultar " style="width:1030px">
          <div class="mt-4 row " style="width:1030px" >
           
        <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder"><b>Periodo de fecha</b></label>
                <input type="text" value="" id="periodo_fecha_huevos" name="periodo_fecha_huevos" class="text-center form-control form-control-sm" readonly="">
            </div>
        </div>
        <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder"><b>Total Huevos acum.</b></label>
                <input type="text" value="" id="total_periodo" name="total_periodo" class="text-center form-control form-control-sm" readonly="">
            </div>
        </div>
        <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder"><b>Prom. acum./fila</b></label>
                <input type="text" value="" id="prom_fila" name="prom_fila" class="text-center form-control form-control-sm" readonly="">
                <input type="hidden" value="" id="phen" name="phen">
            </div>
        </div>
       
       </div>
         </div> 
         <div id="tabla_contador_periodo" class=" tablagrilla input-group-append ocultar"></div>
                   
                     <h5 class="text-center  ocultar"><b>MORTANDAD ACUMULADO DEL PERIODO</b></h5>
                          <div  class=" text-center  ocultar " style="width:1030px">
          <div class="mt-4 row " style="width:1030px" >
           
        <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder">Periodo de fecha</label>
                <input type="text" value="" id="periodo_fecha_mortandad" name="periodo_fecha_mortandad" class="text-center form-control form-control-sm" readonly="">
            </div>
        </div>
        <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder">Total Muertos acum.</label>
                <input type="text" value="" id="muerte_acum_periodo" name="muerte_acum_periodo" class="text-center form-control form-control-sm" readonly="">
            </div>
        </div>
        <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder">Prom. acum./fila</label>
                <input type="text" value="" id="prom_mor_fila" name="prom_mor_fila" class="text-center form-control form-control-sm" readonly="">
                <input type="hidden" value="" id="phen" name="phen">
            </div>
        </div>
       
       </div>
         </div> 
                     <center>
                    <div id="tabla_mortandad_periodo" class=" tablagrilla input-group-append ocultar"></div>
                    </center>
                     <h5 class="text-center  ocultar"><b>MORTANDAD ACUMULADO GLOBAL  DEL LOTE</b></h5>
                          <div  class=" text-center  ocultar " style="width:1030px">
          <div class="mt-4 row " style="width:1030px" >
           
        <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder">Total Muertos acum.</label>
                <input type="text" value="" id="total_mor_global" name="total_mor_global" class="text-center form-control form-control-sm" readonly="">
            </div>
        </div>
        <div class="col-12 col-md-2">
            <div class="form-group">
                <label class="form-control-placeholder">Prom. acum./fila</label>
                <input type="text" value="" id="total_global_fila" name="total_global_fila" class="text-center form-control form-control-sm" readonly="">
            </div>
        </div>
        
       
       </div>
         </div> 
                     <center>
                    <div id="tabla_mortandad_global" class=" tablagrilla input-group-append ocultar"></div>
                    </center>
                    <center>
                    <div id="grafico_resumen" style="width:1030px " class="ocultar"></div>
                    </center>
                    <center>
                    <div id="grafico_resumen_lote" style="width:1030px " class="ocultar"></div>
                    </center>
                    
                     
           <div  class="modal fade" id="modal_huevo_resumen" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
        <div class="modal-dialog modal-xl"  role="document">
            <div class="modal-content">
              <div   style="width: 100%" id="fila_huevo_contador2" class="modal-body"> </div>
              </div>
        </div>
          </div> 
       </center> 
                </div>
           
            </section>
        </div>
  <div  class="modal fade" id="modal_reportere2" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
        <div class="modal-dialog modal-xl"  role="document">
            
            <div class="modal-content">
                <div class="modal-header">        
             <h4 class="modal-title">informe ejemplo n8</h4> 
             
                 <button type="button" class="close" data-dismiss="modal">×</button></div> 
                 <h4 >RUTA</h4> 
            
                 <img src="img/img_aldo/contadorhuevo1.PNG"  width="200" height="70"/>
                 <img src="img/img_aldo/contadorhuevo2.PNG"   width="1000" height="500"/>
               
             
             
                  
            </div>
        </div>
    </div> 