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
     String version=clases.versiones.contenedores_ppr_vista_informe_consumo_balanceado_bloque;
 
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
    <center><b>CONSUMO BALANCEADO POR BLOQUES</b></center>
</div>
   </div>  <br> 
   
   
 <div class="card m-4">
            <input type="hidden" value="2" id="udepartamento" name="udepartamento">
            <section class="content" id="contenido">
                <div class="text-center">
                     
                    <table id="tabla" name="tabla" class=" tablagrilla compact-cs">
                        <th class="tablagrilla">
                        <center>
                            <label class="tablagrilla">Mes</label>
                        </center>
                        <center>
                            <select onchange="ocultar()" style="width:120px" id="mes_mort" name="mes_mort" class=" tablagrilla form-control">
                                <option class="text-center" value="01">Enero</option>
                                <option class="text-center" value="02">Febrero</option>
                                <option class="text-center" value="03">Marzo</option>
                                <option class="text-center" value="04">Abril</option>
                                <option class="text-center" value="05">Mayo</option>
                                <option class="text-center" value="06">Junio</option>
                                <option class="text-center" value="07">Julio</option>
                                <option class="text-center" value="08">Agosto</option>
                                <option class="text-center" value="09">Setiembre</option>
                                <option class="text-center" value="10">Octubre</option>
                                <option class="text-center" value="11">Noviembre</option>
                                <option class="text-center" value="12">Diciembre</option>
                            </select>
                        </center></th>
                        <th class="tablagrilla">
                        <center>
                            <label class="tablagrilla">Año</label>
                        </center>
                        <center>
                            <input onchange="ocultar()" style="width:120px" type="number" id="ano_mort" step="1" name="ano_mort" class="tablagrilla form-control text-center" required="true" value="2022">
                        </center>
                        </th>

                        <th class="tablagrilla">
                        <center>
                            <div style="color: #ffffff"><label class="">brueb</label></div>
                        </center>
                        <center>
                            <div class="input-group-append">
                                <button type="button" id="buscar" name="buscar" onclick="consulta_balanceado_bloque2_ppr()" class="bg-navy form-control text-center cargar" ><i class="fa fa-search"></i></button>
                                  
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
                    <div id="tabla_a" class=" tablagrilla input-group-append ocultar"></div>
                    </center>
                     <center>
                    <br>
                    <div id="tabla_b" class=" tablagrilla input-group-append ocultar"></div>
                     </center><!-- v -->
                      <center>
                    <br>
                    <div id="tabla_h" class=" tablagrilla input-group-append ocultar"></div>
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
            
                 <img src="img/img_aldo/Captura_infrom.PNG"  width="200" height="70"/>
                 <img src=" img/img_aldo/Captura2.PNG"  width="500" height="50"/>
                 <img src="img/img_aldo/Captura.PNG"   width="1000" height="500"/>
                 
              
                  
            </div>
        </div>
    </div> 