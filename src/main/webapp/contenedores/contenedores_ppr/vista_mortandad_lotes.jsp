<%-- 
    Document   : vista_mortandad_lotes
    Created on : 03/02/2022, 07:45:22
    Author     : csanchez
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
            document.getElementById("idfechadesde").setAttribute("max", today);
            document.getElementById("idfechahasta").setAttribute("max", today);

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

            setInputDate("#idfechadesde");
            setInputDate("#idfechahasta");

        </script>
        <%@include  file="../../versiones.jsp" %>

         <% 
     String version= contenedores_ppr_vista_mortandad_lotes;
 
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
    <center><b>MORTANDAD POR LOTES (ORDENADAS POR MORTANDAD)</b></center>
</div>
   </div>  <br> 
   
   
   <div class="card m-4">
            <input type="hidden" value="2" id="udepartamento" name="udepartamento">
            <section id="contenido">
                <div class="text-center">
                     
                    <table id="tabla" name="tabla" class=" tablagrilla compact-cs">
                        <th class="tablagrilla">
                        <center>
                            <label class="tablagrilla">Mes</label>
                        </center>
                        <center>
                            <select onchange="ocultar()" style="width:120px" id="meslote" name="meslote" class=" tablagrilla form-control">
                                <option class="text-center" value="1">Enero</option>
                                <option class="text-center" value="2">Febrero</option>
                                <option class="text-center" value="3">Marzo</option>
                                <option class="text-center" value="4">Abril</option>
                                <option class="text-center" value="5">Mayo</option>
                                <option class="text-center" value="6">Junio</option>
                                <option class="text-center" value="7">Julio</option>
                                <option class="text-center" value="8">Agosto</option>
                                <option class="text-center" value="9">Setiembre</option>
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
                            <input onchange="ocultar_ppr()" style="width:120px" type="number" id="anolote" step="1" name="anolote" class="tablagrilla form-control text-center" required="true" value="2022">
                        </center>
                        </th>

                        <th class="tablagrilla">
                        <center>
                            <div style="color: #ffffff"><label class="">brueb</label></div>
                        </center>
                        <center>
                            <div class="input-group-append">
                                <button type="button" id="buscar" name="buscar" onclick="lote_mortandad_ppr()" class="bg-navy form-control text-center cargar" ><i class="fa fa-search"></i></button>
                                    <%-- 
                                    <button type="button" id="buscar" name="buscar" onclick="llamar_temp_mortandad_lotes()" class="bg-gradient-white form-control text-center cargar" ><img src="img/botonmuestra.png" height="40" width="500" alt=""/></button>
                                    --%>
                            </div>
                        </center></th>
                    </table>
                    <br>
                    <center>
                        <%-- 
                        <div id="btn_excel" class=" tablagrilla ocultar"><button type="button" id="excel" name="excel" onclick="exportTableToExcel()" class="bg-huevos-light form-control text-center cargar btn-excel tablagrilla" ><i class="fa fa-file-excel tablagrilla"> Exportar a MS Excel</i></button>
                        --%>
                            <div id="btn_excel" class=" tablagrilla ocultar">
                                <button type="button" id="excel" name="excel" onclick="ExportToExcel_ppr(jQuery('#datosmorlote').prop('outerHTML'))" class="bg-huevos-light form-control text-center cargar btn-excel tablagrilla" ><i class="fa fa-file-excel tablagrilla"> Exportar a MS Excel</i></button>
                        </div>

                    </center>
                    <br>
                    
                    <div id="tabla_mortandad_lotes" class="h_d text-center tablagrilla input-group-append ocultar">
                        
                    </div>
                </div>
                </center>
            </section>
        </div>
