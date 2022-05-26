<%-- 
    Document   : informes
    Created on : 31-dic-2021, 17:40:59
    Author     : aespinola
--%>
<% 
     String version=clases.versiones.contenedores_ppr_vista_informe_aviarios_dinamico;
 
 %> 
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')">
    <label neme="label_contenido" id="label_contenido"><%=version%></label>  
</div>
</head>
<div  >
    <form    id="form_reporte_aviario_dinamicop"  type="post" action="footer3" >
      
<div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PPR
</div>
</div>
    <center><b>GRAFICO / RESUMEN PRODUCCION PRIMARIA</b></center>
</div>
   </div>  <br>        <table id="tabla_principal"  class="table table-bordered table-hover datat" >
            <thead>
                <tr>
                    <th>DESDE</th>
                    <th>HASTA</th>
                    <th>AVIARIO</th>
                    <th>SERIE</th>
                    <th>TIPO RESULTADO</th>
                    <th>TIPO GRAFICO</th>
                    <th>BUSQUEDA</th>
                    <th>CUADROS</th>
                </tr>
            </thead>   
            <tbody>
                <tr>  
                    <td>  
                        <input type="date" id="fecha_desde"  name="fecha_desde">
                    </td>
                    <td>   
                        <input type="date" id="fecha_hasta" name="fecha_hasta">
                    </td>
                    <td><select class="selectpicker "  multiple data-live-search="true" name="aviarios"  required="true" data-actions-box="true">
                            <option class="text-center" value="A2">A2  </option>
                            <option class="text-center" value="A3">A3  </option>
                            <option class="text-center" value="A4">A4  </option>
                            <option class="text-center" value="A6">A6  </option>
                            <option class="text-center" value="A7">A7  </option>
                            <option class="text-center" value="A8">A8  </option>
                            <option class="text-center" value="A9">A9  </option>
                            <option class="text-center"value="A10">A10</option>
                            <option class="text-center"value="A11">A11</option>
                            <option class="text-center" value="A12">A12</option>
                            <option class="text-center" value="B2">B2  </option>
                            <option class="text-center" value="B3">B3  </option>
                            <option class="text-center" value="B4">B4  </option>
                            <option class="text-center" value="B5">B5  </option>
                            <option class="text-center" value="B6">B6</option>
                            <option class="text-center" value="B7">B7</option>
                            <option class="text-center" value="B8">B8</option>
                            <option class="text-center" value="B9">B9</option>
                            <option class="text-center" value="B10">B10</option>
                            <option class="text-center" value="B11">B11</option>
                            <option class="text-center" value="H1">H1</option>
                            <option class="text-center" value="H2">H2</option>
                            <option class="text-center" value="H3">H3</option>
                        </select></td>
                    <td><select  class="selectpicker" multiple data-live-search="true" name="categorias"  required="true" data-actions-box="true">
                            <option value=mortandadd>   Mortandad</option>
                            <option value=consumo_ball> Consumo de Balanceados</option>
                            <option value=producto>     Productividad</option>
                            <option value=caudalime>    Consumo de Agua</option>
                            <option  value=temp_mini>   Tem. Min.</option>
                            <option value=temp_maxi>    Tem. Max.</option>
                            <option value=huevo>        Produccion Huevo</option>
                            <option value=pad_bala>     Pad. Bal</option>
                            <option value=pad_produ>    Pad. Prod</option>
                        </select>
                    </td>
                    <td>
                        <select   name="tipoConsulta" class="btn btn-sm  bg-navy">
                            <option class="text-center" value="suma">    Suma</option>
                            <option class="text-center" value="promedio">Promedio</option>
                            <option class="text-center" value="minimo">  Minimo</option>
                            <option class="text-center" value="maximo">  Maximo</option>
                        </select>
                    </td>
                    <td><select name="tipo_grafico" class="btn btn-sm  bg-navy">
                            <option class="text-center" value="line">Lineal</option>
                            <option class="text-center" value="bar">Barra</option>
                        </select>
                    </td>
                    <td>
                        <button type="submit" class="btn btn-sm  bg-navy btn-block" ><i class="fa fa-search"></i> Buscar</button>
                    </td>
                    <td>
                        <button type="button" class="btn btn-sm  bg-navy btn-block" onclick="generar_cuadros_consultas_aviarios_dinamicos_ppr()"><i class="fa fa-plus"></i> Mas cuadros</button>
                    </td>              
                </tr>
            </tbody>
        </table>
    </form> 


    <div  id="div_graficop"  ></div>

    </div>   



<div  id="div_principal"  ></div>





