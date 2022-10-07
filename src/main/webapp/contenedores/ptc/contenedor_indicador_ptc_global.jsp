<%-- 
    Document   : contenedor_clasificadora_dinamica
    Created on : 24/03/2022, 14:28:40
    Author     : csanchez
--%>
    <form    id="form_reporte_dinamicop_clasificadora"  name="form_reporte_dinamicop_clasificadora" method="post" >

    <table id="tabla_principall2"  class="table table-bordered  datat">
            <thead>
                <tr>
                    <th  class="text-center bg-navy"  colspan="5">Indicadores globales</th>
                 </tr>
                <tr>
                    <th>DESDE</th>
                    <th>HASTA</th>
                    <th>CLASIFICADORA</th>
                    <th>SERIE(%)</th> 
                  <th class="text-center" colspan="2">ACCIONES</th>
                </tr>
            </thead>   
            <tbody>
                <tr>  
                    <td>  
                        <input type="date" id="fecha_desde_cla" name="fecha_desde_cla">
                    </td>
                    <td>   
                        <input type="date" id="fecha_hasta_cla" name="fecha_hasta_cla">
                    </td>
                    
                   
                    <td><select class="selectpicker" multiple data-live-search="true" id="clasif_cla" name="clasif_cla"  required="true" data-actions-box="true">
                            <option class="text-center" value="A">CCHA  </option>
                            <option class="text-center" value="B">CCHB  </option>
                            <option class="text-center" value="H">CCHH  </option>
                            <option class="text-center" value="O">LAVADOS  </option>

                        </select></td>
                     
 

                    <td><select class="selectpicker" multiple data-live-search="true" id="categorias2_cla" name="categorias2_cla"  required="true" data-actions-box="true">
                            <option class="text-center" value=ptcc>   PTC</option>
                            <option class="text-center" value=rpp> REPROCESO</option>
                            <option class="text-center" value=pii>     SUBPRODUCTO</option>
                            <option class="text-center" value=rr>     ROTOS</option>
                        </select>
                    </td>
                   
                     
                    <td>
                        <input type='hidden' value='1' id='ser'>
                         <button class="btn btn-xs bg-navy"   title="BUSCAR">  <i class="fa fa-search"></i></button>
                         <div class="btn btn-xs bg-navy" onclick="generar_cuadros_consultas_clasificadora_dinamicos_ptc()" title="MAS CUADROS"><i class="fa fa-plus"></i></div>
                     </td>              
                </tr>
            </tbody>
        </table>
    </form> 
    
    


<div  id="div_graficop_clasificadora"  ></div>
<div  id="div_graficop_total"  ></div>
<div  id="div_principal_clasificadora"  ></div> 



