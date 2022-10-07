<%-- 
    Document   : contenedor_clasificadora_dinamica
    Created on : 24/03/2022, 14:28:40
    Author     : csanchez
--%>
<form    id="form_indicadores_detallados"   method="post" >

    <table   class="table table-bordered  datat">
        <thead>
            <tr>
                <th  class="text-center bg-danger"  colspan="5">Indicadores detallados por tipos Subproductos, Reprocesos y PTC</th>
            </tr>
            <tr>
                <th>DESDE</th>
                <th>HASTA</th>
                <th>CLASIFICADORA</th>
                <th>TIPO GRAFICO</th>
                <th>ACCIONES</th>
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

                    </select>
                </td>
                <td><select class="selectpicker"  id="tipo_grafico"  required="true" data-actions-box="true">
                        <option class="text-center" value="bar">BARRA  </option>
                        <option class="text-center" value="pie">CIRCULAR  </option> 

                    </select>
                </td>
                <td>
                    <input type='hidden' value='1' id='ser'>
                    <button class="btn btn-xs bg-navy"   title="BUSCAR">  <i class="fa fa-search"></i></button>
                </td>              
            </tr>
        </tbody>
    </table>
</form> 
 
<div  id="div_grilla_detalle"  ></div>


<div  id="div_graficop_clasificadora"  ></div>
 
 
